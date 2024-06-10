import 'package:bookdf/dependency_injection/dependency_injection.dart';
import 'package:bookdf/features/auth/data/respository/auth_respository.dart';
import 'package:bookdf/features/book/presentation/widgets/category_books_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_font_styles.dart';
import '../../../../providers/book_respository_provider.dart';
import '../../../../states/load_state.dart';
import '../../data/models/book.dart';
import 'category_book_container.dart';

class BooksCategorySection extends StatefulWidget {
  const BooksCategorySection({super.key});

  @override
  State<BooksCategorySection> createState() => _BooksCategorySectionState();
}

class _BooksCategorySectionState extends State<BooksCategorySection> {
  @override
  void initState() {
    super.initState();
    final jwt = AuthRepository.instance.jwt;
    locator<BookRepositoryProvider>().fetchBooks(jwt!);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookRepositoryProvider>(
      builder: (context, provider, _) {
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
              child: Center(
                child: Text(
                  'No books found!',
                  style: secondaryStyle,
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

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: secondaryStyle,
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
