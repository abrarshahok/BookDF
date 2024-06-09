import 'package:bookdf/constants/app_colors.dart';
import 'package:bookdf/constants/app_font_styles.dart';
import 'package:bookdf/constants/app_sizes.dart';
import 'package:bookdf/features/book/data/models/book.dart';
import 'package:flutter/material.dart';

class RatingSection extends StatelessWidget {
  const RatingSection({super.key, required this.book});
  final Book book;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: secondaryAccentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            color: tercharyColor,
            size: 14,
          ),
          gapW4,
          Text(
            book.ratings!.averageRating.toStringAsPrecision(2),
            style: secondaryStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Text(
            book.genre!,
            style: secondaryStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            '${book.pages}',
            style: secondaryStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          gapW4,
          Text(
            'Pages',
            style: secondaryStyle.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
