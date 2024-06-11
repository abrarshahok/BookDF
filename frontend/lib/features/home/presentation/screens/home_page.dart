import 'package:auto_route/auto_route.dart';
import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import '../../../../constants/app_sizes.dart';
import '/constants/app_colors.dart';
import '/providers/bottom_bar_index_provider.dart';
import '/dependency_injection/dependency_injection.dart';
import '/features/auth/data/respository/auth_respository.dart';
import '/features/book/presentation/screens/books_screen.dart';
import '/features/home/presentation/widgets/home_app_bar.dart';
import '/features/library/presentation/screens/libray_books_screen.dart';
import '/features/book/presentation/screens/bookmarked_books_screen.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _screens = [
    const BooksScreen(),
    const LibraryBooksScreen(),
    const BookmarkedBooksScreen(),
    const BooksScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        user: AuthRepository.instance.currentUser!,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.p20, vertical: Sizes.p8),
        child: Consumer<BottomBarIndexProvider>(
          builder: (ctx, provider, _) {
            return _screens[provider.index];
          },
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  DotCurvedBottomNav _buildBottomBar() {
    final provider = locator<BottomBarIndexProvider>();
    return DotCurvedBottomNav(
      indicatorColor: secondaryColor,
      backgroundColor: Colors.transparent,
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.ease,
      selectedIndex: provider.index,
      indicatorSize: 5,
      borderRadius: 25,
      height: 40,
      margin: const EdgeInsets.only(bottom: 20, top: 10),
      onTap: (index) {
        if (provider.index != index) {
          locator<BottomBarIndexProvider>().set(index);
        }
      },
      items: [
        Icon(
          IconlyLight.home,
          color: provider.index == 0
              ? secondaryColor
              : primaryColor.withOpacity(0.5),
        ),
        Icon(
          IconlyLight.category,
          color: provider.index == 1
              ? secondaryColor
              : primaryColor.withOpacity(0.5),
        ),
        Icon(
          IconlyLight.bookmark,
          color: provider.index == 2
              ? secondaryColor
              : primaryColor.withOpacity(0.5),
        ),
        Icon(
          IconlyLight.user,
          color: provider.index == 3
              ? secondaryColor
              : primaryColor.withOpacity(0.5),
        ),
      ],
    );
  }
}
