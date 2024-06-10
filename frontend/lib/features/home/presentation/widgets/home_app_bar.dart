import 'package:bookdf/constants/app_font_styles.dart';
import 'package:bookdf/features/auth/data/models/user.dart';
import 'package:flutter/material.dart';
import '../../../../components/custom_memory_image.dart';
import '/constants/app_colors.dart';

import '/constants/app_sizes.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User user;

  const HomeAppBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final avatar = user.pic!;
    final name = user.username!;

    return AppBar(
      backgroundColor: secondaryColor,
      elevation: 10,
      shadowColor: primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hello, $_greetingMessage',
            style: secondaryStyle.copyWith(color: bgColor),
          ),
          gapH4,
          Text(
            name,
            style: buttonStyle.copyWith(color: bgColor, fontSize: 20),
          ),
        ],
      ),
      actions: [
        ClipOval(
          child: CustomMemoryImage(
            imageString: avatar,
            height: 40,
            width: 40,
            cacheKey: user.id!,
          ),
        ),
        gapW8,
      ],
    );
  }

  String get _greetingMessage {
    var hour = DateTime.now().hour;
    if (hour < 5) {
      return 'Good night!';
    } else if (hour < 12) {
      return 'Good morning!';
    } else if (hour < 17) {
      return 'Good afternoon!';
    } else if (hour < 20) {
      return 'Good evening!';
    } else {
      return 'Good night!';
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
