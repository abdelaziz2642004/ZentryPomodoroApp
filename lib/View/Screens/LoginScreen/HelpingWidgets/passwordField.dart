import 'package:flutter/material.dart';
import 'package:prj/core/colors.dart';

class PasswordField extends StatelessWidget {
  final bool obscurePassword;
  final Function(String) onChanged;
  final VoidCallback toggleVisibility;
  final String labelText;

  const PasswordField({
    required this.obscurePassword,
    required this.onChanged,
    required this.toggleVisibility,
    required this.labelText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscurePassword,
      validator:
          (value) =>
              (value == null || value.length < 6)
                  ? 'Enter a valid password'
                  : null,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontFamily: "DopisBold"),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        prefixIcon: const Icon(Icons.lock, color: mainColor),
        suffixIcon: IconButton(
          icon: Icon(
            obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: mainColor,
          ),
          onPressed: toggleVisibility,
        ),
      ),
    );
  }
}
