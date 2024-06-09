import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:readmore/readmore.dart';
import 'package:auto_route/auto_route.dart';

import '../../../../utils/save_base64_pdf.dart';
import '/components/custom_button.dart';
import '/components/custom_icon_button.dart';
import '/constants/app_images.dart';
import '/features/book/data/models/book.dart';
import '/routes/app_router.gr.dart';
import '/constants/app_sizes.dart';
import '/constants/app_font_styles.dart';
import '/constants/app_colors.dart';

@RoutePage()
class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BookDetailsAppBar(
            coverImage: book.coverImage!,
          ),
          SliverToBoxAdapter(
            child: BookTitleAndAuthor(
              bookTitle: book.title!,
              bookAuthor: book.author!,
            ),
          ),
          SliverToBoxAdapter(
              child: RatingSection(
            book: book,
          )),
          SliverToBoxAdapter(
              child: BookDescription(
            description: book.description!,
          )),
          // const SliverToBoxAdapter(child: ReviewsSection()),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: bgColor,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            gapW20,
            CustomIconButton(
              onTap: () {},
              icon: IconlyLight.bookmark,
              iconColor: accentColor,
              size: 30,
            ),
            gapW8,
            CustomButton(
              width: 300,
              height: 50,
              borderRadius: 8,
              elevation: 5,
              label: 'Start Reading',
              textStyle: buttonStyle,
              onPressed: () {
                final fileName = book.title!.replaceAll(' ', '-') + book.id!;
                final base64Pdf = book.pdf!.split(',').last;
                log(fileName);
                saveBase64Pdf(base64Pdf, fileName).then((path) {
                  log(path);
                  return context.router.push(
                      BookPdfViewRoute(path: path, bookName: book.title!));
                }).catchError((err) {
                  log(err.toString());
                  throw err;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BookDetailsAppBar extends StatefulWidget {
  const BookDetailsAppBar({super.key, required this.coverImage});
  final String coverImage;

  @override
  State<BookDetailsAppBar> createState() => _BookDetailsAppBarState();
}

class _BookDetailsAppBarState extends State<BookDetailsAppBar> {
  Color? dominantColor;

  late Uint8List bytes;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _updatePalette();
  }

  Future<void> _updatePalette() async {
    isLoading = true;
    bytes = base64Decode(widget.coverImage.split(',').last);
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(MemoryImage(bytes));

    if (mounted) {
      setState(() {
        dominantColor = paletteGenerator.dominantColor?.color ??
            secondaryAccentColor.withOpacity(0.5);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: isLoading ? secondaryAccentColor : dominantColor,
            image: isLoading
                ? null
                : const DecorationImage(
                    opacity: 0.05,
                    image: AssetImage(pattern),
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.repeat,
                  ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Image.memory(
                  bytes,
                  fit: BoxFit.contain,
                ),
        ),
      ),
      leading: IconButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(secondaryColor.withOpacity(0.4)),
        ),
        icon: const Icon(
          IconlyLight.arrow_left,
          color: bgColor,
        ),
        onPressed: () => context.router.maybePop(),
      ),
    );
  }
}

class BookTitleAndAuthor extends StatelessWidget {
  const BookTitleAndAuthor(
      {super.key, required this.bookTitle, required this.bookAuthor});
  final String bookTitle;
  final String bookAuthor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            bookTitle,
            style: titleStyle,
          ),
          Text(
            'by $bookAuthor',
            style: secondaryStyle,
          ),
        ],
      ),
    );
  }
}

class RatingSection extends StatelessWidget {
  const RatingSection({super.key, required this.book});
  final Book book;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: secondaryAccentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            color: tercharyColor,
            size: 14,
          ),
          gapW4,
          Text(
            book.ratings!.averageRating.toStringAsPrecision(2),
            style: secondaryStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Text(
            book.genre!,
            style: secondaryStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            '${book.pages}',
            style: secondaryStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          gapW4,
          Text(
            'Pages',
            style: secondaryStyle.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

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

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Reviews', style: subtitleStyle),
          gapH16,
          const ReviewItem(
            reviewer: 'John Doe',
            comment: 'Great book! Highly recommend it.',
            rating: 5,
          ),
          gapH12,
          const ReviewItem(
            reviewer: 'Jane Smith',
            comment: 'Interesting read but a bit slow in the middle.',
            rating: 3,
          ),
        ],
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final String reviewer;
  final String comment;
  final int rating;

  const ReviewItem({
    super.key,
    required this.reviewer,
    required this.comment,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          IconlyLight.star,
          color: rating >= 1 ? Colors.amber : Colors.grey,
        ),
        gapW8,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(reviewer, style: secondaryStyle),
              gapH4,
              Text(comment, style: secondaryStyle),
            ],
          ),
        ),
      ],
    );
  }
}
