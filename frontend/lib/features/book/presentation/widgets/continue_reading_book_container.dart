import 'package:bookdf/components/animated_slider.dart';
import 'package:bookdf/components/custom_border_button.dart';
import 'package:bookdf/constants/app_colors.dart';
import 'package:bookdf/constants/app_font_styles.dart';
import 'package:bookdf/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ContinueReadingBookContainer extends StatefulWidget {
  const ContinueReadingBookContainer({
    super.key,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.readingProgress,
  });

  final String title;
  final String author;
  final String imageUrl;
  final double readingProgress;

  @override
  State<ContinueReadingBookContainer> createState() =>
      _ContinueReadingBookContainerState();
}

class _ContinueReadingBookContainerState
    extends State<ContinueReadingBookContainer> {
  Color? dominantColor;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _updatePalette();
  }

  Future<void> _updatePalette() async {
    isLoading = true;
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.imageUrl),
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
                : Image.network(
                    widget.imageUrl,
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
                  widget.title,
                  style: titleStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.author,
                  style: secondaryStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                gapH12,
                AnimatedSlider(currentValue: widget.readingProgress),
                gapH16,
                CustomBorderButton(
                  label: 'Continue...',
                  height: 29,
                  width: 109,
                  borderRadius: 8,
                  onPressed: () {},
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
