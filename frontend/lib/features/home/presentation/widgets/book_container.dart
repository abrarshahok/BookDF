import 'package:bookdf/components/custom_button.dart';
import 'package:bookdf/components/custom_icon_button.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import '/constants/app_colors.dart';
import '/constants/app_font_styles.dart';
import '/constants/app_sizes.dart';

class BookContainer extends StatefulWidget {
  const BookContainer({
    super.key,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.rating,
  });

  final String title;
  final String author;
  final String imageUrl;
  final double rating;

  @override
  State<BookContainer> createState() => _BookContainerState();
}

class _BookContainerState extends State<BookContainer> {
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
                : Image.network(
                    widget.imageUrl,
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
                '${widget.rating}',
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
            children: [
              CustomButton(
                label: 'Check Now',
                height: 29,
                width: 109,
                borderRadius: 8,
                onPressed: () {},
              ),
              const Spacer(),
              CustomIconButton(
                onTap: () {},
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
