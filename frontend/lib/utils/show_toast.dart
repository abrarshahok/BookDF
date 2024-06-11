import 'package:bookdf/constants/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

import '../constants/app_colors.dart';

void showToast(
  String message,
  BuildContext context, {
  bool isError = false,
}) {
  Flushbar(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    icon: isError
        ? const Icon(
            Icons.info_outline,
            size: 28.0,
            color: wrong,
          )
        : const Icon(
            Icons.check_circle_outline,
            size: 28.0,
            color: correct,
          ),
    messageText: Text(
      message,
      style: subtitleStyle,
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: bgColor,
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    borderRadius: BorderRadius.circular(8),
    boxShadows: const [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
  ).show(context);
}
