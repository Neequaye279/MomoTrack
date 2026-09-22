import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:momo_track/view/widgets/my_textfield.dart';
import 'package:momo_track/view/widgets/screen_button.dart';
import 'package:momo_track/viewModel/password_form_provider.dart';
import 'package:momo_track/viewModel/biometric_provider.dart';
import 'package:momo_track/services/auth_service.dart';

class PasswordLoginScreen extends ConsumerStatefulWidget {
  const PasswordLoginScreen({super.key});

  @override
  ConsumerState<PasswordLoginScreen> createState() =>
      _PasswordLoginScreenState();
}

class _PasswordLoginScreenState extends ConsumerState<PasswordLoginScreen> {
  bool _isBiometricLoading = false;

  Future<void> _handleBiometricLogin() async {
    setState(() => _isBiometricLoading = true);
    try {
      await ref.read(authServiceProvider).signInWithBiometrics();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Biometric login failed: $e')));
    }
    if (mounted) setState(() => _isBiometricLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final loginState = ref.watch(loginFormProvider);
    ref.listen(loginFormProvider, (previous, next) {
      if (next.status == AuthFormStatus.error) {
        Future.delayed(const Duration(seconds: 3), () {
          ref.read(loginFormProvider.notifier).clearStatus();
        });
      }
    });
    final isSubmitting = loginState.status == AuthFormStatus.submitting;
    final biometricAvailable = ref.watch(biometricsEnabledLocalProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceBright,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.05),
                      width: 1.0,
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(LucideIcons.chevronLeft),
                    color: Color(0xFF8B8D98),
                    iconSize: 18.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  "Welcome back",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: screenHeight * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "Sign in to your MoMoTrack Account",
                  style: TextStyle(
                    color: Color(0xFF8B8D98),
                    fontSize: screenHeight * 0.02,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  "EMAIL ADDRESS",
                  style: TextStyle(
                    fontSize: 13.0,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B8D98),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                MyTextfield(
                  hintText: "your@email.com",
                  prefixIcon: Icon(LucideIcons.mail, color: Color(0xFF8B8D98)),
                  onChanged: (value) =>
                      ref.read(loginFormProvider.notifier).updateEmail(value),
                ),
                SizedBox(height: screenHeight * 0.05),
                Text(
                  "PASSWORD",
                  style: TextStyle(
                    fontSize: 13.0,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B8D98),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                MyTextfield(
                  hintText: "Enter your password",
                  prefixIcon: Icon(LucideIcons.lock, color: Color(0xFF8B8D98)),
                  obscureText: true,
                  onChanged: (value) => ref
                      .read(loginFormProvider.notifier)
                      .updatePassword(value),
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                if (loginState.status == AuthFormStatus.error &&
                    loginState.errorMessage != null)
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.015),
                    child: Text(
                      loginState.errorMessage!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                SizedBox(height: screenHeight * 0.04),
                ScreenButton(
                  buttonText: isSubmitting ? "Signing in..." : "Sign In",
                  foreground: Theme.of(context).colorScheme.onPrimary,
                  background: Theme.of(context).colorScheme.primary,
                  onPressed: isSubmitting
                      ? () {}
                      : () async {
                          final success = await ref
                              .read(loginFormProvider.notifier)
                              .submit();
                          if (!success || !context.mounted) return;

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                            (route) => false,
                          );
                          ref
                              .read(biometricProvider.notifier)
                              .promptAndEnableInBackground();
                        },
                ),
                SizedBox(height: screenHeight * 0.05),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      ref.read(loginFormProvider.notifier).clear();
                      Navigator.pushReplacementNamed(context, '/createaccount');
                    },
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(fontSize: 14.0),
                        children: [
                          TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(color: Color(0xFF8B8D98)),
                          ),
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Center(
                  child: Column(
                    children: [
                      biometricAvailable.when(
                        data: (available) => available
                            ? GestureDetector(
                                onTap: _isBiometricLoading
                                    ? null
                                    : _handleBiometricLogin,
                                child: Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).colorScheme.primary
                                        .withValues(alpha: 0.08),
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withValues(alpha: 0.4),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Icon(
                                    LucideIcons.fingerprint,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    size: 32.0,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                      ),
                      biometricAvailable.when(
                        data: (available) => available
                            ? Padding(
                                padding: EdgeInsets.only(
                                  top: screenHeight * 0.015,
                                ),
                                child: Text(
                                  "BIOMETRIC LOGIN",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
