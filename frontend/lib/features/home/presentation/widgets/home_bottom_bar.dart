import 'package:bookdf/constants/app_colors.dart';
import 'package:bookdf/constants/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../../../components/custom_bottom_app_bar.dart';
import '../../../../providers/bottom_bar_index_provider.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarIndexProvider>(
      builder: (context, provider, _) => CustomBottomAppBar(
        itemPadding: EdgeInsets.zero,
        height: 70,
        margin: EdgeInsets.zero,
        backgroundColor: bgColor,
        currentIndex: provider.index,
        selectedColorOpacity: 0.2,
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryAccentColor,
        onTap: (index) {
          provider.set(index);
        },
        items: [
          CustomBottomAppBarItem(
            icon: const SizedBox(
              width: 60,
              height: 30,
              child: Icon(IconlyLight.home),
            ),
            title: Text(
              'Home',
              style: subtitleStyle,
            ),
          ),
          CustomBottomAppBarItem(
            icon: const SizedBox(
              width: 60,
              height: 30,
              child: Icon(IconlyLight.category),
            ),
            title: Text(
              'Library',
              style: subtitleStyle,
            ),
          ),
          CustomBottomAppBarItem(
            icon: const SizedBox(
              width: 60,
              height: 30,
              child: Icon(IconlyLight.bookmark),
            ),
            title: Text(
              'Bookmarks',
              style: subtitleStyle,
            ),
          ),
        ],
      ),
    );
  }
}
