import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ReportPeriod { daily, weekly, monthly, custom }

class ReportsPeriodNotifier extends Notifier<ReportPeriod> {
  @override
  ReportPeriod build() => ReportPeriod.weekly;

  void select(ReportPeriod period) => state = period;
}

final reportPeriodProvider =
    NotifierProvider<ReportsPeriodNotifier, ReportPeriod>(
      ReportsPeriodNotifier.new,
    );
