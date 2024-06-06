import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';
import '/constants/app_colors.dart';
import '/features/home/presentation/screens/home_page.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _currentPage = 0;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(scrollController: _scrollController),
      bottomNavigationBar: DotCurvedBottomNav(
        indicatorColor: secondaryColor,
        backgroundColor: Colors.transparent,
        hideOnScroll: true,
        scrollController: _scrollController,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.ease,
        selectedIndex: _currentPage,
        indicatorSize: 5,
        borderRadius: 25,
        height: 40,
        margin: const EdgeInsets.only(bottom: 20, top: 10),
        onTap: (index) {
          setState(() => _currentPage = index);
        },
        items: [
          Icon(
            FeatherIcons.home,
            color: _currentPage == 0
                ? secondaryColor
                : primaryColor.withOpacity(0.5),
          ),
          Icon(
            FeatherIcons.search,
            color: _currentPage == 1
                ? secondaryColor
                : primaryColor.withOpacity(0.5),
          ),
          Icon(
            FeatherIcons.bookmark,
            color: _currentPage == 2
                ? secondaryColor
                : primaryColor.withOpacity(0.5),
          ),
          Icon(
            FeatherIcons.user,
            color: _currentPage == 3
                ? secondaryColor
                : primaryColor.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
