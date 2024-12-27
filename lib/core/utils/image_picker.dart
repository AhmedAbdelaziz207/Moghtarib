import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage(ImageSource source) async {
  var picker = ImagePicker();

  XFile? image = await picker.pickImage(source: source);
  return image;
}
