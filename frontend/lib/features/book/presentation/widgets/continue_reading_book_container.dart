import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:bookdf/routes/app_router.gr.dart';

import '../../../../utils/save_base64_pdf.dart';
import '/components/animated_slider.dart';
import '/components/custom_border_button.dart';
import '/constants/app_colors.dart';
import '/constants/app_font_styles.dart';
import '/constants/app_sizes.dart';
import '/features/book/data/models/reading_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:palette_generator/palette_generator.dart';

class ContinueReadingBookContainer extends StatefulWidget {
  const ContinueReadingBookContainer({
    super.key,
    required this.readingSession,
  });

  final ReadingSession readingSession;

  @override
  State<ContinueReadingBookContainer> createState() =>
      _ContinueReadingBookContainerState();
}

class _ContinueReadingBookContainerState
    extends State<ContinueReadingBookContainer> {
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
    bytes = base64Decode(
        widget.readingSession.bookDetails.coverImage!.split(',').last);
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
    final progressValue = widget.readingSession.currentPage == 0.0
        ? 0.0
        : (widget.readingSession.currentPage /
                widget.readingSession.totalPages) *
            100;
    return SizedBox(
      height: 144,
      width: 290,
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
                : Image.memory(
                    bytes,
                    fit: BoxFit.contain,
                  ),
          ),
          gapW12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.readingSession.bookDetails.title!,
                  style: titleStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.readingSession.bookDetails.author!,
                  style: secondaryStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                gapH12,
                AnimatedSlider(currentValue: progressValue),
                gapH16,
                CustomBorderButton(
                  label: 'Continue...',
                  height: 29,
                  width: 109,
                  borderRadius: 8,
                  onPressed: () {
                    final book = widget.readingSession.bookDetails;
                    final fileName =
                        book.title!.replaceAll(' ', '-') + book.id!;
                    final base64Pdf = book.pdf!.split(',').last;
                    saveBase64Pdf(base64Pdf, fileName).then((path) {
                      return context.router.push(
                        BookPdfViewRoute(
                          path: path,
                          sessionId: widget.readingSession.id,
                          bookName: book.title!,
                          currentPage: widget.readingSession.currentPage,
                        ),
                      );
                    }).catchError((err) {
                      throw err;
                    });
                  },
                ),
              ],
            ),
          ),
          gapW48,
        ],
      ),
    );
  }
}
