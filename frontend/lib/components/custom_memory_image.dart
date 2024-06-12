import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomMemoryImage extends StatelessWidget {
  const CustomMemoryImage({
    super.key,
    required this.imageString,
    required this.height,
    required this.width,
    required this.cacheKey,
    this.fit,
  });

  final String imageString;
  final double height;
  final double width;
  final String cacheKey;
  final BoxFit? fit;

  Uint8List _decodeBase64(String dataUrl) {
    final base64Str = dataUrl.split(',').last;
    return base64Decode(base64Str);
  }

  Future<Uint8List> _loadImage() async {
    final key = cacheKey;
    final cacheManager = DefaultCacheManager();

    final file = await cacheManager.getFileFromCache(key);
    if (file != null) {
      return file.file.readAsBytesSync();
    }

    final decodedImage = _decodeBase64(imageString);
    await cacheManager.putFile(key, decodedImage);
    return decodedImage;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _loadImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Image.memory(
              snapshot.data!,
              width: width,
              height: height,
              fit: fit ?? BoxFit.contain,
            );
          } else if (snapshot.hasError) {
            return const Icon(Icons.error);
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
