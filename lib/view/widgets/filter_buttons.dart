import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({super.key});

  Widget _pill(BuildContext context, Widget child, {bool selected = false}) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? cs.primary : cs.onSurface.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: selected ? cs.primary : cs.onSurface.withValues(alpha: 0.12),
        ),
      ),
      child: child,
    );
  }

  Widget _label(BuildContext context, String text, {bool selected = false}) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: selected ? cs.onPrimary : cs.onSurface.withValues(alpha: 0.55),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _pill(context, _label(context, 'All')),
                  const SizedBox(width: 8),
                  _pill(context, _label(context, 'Cash In')),
                  const SizedBox(width: 8),
                  _pill(
                    context,
                    _label(context, 'Cash Out', selected: true),
                    selected: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          _pill(
            context,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  LucideIcons.funnel,
                  size: 16,
                  color: cs.onSurface.withValues(alpha: 0.55),
                ),
                const SizedBox(width: 6),
                _label(context, 'Filter'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
