import 'package:bookdf/constants/app_colors.dart';
import 'package:bookdf/constants/app_font_styles.dart';
import 'package:flutter/material.dart';

class BookGenreChip extends StatelessWidget {
  final String genre;
  final VoidCallback onTap;
  final bool isSelected;

  const BookGenreChip({
    super.key,
    required this.genre,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 31,
        decoration: BoxDecoration(
          color: isSelected ? secondaryColor : Colors.white,
          border: Border.all(color: Colors.grey.shade900),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(right: 8),
        alignment: Alignment.center,
        child: Text(
          genre,
          style: isSelected ? secondaryButtonStyle : primaryButtonStyle,
        ),
      ),
    );
  }
}
