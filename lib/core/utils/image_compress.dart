// import 'dart:io';
// import 'package:flutter_image_compress/flutter_image_compress.dart';

// class ImageCompress {
//   Future<File?> compressFile(File file) async {
//     final filePath = file.absolute.path;

//     final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
//     final splitted = filePath.substring(0, lastIndex);
//     final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

//     var result = await FlutterImageCompress.compressAndGetFile(
//       file.absolute.path,
//       outPath,
//       quality: 50,
//     );

//     if (result != null) {
//       print('Original size: ${file.lengthSync()} bytes');
//       print('Compressed size: ${result.length()} bytes');
//     } else {
//       print('Compression failed');
//     }

//     return File(result!.path);
//   }
// }
