import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momo_track/viewModel/reportsperiod_provider.dart';
import 'package:momo_track/view/widgets/reportsfilter_bar.dart';
import 'package:momo_track/view/widgets/status_card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:momo_track/view/widgets/cashflow_data.dart';
import 'package:momo_track/view/widgets/profit_graph.dart';
import 'package:momo_track/view/widgets/breakdown_card.dart';
import 'package:momo_track/view/widgets/export_buttons.dart';

class Reports extends ConsumerWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(reportPeriodProvider);

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
              Text(
                "Reports",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              ReportsfilterBar(
                labels: const ["Daily", "Weekly", "Monthly", "Custom"],
                selectedIndex: period.index,
                onSelected: (index) => ref
                    .read(reportPeriodProvider.notifier)
                    .select(ReportPeriod.values[index]),
              ),
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
              SizedBox(height: screenHeight * 0.04),
              CashFlowChart(
                data: const [
                  CashFlowData(label: "Mon", cashIn: 520, cashOut: 240),
                  CashFlowData(label: "Tue", cashIn: 380, cashOut: 300),
                  CashFlowData(label: "Wed", cashIn: 480, cashOut: 230),
                  CashFlowData(label: "Thu", cashIn: 300, cashOut: 150),
                  CashFlowData(label: "Fri", cashIn: 450, cashOut: 350),
                  CashFlowData(label: "Sat", cashIn: 1000, cashOut: 500),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              ProfitGraph(),
              SizedBox(height: screenHeight * 0.03),
              SpendBreakdownCard(
                title: "Transactions Breakdown",
                items: [
                  BreakdownItem(
                    label: "Deposits",
                    percent: 46,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  BreakdownItem(
                    label: "Withdrawals",
                    percent: 30,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  BreakdownItem(
                    label: "Airtime",
                    percent: 16,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  BreakdownItem(
                    label: "Other",
                    percent: 8,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ExportButtons(type: "Export CSV"),
                  ExportButtons(type: "Export Excel"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
