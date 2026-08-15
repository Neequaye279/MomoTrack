import '../services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum OtpStatus { idle, sending, sent, verifying, verified, error, expired }

class OtpState {
  final OtpStatus status;
  final String? mockCode;
  final String? errorMessage;

  const OtpState({
    this.status = OtpStatus.idle,
    this.mockCode,
    this.errorMessage,
  });

  OtpState copyWith({
    OtpStatus? status,
    String? mockCode,
    String? errorMessage,
  }) {
    return OtpState(
      status: status ?? this.status,
      mockCode: mockCode ?? this.mockCode,
      errorMessage: errorMessage,
    );
  }
}

class OtpNotifier extends Notifier<OtpState> {
  late final AuthService _authService;
  String? _phoneNumber;

  @override
  OtpState build() {
    _authService = ref.watch(authServiceProvider);
    return const OtpState();
  }

  Future<void> sendOtp(String phoneNumber) async {
    _phoneNumber = phoneNumber;
    state = state.copyWith(status: OtpStatus.sending);
    try {
      final code = await _authService.requestOtp(phoneNumber);
      state = state.copyWith(status: OtpStatus.sent, mockCode: code);
    } catch (e) {
      state = state.copyWith(
        status: OtpStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> verify(String enteredCode) async {
    if (_phoneNumber == null) return;
    state = state.copyWith(status: OtpStatus.verifying);
    try {
      final isValid = await _authService.verifyOtp(_phoneNumber!, enteredCode);
      state = state.copyWith(
        status: isValid ? OtpStatus.verified : OtpStatus.error,
        errorMessage: isValid ? null : 'Invalid or expired code',
      );
    } catch (e) {
      state = state.copyWith(
        status: OtpStatus.error,
        errorMessage: e.toString(),
      );
    }
  }
}

final otpProvider = NotifierProvider<OtpNotifier, OtpState>(OtpNotifier.new);
