import 'package:bookdf/constants/app_font_styles.dart';
import 'package:flutter/material.dart';

class BookTitleAndAuthor extends StatelessWidget {
  const BookTitleAndAuthor(
      {super.key, required this.bookTitle, required this.bookAuthor});
  final String bookTitle;
  final String bookAuthor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            bookTitle,
            style: titleStyle,
          ),
          Text(
            'by $bookAuthor',
            style: secondaryStyle,
          ),
        ],
      ),
    );
  }
}
