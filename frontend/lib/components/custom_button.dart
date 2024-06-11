import 'package:flutter/material.dart';
import '/constants/app_colors.dart';
import '/constants/app_font_styles.dart';
import '../constants/app_sizes.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 55,
    this.color = secondaryColor,
    this.textStyle,
    this.leadingIcon,
    this.trailingIcon,
    this.elevation = 0,
    this.borderRadius = 100,
  });
  final String label;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final Color? color;
  final TextStyle? textStyle;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final double elevation;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        disabledBackgroundColor: secondaryAccentColor,
        backgroundColor: color,
        minimumSize: Size(
          width,
          height,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            Icon(
              leadingIcon,
              size: 20,
              color: bgColor,
            ),
            gapW8,
          ],
          Text(
            label,
            style: textStyle ?? secondaryButtonStyle,
          ),
          if (trailingIcon != null) ...[
            gapW8,
            Icon(trailingIcon, size: 20),
          ],
        ],
      ),
    );
  }
}
