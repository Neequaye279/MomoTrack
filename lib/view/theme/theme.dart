import 'package:flutter/material.dart';

final lightMode = const ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF0060FF),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFF00875A),
  onSecondary: Color(0xFFFFFFFF),
  error: Color(0xFFE03131),
  onError: Color(0xFFFFFFFF),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF0C0F14),
  tertiary: Color(0xFFC67C00),
  onTertiary: Color(0xFFFFFFFF),
);

final darkMode = const ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF00E5A0),
  onPrimary: Color(0xFF080A0F),
  secondary: Color(0xFF00D17A),
  onSecondary: Color(0xFF080A0F),
  error: Color(0xFFFF4B6E),
  onError: Color(0xFFF2F4F8),
  surface: Color(0xFF0F1117),
  onSurface: Color(0xFFF2F4F8),
  tertiary: Color(0xFFFFB84D),
  onTertiary: Color(0xFF080A0F),
);
