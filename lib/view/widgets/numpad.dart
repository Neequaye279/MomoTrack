import 'package:flutter/material.dart';

class NumPad extends StatelessWidget {
  const NumPad({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1.7,
      children: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', '⌫'].map(
        (key) {
          if (key.isEmpty) return const SizedBox();
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            child: Center(
              child: Text(
                key,
                style: TextStyle(
                  fontSize: key == '⌫' ? 20 : 22,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
