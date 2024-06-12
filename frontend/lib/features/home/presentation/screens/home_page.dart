import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants/app_sizes.dart';
import '/providers/bottom_bar_index_provider.dart';
import '/features/home/presentation/widgets/home_bottom_bar.dart';
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
      appBar: const HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.p20, vertical: Sizes.p8),
        child: Consumer<BottomBarIndexProvider>(
          builder: (ctx, provider, _) {
            return _screens[provider.index];
          },
        ),
      ),
      bottomNavigationBar: const HomeBottomBar(),
    );
  }
}
