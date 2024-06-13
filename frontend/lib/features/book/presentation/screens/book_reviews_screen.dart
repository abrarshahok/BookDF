import 'package:auto_route/auto_route.dart';
import 'package:bookdf/components/custom_error_widget.dart';
import 'package:bookdf/components/custom_memory_image.dart';
import 'package:bookdf/features/book/presentation/widgets/add_review_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_font_styles.dart';
import '../../../../constants/app_sizes.dart';
import '../../../auth/data/models/user.dart';
import '/components/custom_app_top_bar.dart';
import '/components/rating_stars.dart';
import '/dependency_injection/dependency_injection.dart';
import '/features/book/data/models/review.dart';
import '/features/book/presentation/widgets/continue_reading_loading.dart';
import '/providers/book_respository_provider.dart';
import '/states/load_state.dart';

@RoutePage()
class BookReviewsScreen extends StatefulWidget {
  const BookReviewsScreen({
    super.key,
    required this.bookId,
    required this.bookTitle,
  });
  final String bookId;
  final String bookTitle;

  @override
  State<BookReviewsScreen> createState() => _BookReviewsScreenState();
}

class _BookReviewsScreenState extends State<BookReviewsScreen> {
  @override
  void initState() {
    locator<BookRepositoryProvider>().fetchReviews(widget.bookId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Reviews on ${widget.bookTitle}',
        showLeadingButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Consumer<BookRepositoryProvider>(
          builder: (context, provider, _) {
            final state = provider.reviewsState;
            if (state is LoadingState) {
              return const ContinueReadingLoading(
                height: 100,
                width: double.infinity,
                showSizedBox: false,
              );
            } else if (state is SuccessState) {
              final reviews = state.data as List<Review>;

              if (reviews.isEmpty) {
                return Center(
                  child: Text(
                    'No reviews found!',
                    style: secondaryStyle,
                  ),
                );
              }

              return ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  final user = review.userDetails!;
                  return Column(
                    children: [
                      customUserReviewTile(user, review),
                      const Divider(),
                    ],
                  );
                },
              );
            } else if (state is ErrorState) {
              CustomErrorWidget(errorMessage: state.errorMessage);
            }

            return const SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddReviewDialog(),
          );
        },
        backgroundColor: secondaryColor,
        tooltip: 'Add Review',
        child: const Icon(
          Icons.add,
          color: bgColor,
        ),
      ),
    );
  }

  Widget customUserReviewTile(User user, Review review) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomMemoryImage(
            imageString: user.pic!,
            height: 50,
            width: 40,
            cacheKey: user.pic!,
            fit: BoxFit.cover,
          ),
          gapW8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2.5),
                  child: Text(
                    user.username!,
                    style: secondaryStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2.5),
                  child: Text(
                    review.reviewText!,
                    style: secondaryStyle.copyWith(),
                  ),
                ),
                RatingStars(
                  alignment: Alignment.centerLeft,
                  rating: review.rating!,
                  editable: false,
                  iconSize: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
