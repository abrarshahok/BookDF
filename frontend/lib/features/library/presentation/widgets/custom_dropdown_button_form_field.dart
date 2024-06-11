import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_font_styles.dart';

class CustomDropdownButtonFormField extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final String labelText;

  const CustomDropdownButtonFormField({
    super.key,
    required this.items,
    required this.onChanged,
    this.validator,
    this.initialValue,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: secondaryStyle.copyWith(
          color: secondaryAccentColor,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: secondaryAccentColor,
          ),
        ),
      ),
      style: secondaryStyle.copyWith(
        fontWeight: FontWeight.bold,
        color: secondaryAccentColor,
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
