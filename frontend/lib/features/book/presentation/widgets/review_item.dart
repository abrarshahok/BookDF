import 'package:bookdf/constants/app_font_styles.dart';
import 'package:bookdf/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ReviewItem extends StatelessWidget {
  final String reviewer;
  final String comment;
  final int rating;

  const ReviewItem({
    super.key,
    required this.reviewer,
    required this.comment,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          IconlyLight.star,
          color: rating >= 1 ? Colors.amber : Colors.grey,
        ),
        gapW8,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(reviewer, style: secondaryStyle),
              gapH4,
              Text(comment, style: secondaryStyle),
            ],
          ),
        ),
      ],
    );
  }
}
