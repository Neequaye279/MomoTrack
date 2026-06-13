import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:momo_track/view/widgets/progress_stepper.dart';
import 'package:momo_track/view/widgets/my_textfield.dart';
import 'package:momo_track/view/widgets/screen_button.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
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
                    SizedBox(width: screenWidth * 0.03),
                    Expanded(child: ProgressStepper(currentStep: 0)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.06),
                Text(
                  "Create account",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Start tracking your MoMo transactions",
                  style: TextStyle(fontSize: 15.0, color: Color(0xFF8B8D98)),
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  "FULL NAME",
                  style: TextStyle(
                    fontSize: 13.0,
                    letterSpacing: 1.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                MyTextfield(
                  hintText: "Eliakim Neequaye",
                  prefixIcon: Icon(LucideIcons.user),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  "PHONE NUMBER (MOMO-LINKED)",
                  style: TextStyle(
                    fontSize: 13.0,
                    letterSpacing: 1.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                MyTextfield(
                  hintText: "024 XXX XXXX",
                  prefixIcon: Icon(LucideIcons.phone),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  "EMAIL ADDRESS",
                  style: TextStyle(
                    fontSize: 13.0,
                    letterSpacing: 1.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                MyTextfield(
                  hintText: "you@email.com",
                  prefixIcon: Icon(LucideIcons.mail),
                ),
                SizedBox(height: screenHeight * 0.03),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14.0),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      width: 1.0,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        LucideIcons.circleAlert,
                        size: 15.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "Your number must be linked to your MoMo\nwallet so we can read transactions",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                ScreenButton(
                  buttonText: "Continue",
                  background: Theme.of(context).colorScheme.primary,
                  foreground: Theme.of(context).colorScheme.onPrimary,
                  onPressed: () {
                    Navigator.pushNamed(context, '/verification');
                  },
                ),
                SizedBox(height: screenHeight * 0.04),
                Center(
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(fontSize: 14.0),
                      children: [
                        TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Color(0xFF8B8D98)),
                        ),
                        TextSpan(
                          text: "Sign In",
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
