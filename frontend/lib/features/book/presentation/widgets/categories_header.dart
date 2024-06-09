import 'package:bookdf/features/book/presentation/widgets/book_category_chip.dart';
import 'package:bookdf/features/home/presentation/widgets/sliver_app_bar_delegate.dart';
import 'package:flutter/material.dart';

class CategoriesHeader extends StatelessWidget {
  const CategoriesHeader({super.key});
  final categories = const [
    'All',
    'Romance',
    'Sci-Fi',
    'Fantasy',
    'Classics',
    'Technology',
    'Education',
  ];

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 60.0,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories
                  .map(
                    (cat) => BookCategoryChip(
                      category: cat,
                      onTap: () {},
                      isSelected: cat == 'All',
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
