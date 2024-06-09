import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_images.dart';

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
