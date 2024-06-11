import 'dart:io';
import '/constants/app_colors.dart';
import '/constants/app_font_styles.dart';
import '/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

import 'custom_button.dart';
import 'custom_memory_image.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(File) onImagePicked;
  final String? imageString;
  final String? cacheKey;

  const ImagePickerWidget({
    super.key,
    required this.onImagePicked,
    this.imageString,
    this.cacheKey,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _loadedImage;

  Future<void> _addImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (pickedImage == null) {
      return;
    }
    _loadedImage = File(pickedImage.path);
    widget.onImagePicked(_loadedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1,
                color: secondaryColor,
              ),
            ),
            alignment: Alignment.center,
            child: _loadedImage != null
                ? Image.file(
                    _loadedImage!,
                    fit: BoxFit.cover,
                  )
                : (widget.imageString != null && widget.cacheKey != null)
                    ? CustomMemoryImage(
                        height: 100,
                        width: 100,
                        cacheKey: widget.cacheKey!,
                        imageString: widget.imageString!,
                      )
                    : Text(
                        'No Image',
                        style: secondaryStyle.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
          ),
          gapH12,
          CustomButton(
            onPressed: _addImage,
            color: _loadedImage != null ? wrong : secondaryColor,
            label: _loadedImage != null ? 'Reselect' : 'Add Image',
            leadingIcon: IconlyLight.image,
            height: 40,
            elevation: 5,
            borderRadius: 8,
          ),
        ],
      ),
    );
  }
}
