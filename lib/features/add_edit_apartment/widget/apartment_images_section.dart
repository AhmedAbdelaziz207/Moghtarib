import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mo3tarib/core/constants/assets.dart';

import '../../../core/network/api_endpoints.dart';
import '../logic/apartment_cubit.dart';

class ApartmentImagesSection extends StatefulWidget {
  const ApartmentImagesSection({
    super.key,
    this.imageUrls = const [],
  });

  final List<String> imageUrls;

  @override
  State<ApartmentImagesSection> createState() => _ApartmentImagesSectionState();
}

class _ApartmentImagesSectionState extends State<ApartmentImagesSection> {
  final PageController _pageController = PageController();
  int selectedIndex = 0;

  List<File> get imageFiles => context.read<ApartmentCubit>().imageFiles;

  Future<void> _addImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFiles.add(File(pickedFile.path));
        selectedIndex = widget.imageUrls.length + imageFiles.length - 1;
      });
    }
  }

  void _deleteImage(int index) {
    final totalUrls = widget.imageUrls.length;

    if (index >= totalUrls) {
      final localIndex = index - totalUrls;
      setState(() {
        imageFiles.removeAt(localIndex);
        selectedIndex = (selectedIndex - 1).clamp(0, totalUrls + imageFiles.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalImages = widget.imageUrls.length + imageFiles.length;

    return Column(
      children: [
        InkWell(
          onTap: _addImage,
          child: Row(
            children: [
              SizedBox(width: 8.w),
              if (widget.imageUrls.isEmpty)
              Image.asset(Assets.iconsAddImage, width: 30, height: 30),
              SizedBox(width: 8.w),
              Expanded(
                child: SizedBox(
                  height: 300,
                  child: totalImages == 0
                      ? const Center(child: Text("لا يوجد صور"))
                      : PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) => setState(() => selectedIndex = index),
                    itemCount: totalImages,
                    itemBuilder: (context, index) {
                      final isLocal = index >= widget.imageUrls.length;

                      return Stack(
                        children: [
                          Positioned.fill(
                            child: isLocal
                                ? Image.file(
                              imageFiles[index - widget.imageUrls.length],
                              fit: BoxFit.cover,
                            )
                                : Image.network(
                             ApiEndPoints.imagesUrl + widget.imageUrls[index],
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return const Center(child: CircularProgressIndicator());
                              },
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                            ),
                          ),
                          if (isLocal)
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
        SizedBox(height: 8.h),
        if (totalImages > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalImages,
                  (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  width: selectedIndex == index ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: selectedIndex == index ? Colors.orange : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: 20),
      ],
    );
  }

  List<File> getSelectedImages() => imageFiles;
}
