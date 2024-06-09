import 'package:flutter/material.dart';
import '/components/custom_icon_button.dart';
import '/constants/app_colors.dart';
import '/constants/app_font_styles.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Book',
              style: titleStyle,
            ),
            TextSpan(
              text: 'DF',
              style: titleAccentStyle,
            ),
          ],
        ),
      ),
      actions: [
        CustomIconButton(
          onTap: () {},
          icon: Icons.add,
          iconColor: accentColor,
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
