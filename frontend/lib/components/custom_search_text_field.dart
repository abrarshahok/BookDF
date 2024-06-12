import 'package:bookdf/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../constants/app_font_styles.dart';
import '/constants/app_sizes.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.autoFocus = false,
    this.onChanged,
    this.onSubmitted,
  });

  final String hintText;
  final TextEditingController? controller;
  final bool readOnly;
  final bool autoFocus;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p12,
      ),
      decoration: BoxDecoration(
        color: secondaryAccentColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            IconlyLight.search,
            color: secondaryAccentColor,
          ),
          gapW8,
          Expanded(
            child: TextField(
              onTap: onTap,
              autofocus: autoFocus,
              readOnly: readOnly,
              controller: controller,
              style: secondaryStyle.copyWith(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: secondaryStyle.copyWith(),
                border: InputBorder.none,
              ),
              onSubmitted: onSubmitted,
              onChanged: onChanged,
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus!.unfocus();
              },
            ),
          ),
        ],
      ),
    );
  }
}
