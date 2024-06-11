import 'package:auto_route/auto_route.dart';
import 'package:bookdf/components/custom_error_widget.dart';
import 'package:bookdf/constants/app_colors.dart';
import 'package:bookdf/routes/app_router.gr.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../../../states/load_state.dart';
import '/constants/app_font_styles.dart';
import '/constants/app_sizes.dart';
import '/providers/library_books_provider.dart';
import '../../../../dependency_injection/dependency_injection.dart';
import '/features/library/presentation/widgets/library_book_container.dart';
import '/features/book/data/models/book.dart';
import '/features/library/presentation/widgets/library_books_loading.dart';

class LibraryBooksScreen extends StatefulWidget {
  const LibraryBooksScreen({super.key});

  @override
  State<LibraryBooksScreen> createState() => _LibraryBooksScreenState();
}

class _LibraryBooksScreenState extends State<LibraryBooksScreen> {
  @override
  void initState() {
    super.initState();
    locator<LibraryBooksProvider>().fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: gapH20),
          SliverToBoxAdapter(
            child: Text(
              'My Library',
              style: titleStyle,
            ),
          ),
          const SliverToBoxAdapter(child: gapH20),
          Consumer<LibraryBooksProvider>(
            builder: (context, provider, child) {
              final state = provider.state;
              if (state is LoadingState) {
                return const LibraryBooksLoading(
                  height: 144,
                  width: 290,
                );
              } else if (state is SuccessState) {
                final books = state.data as List<Book>;
                if (books.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: Center(
                        child: Text(
                          'No books added yet!',
                          style: secondaryStyle,
                        ),
                      ),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return LibraryBookContainer(
                        book: books[index],
                        key: ValueKey(books[index].id!),
                      );
                    },
                    childCount: books.length,
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
          const SliverToBoxAdapter(child: gapH64),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(AddBookRoute());
        },
        backgroundColor: secondaryColor,
        tooltip: 'Add Book',
        child: const Icon(
          Icons.add,
          color: bgColor,
        ),
      ),
    );
  }
}
