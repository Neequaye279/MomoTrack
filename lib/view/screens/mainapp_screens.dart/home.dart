import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momo_track/view/widgets/balance_card.dart';
import 'package:momo_track/view/widgets/status_card.dart';
import 'package:momo_track/view/widgets/floatbalance_card.dart';
import 'package:momo_track/view/widgets/recent_transactions.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:momo_track/services/auth_service.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.04,
          horizontal: screenWidth * 0.04,
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
                  IconButton(
                    icon: Icon(
                      LucideIcons.logOut,
                      color: Theme.of(context).colorScheme.error,
                      size: 20.0,
                    ),
                    onPressed: () async {
                      await ref.read(authServiceProvider).signOut();
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(context, '/welcome');
                      }
                    },
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: Theme.of(context).brightness == Brightness.dark
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
                          color: Theme.of(context).brightness == Brightness.dark
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
              SizedBox(height: screenHeight * 0.03),
              BalanceCard(balance: 34567.00, weeklyChange: 735),
              SizedBox(height: screenHeight * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatusCard(
                    value: "GHS 1,180",
                    type: "CASH IN",
                    icon: LucideIcons.arrowUp,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  StatusCard(
                    value: "GHS 445",
                    type: "CASH OUT",
                    icon: LucideIcons.arrowDown,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  StatusCard(
                    value: "GHS 735",
                    type: "PROFIT",
                    icon: LucideIcons.trendingUp,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              FloatbalanceCard(),
              SizedBox(height: screenHeight * 0.03),
              Row(
                children: [
                  Text(
                    "Recent",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "See all",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              RecentTransactionsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
