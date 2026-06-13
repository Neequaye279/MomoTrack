import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:momo_track/view/widgets/progress_stepper.dart';
import 'package:momo_track/view/widgets/screen_button.dart';
import 'package:momo_track/view/widgets/biometric_card.dart';

class Biometrics extends StatelessWidget {
  const Biometrics({super.key});

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
                    Expanded(child: ProgressStepper(currentStep: 3)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  "Enable biometrics",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  "Log in faster with fingerprint or face unlock",
                  style: TextStyle(color: Color(0xFF8B8D98), fontSize: 16.0),
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: BiometricCard(
                        icon: LucideIcons.fingerprint,
                        title: "Fingerprint",
                        subtitle: "Touch Sensor",
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: BiometricCard(
                        icon: LucideIcons.scanFace,
                        title: "Face ID",
                        subtitle: "Look at camera",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                ScreenButton(
                  buttonText: "Enable & Get Started",
                  background: Theme.of(context).colorScheme.primary,
                  foreground: Theme.of(context).colorScheme.onPrimary,
                  onPressed: () {},
                ),
                SizedBox(height: screenHeight * 0.02),
                ScreenButton(
                  buttonText: "Skip for now",
                  background: Theme.of(context).colorScheme.surface,
                  foreground: Colors.grey,
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
