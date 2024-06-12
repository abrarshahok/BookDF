import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '/routes/app_router.gr.dart';
import '/components/custom_text_form_field.dart';
import '/constants/app_colors.dart';

class SearchBarSection extends StatelessWidget {
  const SearchBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      prefixIcon: const Icon(
        IconlyLight.search,
        size: 20,
        color: secondaryAccentColor,
      ),
      hintText: 'Search for books',
      readOnly: true,
      onTap: () {
        context.router.push(SearchBooksRoute());
      },
    );
  }
}
