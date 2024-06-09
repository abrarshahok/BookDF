import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '/components/custom_text_form_field.dart';
import '/constants/app_colors.dart';

class SearchBarSection extends StatelessWidget {
  const SearchBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomTextFormField(
        prefixIcon: const Icon(
          IconlyLight.search,
          size: 20,
          color: secondaryAccentColor,
        ),
        hintText: 'Search for books',
        readOnly: true,
        onTap: () {},
      ),
    );
  }
}
