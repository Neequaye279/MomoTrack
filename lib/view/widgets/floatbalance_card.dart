import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FloatbalanceCard extends StatelessWidget {
  const FloatbalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? const Color(0xFF2A2D36) : null;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20.0),
        border: borderColor != null
            ? Border.all(color: borderColor, width: 1)
            : null,
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 12.0,
                  offset: Offset(0, 4),
                ),
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(19.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Float Balance",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 1.0,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.tertiary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Text(
                    "LOW",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "GHS 620",
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  "/3,000 target",
                  style: TextStyle(fontSize: 16.0, color: Color(0xFF8B8D98)),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: LinearProgressIndicator(
                value: 0.2,
                minHeight: 10,
                backgroundColor: Color(0xFF8B8D98).withValues(alpha: 0.15),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFB8720A),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  LucideIcons.triangleAlert,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: 22,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Consider topping up before your next busy period",
                    style: TextStyle(fontSize: 13.0, color: Color(0xFF8B8D98)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
