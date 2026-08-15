import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momo_track/viewModel/pin_provider.dart';

class PinDots extends ConsumerWidget {
  final NotifierProvider<PinNotifier, String> provider;

  const PinDots({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pin = ref.watch(provider);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 28.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(6, (i) {
          final isFilled = i < pin.length;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            width: 14.0,
            height: 14.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isFilled
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              border: Border.all(
                color: isFilled
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.2),
                width: 2.0,
              ),
            ),
          );
        }),
      ),
    );
  }
}
