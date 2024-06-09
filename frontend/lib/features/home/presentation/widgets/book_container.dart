import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:palette_generator/palette_generator.dart';
import '/components/custom_button.dart';
import '/components/custom_icon_button.dart';
import '/constants/app_colors.dart';
import '/constants/app_font_styles.dart';
import '/constants/app_sizes.dart';

class BookContainer extends StatefulWidget {
  const BookContainer({
    super.key,
    required this.title,
    required this.author,
    required this.base64image,
    required this.rating,
    required this.bookId,
  });

  final String title;
  final String author;
  final String base64image;
  final double rating;
  final String bookId;

  @override
  State<BookContainer> createState() => _BookContainerState();
}

class _BookContainerState extends State<BookContainer> {
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
    bytes = base64Decode(widget.base64image.split(',').last);
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(MemoryImage(bytes));

    setState(() {
      dominantColor = paletteGenerator.dominantColor?.color ??
          secondaryAccentColor.withOpacity(0.5);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275,
      width: 300,
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
                : Image.memory(
                    key: ValueKey(widget.bookId),
                    bytes,
                    fit: BoxFit.contain,
                  ),
          ),
          gapH12,
          Row(
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  widget.title,
                  style: titleStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.star,
                color: tercharyColor,
                size: 11,
              ),
              gapW4,
              Text(
                widget.rating.toStringAsPrecision(2),
                style: secondaryLightStyle.copyWith(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: Text(
              widget.author,
              style: secondaryStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                label: 'Check Now',
                height: 29,
                width: 130,
                borderRadius: 8,
                onPressed: () {},
              ),
              gapW4,
              CustomIconButton(
                onTap: () {},
                size: 30,
                iconColor: secondaryColor,
                icon: FeatherIcons.bookmark,
              )
            ],
          ),
        ],
      ),
    );
  }
}
