import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/colors.dart';

class RegisterImage extends StatefulWidget {
  const RegisterImage({super.key});

  @override
  State<RegisterImage> createState() => _RegisterImageState();
}

class _RegisterImageState extends State<RegisterImage> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return    InkWell(
      onTap: () async {
        XFile? pickedImage = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );

        if (pickedImage != null) {
          setState(() {
            image = File(pickedImage.path);
          });
        }
      },
      child: CircleAvatar(
        backgroundColor: secondaryColor,
        radius: 50.r,
        backgroundImage: image != null
            ? FileImage(image ?? File(""))
            : const AssetImage("assets/images/avatar.png"),
      ),
    );
  }
}
