import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.errorText,
    required this.labelText,
    this.onChanged,
    this.needObscureText = false
  });

  final String? errorText;
  final String labelText;
  final void Function(String)?  onChanged;
  final bool needObscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black),
        errorText: errorText,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: needObscureText,
      onChanged: onChanged,
    );
  }
}