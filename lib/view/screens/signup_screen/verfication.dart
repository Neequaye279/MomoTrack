import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:momo_track/view/widgets/progress_stepper.dart';
import 'package:momo_track/view/widgets/screen_button.dart';

class Verfication extends StatelessWidget {
  const Verfication({super.key});

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
                    Expanded(child: ProgressStepper(currentStep: 1)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.05),
                Text(
                  "Verify your number",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 15.0, letterSpacing: 0.5),
                    children: [
                      TextSpan(
                        text: "Code sent to",
                        style: TextStyle(color: Color(0xFF8B8D98)),
                      ),
                      TextSpan(
                        text: " 024 700 8312",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Color(0xFF8B8D98)),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 14.0,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Expires in 4:52",
                      style: TextStyle(
                        color: Color(0xFF8B8D98),
                        fontSize: 13.0,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Resend Code",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
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
