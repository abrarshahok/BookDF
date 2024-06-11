import 'dart:developer';
import 'package:bookdf/providers/auth_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import '/features/book/presentation/widgets/book_description.dart';
import '/features/book/presentation/widgets/book_title_and_author.dart';
import '/features/book/presentation/widgets/rating_section.dart';

import '/states/load_state.dart';
import '/features/book/data/models/reading_session.dart';
import '../../../../utils/save_base64_pdf.dart';
import '/components/custom_button.dart';
import '/components/custom_icon_button.dart';
import '/features/book/presentation/widgets/book_details_app_bar.dart';
import '/features/book/data/models/book.dart';
import '/routes/app_router.gr.dart';
import '/constants/app_sizes.dart';
import '/constants/app_font_styles.dart';
import '/constants/app_colors.dart';
import '/components/custom_border_button.dart';
import '/dependency_injection/dependency_injection.dart';
import '/features/auth/data/respository/auth_respository.dart';
import '/features/book/data/respository/reading_session_repository.dart';
import '/providers/reading_session_respository_provider.dart';

@RoutePage()
class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BookDetailsAppBar(
            coverImage: book.coverImage!,
          ),
          SliverToBoxAdapter(
            child: BookTitleAndAuthor(
              bookTitle: book.title!,
              bookAuthor: book.author!,
            ),
          ),
          SliverToBoxAdapter(
              child: RatingSection(
            book: book,
          )),
          SliverToBoxAdapter(
              child: BookDescription(
            description: book.description!,
          )),
          // const SliverToBoxAdapter(child: ReviewsSection()),
        ],
      ),
      bottomNavigationBar:
          Consumer<AuthRepositoryProvider>(builder: (ctx, provider, _) {
        return _buildBottomAppBar(context);
      }),
    );
  }

  BottomAppBar _buildBottomAppBar(BuildContext context) {
    final currentReadings =
        AuthRepository.instance.currentUser!.currentReadings!;
    bool isBookInCurrentReading = currentReadings.contains(book.id);
    return BottomAppBar(
      color: bgColor,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          gapW20,
          CustomIconButton(
            onTap: () {},
            icon: IconlyLight.bookmark,
            iconColor: accentColor,
            size: 30,
          ),
          gapW8,
          if (isBookInCurrentReading)
            CustomBorderButton(
              width: 300,
              height: 50,
              borderRadius: 8,
              label: 'Continue Reading...',
              textStyle: buttonStyle.copyWith(color: secondaryColor),
              onPressed: () => _openPdfScreen(isBookInCurrentReading, context),
            )
          else
            CustomButton(
              width: 300,
              height: 50,
              borderRadius: 8,
              elevation: 5,
              label: 'Start Reading',
              textStyle: buttonStyle,
              onPressed: () => _openPdfScreen(isBookInCurrentReading, context),
            ),
        ],
      ),
    );
  }

  void _openPdfScreen(bool isBookInCurrentReading, BuildContext context) {
    final fileName = book.title!.replaceAll(' ', '-') + book.id!;
    final base64Pdf = book.pdf!.data!.split(',').last;

    saveBase64Pdf(base64Pdf, fileName).then((path) {
      if (isBookInCurrentReading) {
        final currentBookSession = ReadingSessionsRepository
            .instance.readingSessions
            .firstWhere((session) => session.bookId == book.id);
        return context.router.push(BookPdfViewRoute(
          path: path,
          bookName: book.title!,
          currentPage: currentBookSession.currentPage,
          sessionId: currentBookSession.id,
        ));
      } else {
        final provider = locator<ReadingSessionRepositoryProvider>();
        return provider.createSession(book.id!, book.pages!).then((value) {
          final state = provider.state;
          if (state is SuccessState) {
            final sessions = state.data as List<ReadingSession>;
            final session = sessions.first;
            return context.router.push(BookPdfViewRoute(
              path: path,
              bookName: book.title!,
              sessionId: session.id,
              currentPage: session.currentPage,
            ));
          } else if (state is ErrorState) {
            log(state.errorMessage);
          }
        });
      }
    }).catchError((err) {
      log(err.toString());
      throw err;
    });
  }
}
