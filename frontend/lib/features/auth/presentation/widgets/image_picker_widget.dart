import 'dart:io';
import 'package:bookdf/constants/app_colors.dart';
import 'package:bookdf/constants/app_font_styles.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../providers/auth_repository_provider.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:provider/provider.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function onImagePicked;
  final String? imageUrl;
  const ImagePickerWidget(this.onImagePicked, {super.key, this.imageUrl});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _loadedImage;

  Future<void> _addImage() async {
    final auth = Provider.of<AuthRepositoryProvider>(context, listen: false);
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (pickedImage == null) {
      return;
    }
    _loadedImage = File(pickedImage.path);
    auth.selectImage(_loadedImage!);
  }

  Future<void> _clickImage() async {
    final auth = Provider.of<AuthRepositoryProvider>(context, listen: false);

    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickedImage == null) {
      return;
    }

    _loadedImage = File(pickedImage.path);

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final imageName = path.basename(pickedImage.path);
    final imageFile = File(pickedImage.path);
    final savedImage = File('${appDir.path}/$imageName');
    await savedImage.writeAsBytes(await imageFile.readAsBytes());
    auth.selectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: Consumer<AuthRepositoryProvider>(
            builder: (context, auth, _) => auth.pickedImage != null
                ? Image.file(
                    auth.pickedImage!,
                    fit: BoxFit.cover,
                  )
                // : widget.imageUrl != null
                //     ? CachedNetworkImage(imageUrl: widget.imageUrl!)
                : Text(
                    'No Image!',
                    style: secondaryButtonStyle,
                  ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                icon: const Icon(
                  FeatherIcons.image,
                ),
                onPressed: _addImage,
                label: Text(
                  'Add Image',
                  style: primaryButtonStyle,
                ),
              ),
              TextButton.icon(
                icon: const Icon(
                  FeatherIcons.camera,
                ),
                onPressed: _clickImage,
                label: Text(
                  'Click Image',
                  style: primaryButtonStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
