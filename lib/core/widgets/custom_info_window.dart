import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/utils/dummy.dart';
import 'package:mo3tarib/core/widgets/custom_button.dart';

import '../../features/add_edit_apartment/model/apartment_model.dart';
import '../../features/add_edit_apartment/model/apartment_params.dart';
import '../../features/add_edit_apartment/model/edit_or_add_apartment_destination.dart';
import '../routing/routes.dart';

class MyInfoWindow extends StatefulWidget {
  const MyInfoWindow({
    super.key,
    this.apartment,
  });

  final ApartmentModel? apartment;

  @override
  State<MyInfoWindow> createState() => _MyInfoWindowState();
}

class _MyInfoWindowState extends State<MyInfoWindow> {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust the height and width of the info window based on screen size
    double customHeight = screenHeight * 0.5; // 30% of screen height
    double customWidth = screenWidth * 0.7; // 70% of screen width

    return Container(
      height: customHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.network(
            widget.apartment!.baseImageURL ?? "",
            fit: BoxFit.contain,
            width: double.infinity,
            height: 80.h,
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.apartment?.city}, ${widget.apartment?.village}",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${widget.apartment?.price} ج م",
                  style: TextStyle(fontSize: 14.sp)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.apartment?.numOfRooms}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Icon(
                    Icons.bed,
                    size: 25.sp,
                    color: Colors.black87,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Align(
            alignment: Alignment.center,
            child: CustomElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  apartmentDetails,
                  arguments: widget.apartment,
                );
              },
              minimumSize: Size(80.w, 20.h),
              child: Text(
                "عرض التفاصيل",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
