import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_sizes.dart';
import '/components/custom_error_widget.dart';
import '../widgets/category_book_container.dart';
import '/features/book/presentation/widgets/category_books_loading.dart';
import '/dependency_injection/dependency_injection.dart';
import '../../../../constants/app_font_styles.dart';
import '../../../../providers/book_respository_provider.dart';
import '../../../../states/load_state.dart';
import '../../data/models/book.dart';

class BookmarkedBooksScreen extends StatefulWidget {
  const BookmarkedBooksScreen({super.key});

  @override
  State<BookmarkedBooksScreen> createState() => _BookmarkedBooksScreenState();
}

class _BookmarkedBooksScreenState extends State<BookmarkedBooksScreen> {
  @override
  void initState() {
    super.initState();
    locator<BookRepositoryProvider>().fetchBookmarkedBooks();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: gapH20),
        SliverToBoxAdapter(
          child: Text(
            'My Bookmarks',
            style: titleStyle,
          ),
        ),
        const SliverToBoxAdapter(child: gapH20),
        Consumer<BookRepositoryProvider>(
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
                        'No Bookmarked books found!',
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
        ),
      ],
    );
  }
}
