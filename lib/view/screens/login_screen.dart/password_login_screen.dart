import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:momo_track/view/widgets/my_textfield.dart';
import 'package:momo_track/view/widgets/screen_button.dart';
import 'package:momo_track/viewModel/password_form_provider.dart';
import 'package:momo_track/viewModel/biometric_provider.dart';

class PasswordLoginScreen extends ConsumerWidget {
  const PasswordLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final loginState = ref.watch(loginFormProvider);
    final isSubmitting = loginState.status == AuthFormStatus.submitting;

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
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            ref.read(loginFormProvider.notifier).clear();
                            Navigator.pushReplacementNamed(
                              context,
                              '/pinlogin',
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(11.0),
                            ),
                            child: Text(
                              "PIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.4),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 11.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(11.0),
                          ),
                          child: Text(
                            "Password",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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

                          Navigator.pushReplacementNamed(context, '/home');
                          ref
                              .read(biometricProvider.notifier)
                              .promptAndEnableInBackground();
                        },
                ),
                SizedBox(height: screenHeight * 0.05),
                Center(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
