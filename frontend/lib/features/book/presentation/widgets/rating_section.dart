import 'package:flutter/material.dart';
import '../../../../components/rating_stars.dart';
import '/constants/app_sizes.dart';
import '/constants/app_colors.dart';
import '/constants/app_font_styles.dart';
import '/features/book/data/models/book.dart';

class RatingSection extends StatelessWidget {
  const RatingSection({super.key, required this.book});
  final Book book;
  @override
  Widget build(BuildContext context) {
    final rating = book.ratings!.averageRating;
    return Column(
      children: [
        RatingStars(
          rating: rating,
          editable: false,
        ),
        gapH20,
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: secondaryAccentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    book.ratings!.averageRating.toStringAsPrecision(2),
                    style: secondaryStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Ratings',
                    style: secondaryStyle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    book.genre!,
                    style: secondaryStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Genre',
                    style: secondaryStyle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${book.pages}',
                    style: secondaryStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Pages',
                    style: secondaryStyle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
