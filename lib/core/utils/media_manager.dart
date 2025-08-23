import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

// class ImageData {
//   final Uint8List bytes;
//   final String name;
//   final String path;

//   ImageData._(this.name, this.bytes, this.path);
//   // bytes = data.readAsBytes(),
//   // name = data.name;

//   static Future<ImageData> fromXFile(XFile file) async =>
//       ImageData._(file.name, await file.readAsBytes(), file.path);
// }

final class ImageData {
  final String? imageUrl;
  final bool isRemote;
  bool get isLocal => !isRemote;
  final Uint8List? bytes;
  final String? name;
  bool get isNotEmpty => bytes != null || imageUrl != null;
  const ImageData._({
    this.imageUrl,
    required this.isRemote,
    this.bytes,
    this.name,
  });
  const ImageData.network(String url, {this.name})
    : isRemote = true,
      imageUrl = url,
      bytes = null;
  const ImageData.file(String url, {this.name})
    : isRemote = false,
      imageUrl = url,
      bytes = null;

  const ImageData({required this.imageUrl, required this.isRemote, this.name})
    : bytes = null;

  static Future<ImageData> fromXFile(XFile file) async => ImageData._(
    name: file.name,
    bytes: await file.readAsBytes(),
    imageUrl: file.path,
    isRemote: false,
  );
}

class MediaManager {
  static Future<ImageData?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      requestFullMetadata: false,
    );
    if (pickedFile != null) {
      return ImageData.fromXFile(pickedFile);
    } else {
      return null;
    }
  }
}
