import 'package:auto_route/auto_route.dart';
import 'package:bookdf/constants/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../constants/app_colors.dart';

AppBar customAppBar({
  bool? centerTitle,
  String? title,
  bool showLeadingButton = false,
  Widget? actionButton,
  required BuildContext context,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: centerTitle,
    title: Text(
      title ?? '',
      style: titleStyle,
    ),
    leading: (showLeadingButton)
        ? IconButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(secondaryColor.withOpacity(0.4)),
            ),
            icon: const Icon(
              IconlyLight.arrow_left,
              color: bgColor,
            ),
            onPressed: () => context.router.maybePop(),
          )
        : null,
    actions: [
      if (actionButton != null) actionButton,
    ],
  );
}
