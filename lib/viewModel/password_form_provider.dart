import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momo_track/services/auth_service.dart';

enum AuthFormStatus { idle, submitting, success, error }

// --- Create password (signup) ---

class CreatePasswordState {
  final String password;
  final String confirmPassword;
  final AuthFormStatus status;
  final String? errorMessage;

  const CreatePasswordState({
    this.password = '',
    this.confirmPassword = '',
    this.status = AuthFormStatus.idle,
    this.errorMessage,
  });

  CreatePasswordState copyWith({
    String? password,
    String? confirmPassword,
    AuthFormStatus? status,
    String? errorMessage,
  }) {
    return CreatePasswordState(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  bool get hasMinLength => password.length >= 8;
  bool get hasUppercase => password.contains(RegExp(r'[A-Z]'));
  bool get hasNumber => password.contains(RegExp(r'[0-9]'));
  bool get passwordsMatch => password.isNotEmpty && password == confirmPassword;
}

class CreatePasswordNotifier extends Notifier<CreatePasswordState> {
  @override
  CreatePasswordState build() => const CreatePasswordState();

  void updatePassword(String value) =>
      state = state.copyWith(password: value, status: AuthFormStatus.idle);

  void updateConfirmPassword(String value) => state = state.copyWith(
    confirmPassword: value,
    status: AuthFormStatus.idle,
  );

  Future<bool> submit(String email) async {
    if (!state.passwordsMatch || !state.hasMinLength) {
      state = state.copyWith(
        status: AuthFormStatus.error,
        errorMessage: 'Passwords must match and meet requirements',
      );
      return false;
    }

    state = state.copyWith(status: AuthFormStatus.submitting);
    try {
      await ref
          .read(authServiceProvider)
          .signUp(email: email, password: state.password);
      state = state.copyWith(status: AuthFormStatus.success);
      return true;
    } catch (e) {
      state = state.copyWith(
        status: AuthFormStatus.error,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  void clear() => state = const CreatePasswordState();
}

final createPasswordProvider =
    NotifierProvider<CreatePasswordNotifier, CreatePasswordState>(
      CreatePasswordNotifier.new,
    );

// --- Login (password) ---

class LoginFormState {
  final String email;
  final String password;
  final AuthFormStatus status;
  final String? errorMessage;

  const LoginFormState({
    this.email = '',
    this.password = '',
    this.status = AuthFormStatus.idle,
    this.errorMessage,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    AuthFormStatus? status,
    String? errorMessage,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}

class LoginFormNotifier extends Notifier<LoginFormState> {
  @override
  LoginFormState build() => const LoginFormState();

  void updateEmail(String value) =>
      state = state.copyWith(email: value, status: AuthFormStatus.idle);

  void updatePassword(String value) =>
      state = state.copyWith(password: value, status: AuthFormStatus.idle);

  Future<bool> submit() async {
    if (state.email.isEmpty || state.password.isEmpty) {
      state = state.copyWith(
        status: AuthFormStatus.error,
        errorMessage: 'Enter your email and password',
      );
      return false;
    }

    state = state.copyWith(status: AuthFormStatus.submitting);
    try {
      await ref
          .read(authServiceProvider)
          .signIn(email: state.email, password: state.password);
      state = state.copyWith(status: AuthFormStatus.success);
      return true;
    } catch (e) {
      state = state.copyWith(
        status: AuthFormStatus.error,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  void clear() => state = const LoginFormState();
}

final loginFormProvider = NotifierProvider<LoginFormNotifier, LoginFormState>(
  LoginFormNotifier.new,
);
