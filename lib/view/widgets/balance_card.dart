import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final double weeklyChange;
  final String currencyCode;

  const BalanceCard({
    super.key,
    required this.balance,
    required this.weeklyChange,
    this.currencyCode = 'GHS',
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final isPositive = weeklyChange >= 0;
    const borderWidth = 1.0;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: isDark
            ? Border.all(
                color: colorScheme.primary.withValues(alpha: 0.4),
                width: borderWidth,
              )
            : null,
        // dark green-black wash instead of flat surface
        color: isDark ? null : null,
        gradient: isDark
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(colorScheme.surface, colorScheme.primary, 0.08)!,
                  colorScheme.surface,
                ],
              )
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primary,
                  colorScheme.primary.withValues(alpha: 0.75),
                ],
              ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24 - borderWidth),
        child: Padding(
          padding: const EdgeInsets.all(borderWidth),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -60,
                right: -60,
                child: _bubble(
                  isDark ? colorScheme.primary : colorScheme.onPrimary,
                  size: 180,
                  opacity: isDark ? 0.045 : 0.08,
                ),
              ),
              Positioned(
                bottom: -50,
                right: 20,
                child: _bubble(
                  isDark ? colorScheme.primary : colorScheme.onPrimary,
                  size: 120,
                  opacity: isDark ? 0.035 : 0.06,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(23), // 24 - borderWidth
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL BALANCE',
                      style: TextStyle(
                        color: isDark
                            ? colorScheme.primary.withValues(alpha: 0.55)
                            : colorScheme.onPrimary.withValues(alpha: 0.7),
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$currencyCode ${balance.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: isDark
                            ? colorScheme.onSurface.withValues(alpha: 0.85)
                            : colorScheme.onPrimary,
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _changeRow(colorScheme, isDark, isPositive),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bubble(Color color, {required double size, required double opacity}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: opacity),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _changeRow(ColorScheme colorScheme, bool isDark, bool isPositive) {
    final accentColor = isDark ? colorScheme.primary : colorScheme.onPrimary;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDark
                ? Color.lerp(colorScheme.surface, colorScheme.primary, 0.12)
                : accentColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            isPositive ? LucideIcons.trendingUp : LucideIcons.trendingDown,
            size: 18,
            color: accentColor,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '${isPositive ? '+' : ''}$currencyCode ${weeklyChange.abs().toStringAsFixed(0)} this week',
          style: TextStyle(
            color: accentColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
