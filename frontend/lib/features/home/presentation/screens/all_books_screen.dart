import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_font_styles.dart';
import '../../../../providers/book_respository_provider.dart';
import '../../../../states/load_state.dart';
import '../widgets/book_container.dart';

@RoutePage()
class AllBooksScreen extends StatefulWidget {
  const AllBooksScreen({
    super.key,
  });

  @override
  State<AllBooksScreen> createState() => _AllBooksScreenState();
}

class _AllBooksScreenState extends State<AllBooksScreen> {
  @override
  void initState() {
    Provider.of<BookRepositoryProvider>(context, listen: false).fetchBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookRepositoryProvider>(
      builder: (context, provider, _) {
        final state = provider.state;
        if (state is LoadingState) {
          return const SliverToBoxAdapter(
            child: Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (state is SuccessState) {
          final books = state.data;
          log(books.length.toString());
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
                    (book) => BookContainer(
                      title: book.title,
                      rating: book.ratings.averageRating,
                      author: book.author,
                      base64image: book.coverImage,
                      bookId: book.id!,
                    ),
                  )
                  .toList(),
              // const [
              //   BookContainer(
              //     title: 'The Boy With One Name',
              //     rating: 4.0,
              //     author: 'J.R. Wallis',
              //     base64image:
              //         'https://d28hgpri8am2if.cloudfront.net/book_images/onix/cvr9781471157936/the-boy-with-one-name-9781471157936_hr.jpg',
              //   ),
              //   BookContainer(
              //     title: 'The Name of the Wind',
              //     author: 'Patrick Rothfuss',
              //     base64image:
              //         'https://www.thepacer.net/wp-content/uploads/2020/11/91b8oNwaV1L.jpg',
              //     rating: 5.0,
              //   ),
              //   BookContainer(
              //     title: 'The Book With One Name',
              //     rating: 4.0,
              //     author: 'Anonymous',
              //     base64image:
              //         'https://sammicox.wordpress.com/wp-content/uploads/2018/06/the-book-with-no-name-front-cover.jpg',
              //   ),
              //   SizedBox(height: 100),
              // ],
            ),
          );
        } else if (state is ErrorState) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                state.errorMessage,
                style: secondaryStyle,
              ),
            ),
          );
        } else {
          return const SliverToBoxAdapter(child: SizedBox());
        }
      },
    );
  }
}
