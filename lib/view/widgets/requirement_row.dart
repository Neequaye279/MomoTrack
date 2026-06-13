import 'package:flutter/material.dart';

class RequirementRow extends StatelessWidget {
  final String text;
  final bool isCompleted;

  const RequirementRow({
    super.key,
    required this.text,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isCompleted
                  ? colors.secondary
                  : colors.onSurface.withValues(alpha: 0.2),
              width: 2,
            ),
          ),
          child: isCompleted
              ? Icon(Icons.check, color: colors.secondary, size: 10)
              : null,
        ),
        const SizedBox(width: 16),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: isCompleted
                ? colors.secondary
                : colors.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
