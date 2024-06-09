import 'package:bookdf/constants/app_colors.dart';
import 'package:bookdf/constants/app_font_styles.dart';
import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.width,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.maxLength,
    this.inputType,
    this.prefixIcon,
    this.onSubmitted,
    this.onSaved,
  });

  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? width;
  final String? Function(String?)? validator;
  final bool readOnly;
  final VoidCallback? onTap;
  final Function(String)? onSubmitted;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final int? maxLength;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        key: key,
        style: secondaryStyle,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: inputType,
        maxLength: maxLength,
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          counterText: '',
          hintText: hintText,
          errorStyle: secondaryStyle.copyWith(color: Colors.red),
          hintStyle: secondaryStyle,
          contentPadding: const EdgeInsets.symmetric(horizontal: Sizes.p20),
          border: _buildBorder(secondaryAccentColor, readOnly ? 0.2 : 1),
          enabledBorder: _buildBorder(secondaryAccentColor, readOnly ? 0.2 : 1),
          disabledBorder:
              _buildBorder(secondaryAccentColor, readOnly ? 0.2 : 1),
          focusedBorder: _buildBorder(secondaryAccentColor, readOnly ? 0.2 : 1),
          errorBorder: _buildBorder(Colors.red, 1),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        validator: validator,
        onChanged: onChanged,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        onFieldSubmitted: onSubmitted,
        onSaved: onSaved,
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color, double opacity) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color.withOpacity(opacity)),
    );
  }
}
