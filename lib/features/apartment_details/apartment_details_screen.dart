import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/widgets/custom_button.dart';
import 'package:mo3tarib/core/widgets/map_screen.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_model.dart';
import 'package:mo3tarib/features/apartment_details/widget/apartment_details_images.dart';
import 'package:mo3tarib/features/apartment_details/widget/rating_and_comment_section.dart';

import '../../core/constants/assets.dart';

class ApartmentDetailsScreen extends StatelessWidget {
  const ApartmentDetailsScreen({super.key, required this.apartment});

  final ApartmentModel apartment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ApartmentDetailsImages(apartment: apartment),
              SizedBox(height: 18.h),
              RatingBar(
                ignoreGestures: true,
                itemSize: 30.r,
                initialRating: 3.5,
                allowHalfRating: true,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  half: const Icon(
                    Icons.star_half,
                    color: Colors.orange,
                  ),
                  empty: const Icon(
                    Icons.star_border,
                    color: Colors.grey,
                  ),
                ),
                onRatingUpdate: (double value) {},
              ),
              SizedBox(
                height: 18.h,
              ),
              Card(
                elevation: 3,
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      "${apartment.price} ج م ",
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    const Divider(
                      thickness: .1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // Adjust spacing if needed
                        children: [
                          Wrap(
                            spacing: 16,
                            // Adjust spacing between groups
                            runSpacing: 8,
                            // Adjust spacing between wrapped rows
                            direction: Axis.vertical,
                            // Ensures wrapping in a vertical stack
                            children: [
                              Row(
                                children: [
                                  buildApartmentDetailsItem(Icons.bed_sharp,
                                      apartment.numOfRooms.toString()),
                                  SizedBox(width: 8.w),
                                  buildApartmentDetailsItem(
                                      Icons.person_outline,
                                      apartment.userName.toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  buildApartmentDetailsItem(Icons.aspect_ratio,
                                      "${apartment.distanceByMeters ?? ""} م"),
                                  SizedBox(width: 8.w),
                                  buildApartmentDetailsItem(
                                      Icons.place_outlined,
                                      apartment.village.toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  buildApartmentDetailsItem(
                                    Icons.autorenew_outlined,
                                    "غير متوفر",
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "الموقع",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MapScreen(
                                        displayedApartment: [apartment],
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 3,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      Assets.imagesMap,
                                      width: 320.w,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100.h,
                    )
                  ],
                ),
              ),
              const RatingAndCommentSection(),
              SizedBox(
                height: 100.h,
              )
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomElevatedButton(
          child: const Text(
            "تواصل مع العميل",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  buildApartmentDetailsItem(IconData icon, String title, {Color? color}) {
    return Card(
        color: Colors.white,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30.sp,
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: color ?? Colors.black,
                ),
              )
            ],
          ),
        ));
  }
}
