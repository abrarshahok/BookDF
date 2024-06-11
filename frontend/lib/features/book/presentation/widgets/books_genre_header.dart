import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/book_genre_provider.dart';
import '/features/home/presentation/widgets/sliver_app_bar_delegate.dart';
import 'book_genre_chip.dart';

class BooksGenreHeader extends StatefulWidget {
  const BooksGenreHeader({super.key});

  @override
  State<BooksGenreHeader> createState() => _BooksGenreHeaderState();
}

class _BooksGenreHeaderState extends State<BooksGenreHeader> {
  final genre = const [
    'All',
    'Romance',
    'Sci-Fi',
    'Fantasy',
    'Classics',
    'Technology',
    'Education',
  ];

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookGenreProvider>(builder: (ctx, provider, _) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleScrollLogic(provider);
      });

      return SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          minHeight: 60.0,
          maxHeight: 60.0,
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Row(
                children: genre
                    .map(
                      (category) => BookGenreChip(
                        category: category,
                        onTap: () {
                          provider.set(category);
                        },
                        isSelected: category == provider.genre,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      );
    });
  }

  void _handleScrollLogic(BookGenreProvider provider) {
    if (provider.genre == 'Classics') {
      _scrollToMax();
    } else if (_isScrolledToEnd()) {
      _scrollToStart();
    }
  }

  bool _isScrolledToEnd() {
    double totalWidth = _scrollController.position.maxScrollExtent +
        _scrollController.position.viewportDimension;
    return totalWidth >= _scrollController.position.maxScrollExtent;
  }

  void _scrollToMax() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToStart() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
