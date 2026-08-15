import 'package:flutter_riverpod/flutter_riverpod.dart';

class PinNotifier extends Notifier<String> {
  @override
  String build() => '';

  void addDigit(String digit) {
    if (state.length >= 6) return;
    state = state + digit;
  }

  void removeDigit() {
    if (state.isEmpty) return;
    state = state.substring(0, state.length - 1);
  }

  void clear() {
    state = '';
  }

  bool get isComplete => state.length == 6;
}

// Used on CreatePin screen (signup flow)
final createPinProvider = NotifierProvider<PinNotifier, String>(
  PinNotifier.new,
);

// Used on PinLoginScreen (returning user unlock)
final loginPinProvider = NotifierProvider<PinNotifier, String>(PinNotifier.new);
