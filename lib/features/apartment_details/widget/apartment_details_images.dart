import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_model.dart';

class ApartmentDetailsImages extends StatefulWidget {
  const ApartmentDetailsImages({super.key, required this.apartment});

  final ApartmentModel apartment;

  @override
  State<ApartmentDetailsImages> createState() => _ApartmentDetailsImagesState();
}

class _ApartmentDetailsImagesState extends State<ApartmentDetailsImages> {
  int selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Row(
              children: [
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
                      itemCount: widget.apartment.imagesURL?.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          widget.apartment.imagesURL![index],
                        );
                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.apartment.imagesURL!.length,
                        (index) => GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Container(
                              padding: EdgeInsets.all(2.sp),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedIndex == index
                                      ? Colors.orange
                                      : Colors.grey.withOpacity(0),
                                  width: selectedIndex == index ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.network(
                                widget.apartment.imagesURL![index],
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 20,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_outline,
                  size: 30,
                  color: Colors.black87,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 4.h,
        ),
        // Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.apartment.imagesURL!.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                width: selectedIndex == index ? 16 : 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: selectedIndex == index ? Colors.orange : Colors.orange,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
