import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';
import '/constants/app_font_styles.dart';
import '/features/auth/data/respository/auth_respository.dart';
import '/providers/auth_repository_provider.dart';
import '/routes/app_router.gr.dart';
import '../../../../components/custom_memory_image.dart';
import '/constants/app_colors.dart';

import '/constants/app_sizes.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthRepositoryProvider>(
        builder: (context, provider, child) {
      final user = AuthRepository.instance.currentUser!;
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
          InkWell(
            onTap: () {
              context.router.push(UserProfileRoute());
            },
            child: ClipOval(
              child: CustomMemoryImage(
                imageString: avatar,
                height: 40,
                width: 40,
                cacheKey: user.pic!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          gapW8,
        ],
      );
    });
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
