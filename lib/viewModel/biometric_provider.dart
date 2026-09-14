import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momo_track/services/auth_service.dart';
import 'package:momo_track/main.dart';
import 'package:flutter/material.dart';

enum BiometricStatus { idle, checking, enabling, enabled, failed, unsupported }

class BiometricState {
  final BiometricStatus status;
  final String? errorMessage;

  const BiometricState({this.status = BiometricStatus.idle, this.errorMessage});

  BiometricState copyWith({BiometricStatus? status, String? errorMessage}) {
    return BiometricState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}

class BiometricNotifier extends Notifier<BiometricState> {
  @override
  BiometricState build() => const BiometricState();

  Future<void> enableBiometrics() async {
    state = state.copyWith(status: BiometricStatus.checking);

    final canUse = await ref.read(authServiceProvider).canUseBiometrics();
    if (!canUse) {
      state = state.copyWith(
        status: BiometricStatus.unsupported,
        errorMessage: 'Biometrics not available on this device',
      );
      return;
    }

    state = state.copyWith(status: BiometricStatus.enabling);
    final success = await ref
        .read(authServiceProvider)
        .authenticateWithBiometrics();

    if (success) {
      final authService = ref.read(authServiceProvider);
      await authService.setBiometricsEnabled(true);
      await authService.setBiometricsEnabledLocal(true);
      state = state.copyWith(status: BiometricStatus.enabled);
      ref.invalidate(biometricsEnabledLocalProvider);
    } else {
      state = state.copyWith(
        status: BiometricStatus.failed,
        errorMessage: 'Biometric authentication failed',
      );
    }
  }

  Future<bool> shouldPromptForBiometrics() async {
    final authService = ref.read(authServiceProvider);
    final canUse = await authService.canUseBiometrics();
    if (!canUse) return false;

    final alreadyEnabled = await authService.getBiometricsEnabled();
    return !alreadyEnabled;
  }

  Future<void> promptAndEnableInBackground() async {
    final shouldPrompt = await shouldPromptForBiometrics();
    if (!shouldPrompt) return;

    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: const Text('Use fingerprint or Face ID next time?'),
        action: SnackBarAction(
          label: 'Enable',
          onPressed: () {
            enableBiometrics();
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void skip() {
    state = state.copyWith(status: BiometricStatus.idle);
  }
}

final biometricProvider = NotifierProvider<BiometricNotifier, BiometricState>(
  BiometricNotifier.new,
);

// Session-free check for whether the login screens should show a
// fingerprint/Face ID shortcut button.
final biometricsEnabledLocalProvider = FutureProvider<bool>((ref) async {
  final authService = ref.read(authServiceProvider);
  final canUse = await authService.canUseBiometrics();
  if (!canUse) return false;
  return authService.getBiometricsEnabledLocal();
});
