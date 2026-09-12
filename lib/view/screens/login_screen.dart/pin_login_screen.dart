import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:momo_track/view/widgets/pin_dots.dart';
import 'package:momo_track/view/widgets/numpad.dart';
import 'package:momo_track/viewModel/pin_provider.dart';
import 'package:momo_track/services/auth_service.dart';

class PinLoginScreen extends ConsumerStatefulWidget {
  const PinLoginScreen({super.key});

  @override
  ConsumerState<PinLoginScreen> createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends ConsumerState<PinLoginScreen> {
  bool _isVerifying = false;

  @override
  Widget build(BuildContext context) {
    ref.listen(loginPinProvider, (previous, next) async {
      if (next.length == 6 && !_isVerifying) {
        setState(() => _isVerifying = true);

        try {
          await ref.read(authServiceProvider).signInWithLocalPin(next);
          if (!mounted) return;
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Incorrect PIN')));
          ref.read(loginPinProvider.notifier).clear();
        }

        if (mounted) {
          setState(() => _isVerifying = false);
        }
      }
    });

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
                    iconSize: 20.0,
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
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(11.0),
                          ),
                          child: Text(
                            "PIN",
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
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            ref.read(loginPinProvider.notifier).clear();
                            Navigator.pushReplacementNamed(
                              context,
                              '/passwordlogin',
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 11.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(11.0),
                            ),
                            child: Text(
                              "Password",
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
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 68.0,
                        height: 68.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors:
                                Theme.of(context).brightness == Brightness.dark
                                ? [
                                    Theme.of(context).colorScheme.primary
                                        .withValues(alpha: 0.3),
                                    Theme.of(context).colorScheme.primary
                                        .withValues(alpha: 0.1),
                                  ]
                                : [
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context).colorScheme.primary
                                        .withValues(alpha: 0.8),
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.28),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.3),
                              blurRadius: 24.0,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "E",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        "Eliakim Neequaye",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        "020 113 8966",
                        style: TextStyle(
                          color: Color(0xFF8B8D98),
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
                PinDots(provider: loginPinProvider),
                if (_isVerifying)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2.0),
                      ),
                    ),
                  ),
                NumPad(provider: loginPinProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
