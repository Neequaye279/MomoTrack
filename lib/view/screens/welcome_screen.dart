import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:momo_track/view/widgets/graph_painter.dart';
import 'package:momo_track/view/widgets/welcome_screen_button.dart';
import 'package:momo_track/view/theme/theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Icon(
                        LucideIcons.activity,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: "MoMo",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          TextSpan(
                            text: "Track",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),

                Text(
                  "Mobile money,",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: screenWidth * 0.09,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "made clear.",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: screenWidth * 0.09,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: screenHeight * 0.025),
                Text(
                  "Track every MoMo transaction automatically.",
                  style: TextStyle(color: Color(0xFF8B8D98)),
                ),
                SizedBox(height: 5.0),
                Text(
                  "Know exactly where your money goes.",
                  style: TextStyle(color: Color(0xFF8B8D98)),
                ),
                SizedBox(height: screenHeight * 0.04),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.surface,
                        Theme.of(
                          context,
                        ).colorScheme.surface.withValues(alpha: 0.92),
                      ],
                    ),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.06),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ===== HEADER =====
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today's activity",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Text(
                              "LIVE",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth * 0.028,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // ===== GRAPH =====
                      SizedBox(
                        height: screenHeight * 0.16,
                        width: double.infinity,
                        child: CustomPaint(
                          painter: GraphPainter(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // ===== SINGLE DIVIDER (UNDER GRAPH) =====
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.06),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // ===== CASH IN / CASH OUT =====
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "CASH IN",
                                  style: TextStyle(
                                    color: const Color(0xFF8B8D98),
                                    fontSize: screenWidth * 0.035,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                                Text(
                                  "GHS 1,180",
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            height: 40,
                            width: 1,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.06),
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "CASH OUT",
                                  style: TextStyle(
                                    color: const Color(0xFF8B8D98),
                                    fontSize: screenWidth * 0.035,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                                Text(
                                  "GHS 425",
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.08),
                Column(
                  children: [
                    WelcomeScreenButton(
                      buttonText: "Create Account",
                      background: Theme.of(context).colorScheme.primary,
                      foreground: Theme.of(context).colorScheme.onPrimary,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    WelcomeScreenButton(
                      buttonText: "Sign In",
                      background: Theme.of(context).colorScheme.surface,
                      foreground: Color(0xFF8B8D98),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
