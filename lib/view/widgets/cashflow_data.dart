import 'dart:math';
import 'package:flutter/material.dart';

class CashFlowData {
  final String label;
  final double cashIn;
  final double cashOut;

  const CashFlowData({
    required this.label,
    required this.cashIn,
    required this.cashOut,
  });
}

class CashFlowChart extends StatelessWidget {
  final List<CashFlowData> data;

  const CashFlowChart({super.key, required this.data});

  static const double _chartHeight = 170;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final cashInColor = scheme.secondary;
    final cashOutColor = scheme.error.withValues(alpha: 0.75);
    final maxValue = data.fold<double>(
      1,
      (m, d) => max(m, max(d.cashIn, d.cashOut)),
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: scheme.onSurface.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Cash Flow',
                style: TextStyle(
                  color: scheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              _LegendItem(color: cashInColor, label: 'In'),
              const SizedBox(width: 16),
              _LegendItem(color: cashOutColor, label: 'Out'),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: data.map((d) {
              return Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: _chartHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _Bar(
                            height: d.cashIn / maxValue * _chartHeight,
                            color: cashInColor,
                          ),
                          const SizedBox(width: 4),
                          _Bar(
                            height: d.cashOut / maxValue * _chartHeight,
                            color: cashOutColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      d.label,
                      style: const TextStyle(
                        color: Color(0xFF8B8D98),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final double height;
  final Color color;

  const _Bar({required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      width: 18,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8B8D98),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
