import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MyTextfield extends StatefulWidget {
  final String hintText;
  final Icon prefixIcon;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? errorText;

  const MyTextfield({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.onChanged,
    this.controller,
    this.errorText,
  });

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  late bool _obscured;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;
    final errorColor = Theme.of(context).colorScheme.error;

    return TextField(
      controller: widget.controller,
      obscureText: _obscured,
      onChanged: widget.onChanged,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Color(0xFF8B8D98)),
        errorText: widget.errorText,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 8.0),
          child: widget.prefixIcon,
        ),
        suffixIcon: widget.obscureText
            ? Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 16.0),
                child: IconButton(
                  icon: Icon(
                    _obscured ? LucideIcons.eye : LucideIcons.eyeOff,
                    color: Color(0xFF8B8D98),
                  ),
                  onPressed: () {
                    setState(() => _obscured = !_obscured);
                  },
                ),
              )
            : null,
        filled: true,
        fillColor: Theme.of(context).colorScheme.onPrimary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 2.0,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 2.0,
            color: hasError
                ? errorColor
                : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 2.0,
            color: hasError
                ? errorColor
                : Theme.of(context).colorScheme.primary,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 2.0, color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 2.0, color: errorColor),
        ),
      ),
    );
  }
}
