import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupData {
  final String fullName;
  final String phoneNumber;
  final String email;

  const SignupData({
    this.fullName = '',
    this.phoneNumber = '',
    this.email = '',
  });

  SignupData copyWith({String? fullName, String? phoneNumber, String? email}) {
    return SignupData(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
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

  void clear() => state = const SignupData();
}

final signupProvider = NotifierProvider<SignupNotifier, SignupData>(
  SignupNotifier.new,
);
