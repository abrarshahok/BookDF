import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:bookdf/components/confirmation_dialogue.dart';
import 'package:bookdf/components/custom_icon_button.dart';
import 'package:bookdf/dependency_injection/dependency_injection.dart';
import 'package:bookdf/providers/library_books_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconly/iconly.dart';
import 'package:palette_generator/palette_generator.dart';
import '../../../../components/custom_border_button.dart';
import '../../../../components/custom_button.dart';
import '/components/custom_memory_image.dart';
import '/constants/app_colors.dart';
import '/constants/app_font_styles.dart';
import '/constants/app_sizes.dart';
import '/features/book/data/models/book.dart';

class LibraryBookContainer extends StatefulWidget {
  const LibraryBookContainer({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  State<LibraryBookContainer> createState() => _LibraryBookContainerState();
}

class _LibraryBookContainerState extends State<LibraryBookContainer> {
  Color? dominantColor;
  bool isLoading = false;
  late Uint8List bytes;

  @override
  void initState() {
    super.initState();
    _updatePalette();
  }

  Future<void> _updatePalette() async {
    isLoading = true;
    bytes = base64Decode(widget.book.coverImage!.split(',').last);
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      MemoryImage(bytes),
    );

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
    return Container(
      height: 144,
      width: 290,
      key: ValueKey(widget.book.id!),
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 144,
            width: 100,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isLoading ? secondaryAccentColor : dominantColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: isLoading
                ? null
                : CustomMemoryImage(
                    imageString: widget.book.coverImage!,
                    height: 100,
                    width: 100,
                    cacheKey: widget.book.id!,
                  ),
          ),
          gapW12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.book.title!,
                  style: titleStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.book.author!,
                  style: secondaryStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                // gapH12,
                // AnimatedSlider(currentValue: progressValue),
                const Spacer(),
                Row(
                  children: [
                    CustomBorderButton(
                      label: 'Read..',
                      height: 29,
                      width: 80,
                      borderRadius: 8,
                      onPressed: () {},
                    ),
                    gapW8,
                    CustomButton(
                      label: 'Edit',
                      height: 29,
                      width: 70,
                      borderRadius: 8,
                      onPressed: () {},
                    ),
                    gapW8,
                    CustomIconButton(
                      onTap: () {
                        ConfirmationDialogue(
                          context: context,
                          onTapPrimary: () {
                            final libraryProvider =
                                locator<LibraryBooksProvider>();
                            libraryProvider.deleteBook(
                              widget.book.id!,
                              context,
                            );
                            context.router.maybePop();
                          },
                          onTapSecondary: () {
                            context.router.maybePop();
                          },
                          title: 'Are you sure?',
                          subtitle: 'Do you want to delete book?',
                          buttonTextSecondary: 'Cancel',
                          buttonTextPrimary: 'I Confirm!',
                          textAlign: TextAlign.left,
                        ).show();
                      },
                      icon: IconlyBold.delete,
                      iconColor: wrong,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
