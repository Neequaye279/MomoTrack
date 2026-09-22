import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RecentTransactionsSection extends StatelessWidget {
  const RecentTransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = colors.brightness == Brightness.dark;

    Widget buildRow({
      required String name,
      required String subtitle,
      required String amount,
      required bool isPositive,
      bool showDivider = true,
    }) {
      final amountColor = isPositive ? colors.secondary : colors.error;

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: amountColor.withValues(alpha: isDark ? 0.16 : 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    isPositive ? LucideIcons.arrowUp : LucideIcons.arrowDown,
                    color: amountColor,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: colors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: amountColor,
                  ),
                ),
              ],
            ),
          ),
          if (showDivider)
            Divider(height: 1, color: colors.onSurface.withValues(alpha: 0.08)),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: isDark
            ? Border.all(
                color: colors.onSurface.withValues(alpha: 0.12),
                width: 1,
              )
            : null,
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        children: [
          buildRow(
            name: 'Samuel Adjei',
            subtitle: 'Cash In · 9:42 AM',
            amount: '+GHS 250.00',
            isPositive: true,
          ),
          buildRow(
            name: 'Kofi Mensah',
            subtitle: 'Cash Out · 11:15 AM',
            amount: '-GHS 120.00',
            isPositive: false,
          ),
          buildRow(
            name: 'Ama Owusu',
            subtitle: 'Cash In · 1:30 PM',
            amount: '+GHS 500.00',
            isPositive: true,
            showDivider: false,
          ),
        ],
      ),
    );
  }
}
