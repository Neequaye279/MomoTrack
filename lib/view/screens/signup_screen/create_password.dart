import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:momo_track/view/widgets/progress_stepper.dart';
import 'package:momo_track/view/widgets/my_textfield.dart';
import 'package:momo_track/view/widgets/screen_button.dart';
import 'package:momo_track/view/widgets/requirement_row.dart';

class CreatePassword extends StatelessWidget {
  const CreatePassword({super.key});

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
                    Expanded(child: ProgressStepper(currentStep: 2)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  "Create a Password",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  "Choose a strong password",
                  style: TextStyle(color: Color(0xFF8B8D98), fontSize: 16.0),
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
                              "Use PIN",
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
                            "Use Password",
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
                SizedBox(height: screenHeight * 0.04),
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
                  hintText: "Create a password",
                  prefixIcon: Icon(LucideIcons.mail, color: Color(0xFF8B8D98)),
                  suffixIcon: Icon(LucideIcons.eye, color: Color(0xFF8B8D98)),
                ),
                SizedBox(height: screenHeight * 0.05),
                Text(
                  "CONFIRM PASSWORD",
                  style: TextStyle(
                    fontSize: 13.0,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B8D98),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                MyTextfield(
                  hintText: "Re-enter your password",
                  prefixIcon: Icon(LucideIcons.lock, color: Color(0xFF8B8D98)),
                  suffixIcon: Icon(LucideIcons.eye, color: Color(0xFF8B8D98)),
                ),
                SizedBox(height: screenHeight * 0.02),
                RequirementRow(
                  text: "At least 8 characters",
                  isCompleted: true,
                ),
                SizedBox(height: screenHeight * 0.01),
                RequirementRow(
                  text: "One Uppercase letter",
                  isCompleted: false,
                ),
                SizedBox(height: screenHeight * 0.01),
                RequirementRow(
                  text: "One Uppercase letter",
                  isCompleted: false,
                ),
                SizedBox(height: screenHeight * 0.03),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14.0),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.tertiary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      width: 1.0,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        LucideIcons.alertTriangle,
                        size: 15.0,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "Never share your password with anyone, including\nsupport.",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                ScreenButton(
                  buttonText: "Continue",
                  background: Theme.of(context).colorScheme.primary,
                  foreground: Theme.of(context).colorScheme.onPrimary,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
