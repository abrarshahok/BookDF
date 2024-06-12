import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/book.dart';
import 'category_book_container.dart';
import '../../../../states/load_state.dart';
import '/components/custom_error_widget.dart';
import '../../../../constants/app_font_styles.dart';
import '/dependency_injection/dependency_injection.dart';
import '../../../../providers/book_respository_provider.dart';
import '/features/book/presentation/widgets/category_books_loading.dart';

class BooksCategorySection extends StatefulWidget {
  const BooksCategorySection({super.key, required this.category});
  final String category;

  @override
  State<BooksCategorySection> createState() => _BooksCategorySectionState();
}

class _BooksCategorySectionState extends State<BooksCategorySection> {
  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  @override
  void didUpdateWidget(covariant BooksCategorySection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category) {
      _fetchBooks();
    }
  }

  void _fetchBooks() {
    locator<BookRepositoryProvider>().fetchBooks(widget.category);
    log('Fetch Books Called!');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookRepositoryProvider>(
      builder: (context, provider, _) {
        final state = provider.bookState;
        if (state is LoadingState) {
          return const SliverToBoxAdapter(
            child: CategoryBooksLoading(
              height: 275,
              width: 300,
            ),
          );
        } else if (state is SuccessState) {
          final books = state.data as List<Book>;
          if (books.isEmpty) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: Text(
                    'No books found!',
                    style: secondaryStyle,
                  ),
                ),
              ),
            );
          }
          return SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
            ),
            delegate: SliverChildListDelegate(
              books
                  .map(
                    (book) => CategoryBookContainer(book: book),
                  )
                  .toList(),
            ),
          );
        } else if (state is ErrorState) {
          return SliverToBoxAdapter(
            child: CustomErrorWidget(errorMessage: state.errorMessage),
          );
        } else {
          return const SliverToBoxAdapter(child: SizedBox());
        }
      },
    );
  }
}
