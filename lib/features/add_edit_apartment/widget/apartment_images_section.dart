import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mo3tarib/core/constants/assets.dart';

import '../logic/apartment_cubit.dart';

class ApartmentImagesSection extends StatefulWidget {
  const ApartmentImagesSection({super.key});

  @override
  State<ApartmentImagesSection> createState() => _ApartmentImagesSectionState();
}

class _ApartmentImagesSectionState extends State<ApartmentImagesSection> {
  final PageController _pageController = PageController();
  int selectedIndex = 0;

  Future<void> _addImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        context.read<ApartmentCubit>().imageFiles.add(File(pickedFile.path));

        selectedIndex = context.read<ApartmentCubit>().imageFiles.length - 1;
      });
    }
  }

  void _deleteImage(int index) {
    setState(() {
      context.read<ApartmentCubit>().imageFiles.removeAt(index);
      selectedIndex = (selectedIndex - 1).clamp(0, context.read<ApartmentCubit>().imageFiles.length - 1);
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
                  child: context.read<ApartmentCubit>().imageFiles.isEmpty
                      ? const Center(child: Text("لم يتم إضافة صور بعد"))
                      : PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => selectedIndex = index);
                    },
                    itemCount: context.read<ApartmentCubit>().imageFiles.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Image.file(
                            context.read<ApartmentCubit>().imageFiles[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red, size: 30),
                              onPressed: () => _deleteImage(index),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        if (context.read<ApartmentCubit>().imageFiles.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              context.read<ApartmentCubit>().imageFiles.length,
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

  /// Optional: To retrieve selected image files for upload
  List<File> getSelectedImages() => context.read<ApartmentCubit>().imageFiles;
}
