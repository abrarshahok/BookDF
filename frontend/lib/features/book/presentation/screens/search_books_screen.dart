import 'dart:developer';
import 'package:bookdf/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import '../../../../components/custom_error_widget.dart';
import '../../../../constants/app_font_styles.dart';
import '../../../../states/load_state.dart';
import '../../data/models/book.dart';
import '../widgets/category_book_container.dart';
import '../widgets/category_books_loading.dart';
import '/dependency_injection/dependency_injection.dart';
import '/providers/book_respository_provider.dart';
import '/constants/app_colors.dart';
import '../../../../components/custom_search_text_field.dart';

@RoutePage()
class SearchBooksScreen extends StatelessWidget {
  SearchBooksScreen({super.key});
  final TextEditingController _searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final bookProvider = locator<BookRepositoryProvider>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(secondaryColor.withOpacity(0.4)),
          ),
          icon: const Icon(
            IconlyLight.arrow_left,
            color: bgColor,
          ),
          onPressed: () => context.router.maybePop(),
        ),
        title: CustomSearchTextField(
          hintText: 'Search books by title',
          controller: _searchTextController,
          autoFocus: true,
          onSubmitted: (title) {
            bookProvider.searchBooks(title);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p20),
        child: Consumer<BookRepositoryProvider>(
          builder: (context, provider, _) {
            final state = provider.searchState;
            log(state.toString());
            if (state is LoadingState) {
              return const CategoryBooksLoading(
                height: 275,
                width: 300,
                itemCount: 8,
                useSizedBox: false,
              );
            } else if (state is SuccessState) {
              final books = state.data as List<Book>;
              if (books.isEmpty) {
                return Center(
                  child: Text(
                    _searchTextController.text.isEmpty
                        ? 'No books searched yet!'
                        : 'No books found with title: ${_searchTextController.text}',
                    style: secondaryStyle,
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search Results',
                    style: titleStyle,
                  ),
                  gapH20,
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: books.length,
                      itemBuilder: (context, index) => CategoryBookContainer(
                        book: books[index],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ErrorState) {
              return CustomErrorWidget(errorMessage: state.errorMessage);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
