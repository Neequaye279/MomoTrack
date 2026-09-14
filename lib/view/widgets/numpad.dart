import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:momo_track/viewModel/pin_provider.dart';

class NumPad extends ConsumerWidget {
  final NotifierProvider<PinNotifier, String> provider;

  const NumPad({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', 'del'];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: keys.map((key) {
        return _NumKey(
          keyValue: key,
          onTap: () {
            final notifier = ref.read(provider.notifier);
            if (key == 'del') {
              notifier.removeDigit();
            } else if (key.isNotEmpty) {
              notifier.addDigit(key);
            }
          },
        );
      }).toList(),
    );
  }
}

class _NumKey extends StatelessWidget {
  final String keyValue;
  final VoidCallback onTap;

  const _NumKey({required this.keyValue, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDel = keyValue == 'del';
    final isEmpty = keyValue.isEmpty;

    if (isEmpty) return const SizedBox();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: isDel
              ? Icon(
                  LucideIcons.x,
                  size: 22,
                  color: Theme.of(context).colorScheme.onSurface,
                )
              : Text(
                  keyValue,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
        ),
      ),
    );
  }
}
