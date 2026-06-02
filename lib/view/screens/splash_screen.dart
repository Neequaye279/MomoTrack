import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:momo_track/view/widgets/animation_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/permissions');
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon container
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.2),
                    width: 1.0,
                  ),
                ),
                child: Icon(
                  LucideIcons.activity,
                  color: Theme.of(context).colorScheme.primary,
                  size: 35.0,
                ),
              ),

              const SizedBox(height: 10.0),

              // App name
              Text(
                'MoMoTrack',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 25.0,
                ),
              ),

              const SizedBox(height: 15.0),

              // Tagline
              const Text(
                'Mobile Money Intelligence',
                style: TextStyle(color: Color(0xFF8B8D98)),
              ),

              const SizedBox(height: 50.0),

              // Animated dots — separate widget
              const AnimatedDots(),
            ],
          ),
        ),
      ),
    );
  }
}
