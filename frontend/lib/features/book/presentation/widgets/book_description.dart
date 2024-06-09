import 'package:bookdf/constants/app_colors.dart';
import 'package:bookdf/constants/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class BookDescription extends StatelessWidget {
  const BookDescription({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ReadMoreText(
        '$description ',
        lessStyle: secondaryStyle.copyWith(
          fontWeight: FontWeight.bold,
          color: accentColor,
        ),
        moreStyle: secondaryStyle.copyWith(
          fontWeight: FontWeight.bold,
          color: accentColor,
        ),
        style: secondaryStyle,
      ),
    );
  }
}
