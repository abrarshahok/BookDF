import 'package:bookdf/features/auth/data/respository/auth_respository.dart';
import '/features/book/presentation/widgets/categories_header.dart';
import '/features/book/presentation/widgets/continue_reading_section.dart';
import '/features/book/presentation/widgets/search_bar_section.dart';
import 'package:flutter/widgets.dart';

import '../../../../constants/app_sizes.dart';
import '../widgets/books_category_section.dart';

List<Widget> booksScreen = [
  const SliverToBoxAdapter(child: gapH20),
  const SliverToBoxAdapter(child: SearchBarSection()),
  if (AuthRepository.instance.currentUser!.currentReadings!.isNotEmpty)
    const SliverToBoxAdapter(child: ContinueReadingSection()),
  const CategoriesHeader(),
  const SliverPadding(
    padding: EdgeInsets.symmetric(horizontal: Sizes.p20, vertical: Sizes.p8),
    sliver: BooksCategorySection(),
  ),
];
