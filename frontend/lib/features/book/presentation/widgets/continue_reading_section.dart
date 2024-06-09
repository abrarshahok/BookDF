import 'package:bookdf/constants/app_font_styles.dart';
import 'package:bookdf/constants/app_sizes.dart';
import 'package:bookdf/features/book/presentation/widgets/continue_reading_book_container.dart';
import 'package:flutter/material.dart';

class ContinueReadingSection extends StatelessWidget {
  const ContinueReadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH20,
          Text(
            'Continue Reading',
            style: titleStyle,
          ),
          gapH12,
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ContinueReadingBookContainer(
                  title: 'Animal Farm',
                  author: 'George Orwell',
                  imageUrl:
                      'https://static-01.daraz.pk/p/43df5da0946070ced3ff7acbaecc2c70.jpg',
                  readingProgress: 40,
                ),
                ContinueReadingBookContainer(
                  title: 'Transcription',
                  author: 'Kate Atkinson',
                  imageUrl:
                      'https://www.sheethappenspublishing.com/cdn/shop/files/Firewind-Best-Of_Printed.jpg?v=1689638450',
                  readingProgress: 50,
                ),
              ],
            ),
          ),
          gapH20,
        ],
      ),
    );
  }
}
