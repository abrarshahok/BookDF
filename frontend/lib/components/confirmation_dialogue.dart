import 'package:bookdf/constants/app_colors.dart';
import 'package:bookdf/constants/app_font_styles.dart';
import 'package:flutter/material.dart';
import '/components/custom_border_button.dart';
import '/components/custom_button.dart';
import '/constants/app_sizes.dart';

class ConfirmationDialogue {
  final BuildContext context;
  final String title;
  final String? subtitle;
  final VoidCallback onTapPrimary;
  final VoidCallback onTapSecondary;
  final String? buttonTextPrimary;
  final String? buttonTextSecondary;
  final TextAlign? textAlign;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  ConfirmationDialogue({
    required this.context,
    required this.title,
    this.subtitle,
    required this.onTapPrimary,
    required this.onTapSecondary,
    this.buttonTextPrimary,
    this.buttonTextSecondary,
    this.textAlign,
    this.titleStyle,
    this.subtitleStyle,
  });

  show() {
    final size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        contentTextStyle: secondaryStyle,
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          title,
          style: titleStyle ??
              buttonStyle.copyWith(color: primaryColor, fontSize: 20),
          textAlign: textAlign ?? TextAlign.center,
        ),
        content: subtitle == null
            ? null
            : Text(
                subtitle!,
                style: subtitleStyle ??
                    buttonStyle.copyWith(color: secondaryAccentColor),
                textAlign: textAlign ?? TextAlign.center,
              ),
        actions: [
          Row(
            children: [
              CustomBorderButton(
                label: buttonTextSecondary ?? 'Logout',
                width: size.width * 0.2,
                height: 50,
                borderRadius: 8,
                onPressed: onTapSecondary,
                textStyle: buttonStyle.copyWith(color: secondaryAccentColor),
              ),
              gapW4,
              Expanded(
                child: CustomButton(
                  label: buttonTextPrimary ?? 'Stay Logged In',
                  textStyle: buttonStyle,
                  width: size.width * 0.3,
                  height: 50,
                  borderRadius: 8,
                  onPressed: onTapPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
