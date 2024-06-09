import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import '/features/home/presentation/screens/all_books_screen.dart';
import '/features/home/presentation/widgets/book_category_chip.dart';
import '/features/home/presentation/widgets/continue_reading_book_container.dart';
import '/components/custom_text_form_field.dart';
import '/constants/app_sizes.dart';
import '/components/custom_icon_button.dart';
import '/constants/app_font_styles.dart';
import '/constants/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.scrollController});
  final ScrollController scrollController;
  final categories = const [
    'All',
    'Romance',
    'Sci-Fi',
    'Fantasy',
    'Classics',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Book',
                style: titleStyle,
              ),
              TextSpan(
                text: 'DF',
                style: titleAccentStyle,
              ),
            ],
          ),
        ),
        actions: [
          CustomIconButton(
            onTap: () {},
            icon: Icons.add,
            iconColor: accentColor,
          )
        ],
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    prefixIcon: const Icon(
                      FeatherIcons.search,
                      size: 20,
                      color: secondaryAccentColor,
                    ),
                    hintText: 'Search for books',
                    readOnly: true,
                    onTap: () {},
                  ),
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
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 60.0,
              maxHeight: 60.0,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories
                        .map(
                          (cat) => BookCategoryChip(
                            category: cat,
                            onTap: () {},
                            isSelected: cat == 'All',
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: AllBooksScreen(),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
