import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:bookdf/components/custom_memory_image.dart';
import 'package:bookdf/features/book/data/models/book.dart';
import 'package:bookdf/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import '/components/custom_button.dart';
import '/constants/app_colors.dart';
import '/constants/app_font_styles.dart';
import '/constants/app_sizes.dart';

class CategoryBookContainer extends StatefulWidget {
  const CategoryBookContainer({super.key, required this.book});

  final Book book;

  @override
  State<CategoryBookContainer> createState() => _CategoryBookContainerState();
}

class _CategoryBookContainerState extends State<CategoryBookContainer> {
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
    bytes = base64Decode(widget.book.coverImage!.split(',').last);
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
    return GestureDetector(
      onTap: () => context.router.push(BookDetailsRoute(book: widget.book)),
      child: SizedBox(
        height: 275,
        width: 300,
        key: ValueKey(widget.book.id!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 144,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isLoading ? secondaryAccentColor : dominantColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: isLoading
                  ? null
                  : CustomMemoryImage(
                      imageString: widget.book.coverImage!,
                      height: 100,
                      width: double.infinity,
                      cacheKey: widget.book.id!,
                    ),
            ),
            gapH12,
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    widget.book.title!,
                    style: titleStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.star,
                  color: tercharyColor,
                  size: 14,
                ),
                gapW4,
                Text(
                  widget.book.ratings!.averageRating.toStringAsPrecision(2),
                  style: secondaryLightStyle.copyWith(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            SizedBox(
              width: 120,
              child: Text(
                widget.book.author!,
                style: secondaryStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            CustomButton(
              label: 'Check Now',
              height: 29,
              borderRadius: 8,
              onPressed: () {
                context.router.push(BookDetailsRoute(book: widget.book));
              },
            ),
          ],
        ),
      ),
    );
  }
}
