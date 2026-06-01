import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:momo_track/view/widgets/permission_card.dart';
import 'package:momo_track/view/widgets/screen_button.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.16),
                    ),
                  ),
                  child: Icon(
                    LucideIcons.shield,
                    color: Theme.of(context).colorScheme.primary,
                    size: 32,
                  ),
                ),
                SizedBox(height: screenHeight * 0.06),
                Text(
                  "App Permissions",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.05,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  "MomoTrack needs these to work porperly.",
                  style: TextStyle(color: Color(0xFF8B8D98)),
                ),
                SizedBox(height: screenHeight * 0.05),
                PermissionCard(
                  icon: LucideIcons.messageSquarePlus,
                  title: "SMS Access",
                  description:
                      "Read incoming MoMo messages to log transactions automatically.",
                ),
                SizedBox(height: screenHeight * 0.02),
                PermissionCard(
                  icon: LucideIcons.bell,
                  title: "Notifications",
                  description:
                      "Instant alerts for new transactions and balance changes",
                ),
                SizedBox(height: screenHeight * 0.15),
                ScreenButton(
                  buttonText: "Allow & Continue",
                  background: Theme.of(context).colorScheme.primary,
                  foreground: Theme.of(context).colorScheme.onPrimary,
                ),
                SizedBox(height: screenHeight * 0.03),
                ScreenButton(
                  buttonText: "Skip for now",
                  background: Theme.of(context).colorScheme.surface,
                  foreground: Color(0xFF8B8D98),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
