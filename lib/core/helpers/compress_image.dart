// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as p;
// import 'package:flutter_image_compress/flutter_image_compress.dart';
//
// class  CompressImage {
//
//
//   static Future<XFile> compressProfileImage({
//     required File imageFile,
//     int quality = 75, // Lowered quality
//     CompressFormat format = CompressFormat.jpeg, // Switched to JPEG
//     int minWidth = 800, // Resize width
//     int minHeight = 600, // Resize height
//   }) async {
//     // Get the size of the original image (before compression)
//     int originalSize = await imageFile.length();
//     print('Original image size: ${_formatFileSize(originalSize)}');
//
//     // Path to store the compressed image
//     final String targetPath = p.join(Directory.systemTemp.path, 'profile${DateTime.now().millisecondsSinceEpoch}.jpg'); // Match file extension
//
//     // Compress the image
//     final XFile? compressedImage = await FlutterImageCompress.compressAndGetFile(
//       imageFile.path,
//       targetPath,
//       quality: quality,
//       format: format,
//       minWidth: minWidth,
//       minHeight: minHeight,
//     );
//
//     if (compressedImage == null) {
//       throw ("Failed to compress the image");
//     }
//
//     // Get the size of the compressed image (after compression)
//     int compressedSize = await File(compressedImage.path).length();
//     print('Compressed image size: ${_formatFileSize(compressedSize)}');
//     return compressedImage;
//   }
//
//
//
//   static Future<XFile> compressDocumentImage({
//     required File imageFile,
//     int quality = 75, // Lowered quality
//     CompressFormat format = CompressFormat.jpeg, // Switched to JPEG
//     int minWidth = 800, // Resize width
//     int minHeight = 600, // Resize height
//   }) async {
//     // Get the size of the original image (before compression)
//     int originalSize = await imageFile.length();
//     print('Original image size: ${_formatFileSize(originalSize)}');
//
//     // Path to store the compressed image
//     final String targetPath = p.join(Directory.systemTemp.path, 'document${DateTime.now().millisecondsSinceEpoch}.jpg'); // Match file extension
//
//     // Compress the image
//     final XFile? compressedImage = await FlutterImageCompress.compressAndGetFile(
//       imageFile.path,
//       targetPath,
//       quality: quality,
//       format: format,
//       minWidth: minWidth,
//       minHeight: minHeight,
//     );
//
//     if (compressedImage == null) {
//       throw ("Failed to compress the image");
//     }
//
//     // Get the size of the compressed image (after compression)
//     int compressedSize = await File(compressedImage.path).length();
//     print('Compressed image size: ${_formatFileSize(compressedSize)}');
//     return compressedImage;
//   }
//
//
//
//   static String _formatFileSize(int bytes) {
//     const int kb = 1024;
//     const int mb = 1024 * 1024;
//
//     if (bytes >= mb) {
//       return '${(bytes / mb).toStringAsFixed(2)} MB';
//     } else if (bytes >= kb) {
//       return '${(bytes / kb).toStringAsFixed(2)} KB';
//     } else {
//       return '$bytes Bytes';
//     }
//   }
//
//
//
//
// }