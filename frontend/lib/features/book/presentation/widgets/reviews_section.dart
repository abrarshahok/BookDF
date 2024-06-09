import 'package:flutter/material.dart';
import '/constants/app_font_styles.dart';
import '/constants/app_sizes.dart';
import '/features/book/presentation/widgets/review_item.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Reviews', style: subtitleStyle),
          gapH16,
          const ReviewItem(
            reviewer: 'John Doe',
            comment: 'Great book! Highly recommend it.',
            rating: 5,
          ),
          gapH12,
          const ReviewItem(
            reviewer: 'Jane Smith',
            comment: 'Interesting read but a bit slow in the middle.',
            rating: 3,
          ),
        ],
      ),
    );
  }
}
