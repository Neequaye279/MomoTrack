import 'package:flutter/material.dart';
import 'package:momo_track/view/widgets/balance_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.height;
    final screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.04,
            horizontal: screenWidth * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "GOOD MORNING",
                          style: TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B8D98),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          "Eliakim",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23.0,
                            color: Theme.of(context).colorScheme.onSurface,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      width: 45.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors:
                              Theme.of(context).brightness == Brightness.dark
                              ? [
                                  Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: 0.3),
                                  Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: 0.1),
                                ]
                              : [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: 0.8),
                                ],
                        ),
                        borderRadius: BorderRadius.circular(13.0),
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
                                Theme.of(context).brightness == Brightness.dark
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                BalanceCard(balance: 34567.00, weeklyChange: 735),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
