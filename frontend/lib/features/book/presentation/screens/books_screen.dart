import '/features/book/presentation/widgets/categories_header.dart';
import '/features/book/presentation/widgets/continue_reading_section.dart';
import '/features/book/presentation/widgets/search_bar_section.dart';
import 'package:flutter/widgets.dart';

import '../../../../constants/app_sizes.dart';
import '../widgets/books_category_section.dart';

List<Widget> booksScreen = [
  const SliverToBoxAdapter(child: SearchBarSection()),
  const SliverToBoxAdapter(child: ContinueReadingSection()),
  const CategoriesHeader(),
  const SliverPadding(
    padding: EdgeInsets.symmetric(horizontal: Sizes.p20, vertical: Sizes.p8),
    sliver: BooksCategorySection(),
  ),
];
