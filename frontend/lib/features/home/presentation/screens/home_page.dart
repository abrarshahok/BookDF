import 'package:auto_route/auto_route.dart';
import 'package:bookdf/features/book/presentation/screens/books_screen.dart';
import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '/features/home/presentation/widgets/home_app_bar.dart';
import '/constants/app_colors.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: booksScreen,
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  DotCurvedBottomNav _buildBottomBar() {
    return DotCurvedBottomNav(
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
          IconlyLight.home,
          color: _currentPage == 0
              ? secondaryColor
              : primaryColor.withOpacity(0.5),
        ),
        Icon(
          IconlyLight.category,
          color: _currentPage == 1
              ? secondaryColor
              : primaryColor.withOpacity(0.5),
        ),
        Icon(
          IconlyLight.bookmark,
          color: _currentPage == 2
              ? secondaryColor
              : primaryColor.withOpacity(0.5),
        ),
        Icon(
          IconlyLight.user,
          color: _currentPage == 3
              ? secondaryColor
              : primaryColor.withOpacity(0.5),
        ),
      ],
    );
  }
}
