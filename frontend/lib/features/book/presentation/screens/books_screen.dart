import 'package:bookdf/features/auth/data/respository/auth_respository.dart';
import 'package:bookdf/providers/auth_repository_provider.dart';
import 'package:provider/provider.dart';
import '/features/book/presentation/widgets/categories_header.dart';
import '/features/book/presentation/widgets/continue_reading_section.dart';
import '/features/book/presentation/widgets/search_bar_section.dart';
import 'package:flutter/widgets.dart';

import '../../../../constants/app_sizes.dart';
import '../widgets/books_category_section.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: gapH20),
        const SliverToBoxAdapter(child: SearchBarSection()),
        Consumer<AuthRepositoryProvider>(
          builder: (context, provider, _) => SliverToBoxAdapter(
            child:
                AuthRepository.instance.currentUser!.currentReadings!.isNotEmpty
                    ? const ContinueReadingSection()
                    : const SizedBox(),
          ),
        ),
        const CategoriesHeader(),
        const BooksCategorySection(),
      ],
    );
  }
}
