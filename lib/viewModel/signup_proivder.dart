import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupData {
  final String fullName;
  final String phoneNumber;
  final String email;
  final bool hasAttemptedSubmit;

  const SignupData({
    this.fullName = '',
    this.phoneNumber = '',
    this.email = '',
    this.hasAttemptedSubmit = false,
  });

  SignupData copyWith({
    String? fullName,
    String? phoneNumber,
    String? email,
    bool? hasAttemptedSubmit,
  }) {
    return SignupData(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      hasAttemptedSubmit: hasAttemptedSubmit ?? this.hasAttemptedSubmit,
    );
  }
}

class SignupNotifier extends Notifier<SignupData> {
  @override
  SignupData build() => const SignupData();

  void updateFullName(String value) => state = state.copyWith(fullName: value);
  void updatePhoneNumber(String value) =>
      state = state.copyWith(phoneNumber: value);
  void updateEmail(String value) => state = state.copyWith(email: value);

  void markSubmitAttempted() =>
      state = state.copyWith(hasAttemptedSubmit: true);

  void clear() => state = const SignupData();
}

final signupProvider = NotifierProvider<SignupNotifier, SignupData>(
  SignupNotifier.new,
);
