import 'package:flutter/material.dart';

import 'custom_icon_button.dart';

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
      // style: AppFontStyle.appBarTitleMont.copyWith(
      //   color: AppColors.primaryVariant,
      // ),
    ),
    leading: (showLeadingButton)
        ? CustomIconButton(
            onTap: () {},
            icon: Icons.arrow_back_ios_new_rounded,
            // iconColor: AppColors.primaryVariant,
          )
        : null,
    actions: [
      if (actionButton != null) actionButton,
    ],
  );
}
