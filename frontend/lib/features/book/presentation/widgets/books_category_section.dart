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

class BooksCategorySection extends StatelessWidget {
  const BooksCategorySection({super.key, required this.category});
  final String category;
  @override
  Widget build(BuildContext context) {
    locator<BookRepositoryProvider>().fetchBooks(category);
    return Consumer<BookRepositoryProvider>(
      builder: (context, provider, _) {
        log('Build Book Section');
        final state = provider.state;
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
