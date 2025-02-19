import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mo3tarib/core/constants/assets.dart';

class ApartmentImagesSection extends StatefulWidget {
  final List<String> initialImageUrls;

  const ApartmentImagesSection({
    super.key,
    required this.initialImageUrls,
  });

  @override
  State<ApartmentImagesSection> createState() => _ApartmentImagesSectionState();
}

class _ApartmentImagesSectionState extends State<ApartmentImagesSection> {
  final PageController _pageController = PageController();
  int selectedIndex = 0;
  late List<String> imageUrls;
  final Map<int, File?> tempFiles = {};

  @override
  void initState() {
    super.initState();
    imageUrls = List.from(widget.initialImageUrls);
  }

  Future<void> _editImage(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        tempFiles[index] = File(pickedFile.path);
      });
    }
  }

  void _deleteImage(int index) {
    setState(() {
      imageUrls.removeAt(index);
      tempFiles.remove(index);
      selectedIndex = (selectedIndex - 1).clamp(0, imageUrls.length - 1);
    });
  }

  void _addImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageUrls.add(pickedFile.path);
        tempFiles[imageUrls.length - 1] = File(pickedFile.path);
        selectedIndex = imageUrls.length - 1;
      });
    }
  }

  void _saveChanges() {
    setState(() {
      tempFiles.forEach((index, file) {
        if (file != null) {
          imageUrls[index] = file.path;
        }
      });
      tempFiles.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: _addImage,
          child: Row(
            children: [
              SizedBox(width: 8.w),
              Image.asset(Assets.iconsAddImage, width: 30, height: 30),
              SizedBox(width: 8.w),
              Expanded(
                child: SizedBox(
                  height: 300,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      final tempFile = tempFiles[index];
                      return InkWell(
                        onTap: () => _editImage(index),
                        child: Stack(
                          children: [
                            tempFile != null
                                ? Image.file(tempFile, fit: BoxFit.fitHeight, width: double.infinity)
                                : Image.network(imageUrls[index], fit: BoxFit.contain, width: double.infinity),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.black, size: 30),
                                    onPressed: () => _editImage(index),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red, size: 30),
                                    onPressed: () => _deleteImage(index),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imageUrls.length,
                (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                width: selectedIndex == index ? 16 : 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.orange,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
