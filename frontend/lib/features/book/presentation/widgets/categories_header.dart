import '../../../../providers/book_genre_provider.dart';
import '/features/book/presentation/widgets/book_category_chip.dart';
import '/features/home/presentation/widgets/sliver_app_bar_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesHeader extends StatelessWidget {
  const CategoriesHeader({super.key});

  final genre = const [
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
    return Consumer<BookGenreProvider>(builder: (ctx, provider, _) {
      return SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          minHeight: 60.0,
          maxHeight: 60.0,
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: genre
                    .map(
                      (category) => BookCategoryChip(
                        category: category,
                        onTap: () {
                          provider.set(category);
                        },
                        isSelected: category == provider.genre,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      );
    });
  }
}
