import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/network/api_endpoints.dart';
import 'package:mo3tarib/core/routing/routes.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_model.dart';

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
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    // Adjust the height and width of the info window based on screen size
    double customHeight = screenHeight * 0.4; // 30% of screen height
    double customWidth = screenWidth * 0.7; // 70% of screen width

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15.r),
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r)),
      ),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: SizedBox(
          width: customWidth,
          height: customHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [
            Image.network(
            ApiEndPoints.imagesUrl + widget.apartment!.baseImageURL!,
              fit:  BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) =>
                  Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image_rounded, size: 50.sp),
                  ),
              height: 40.h,
              width:  100.w,
            ),
            SizedBox(height: 10.h),
            Text(
                "${widget.apartment?.city ?? 'Unknown'} - ${widget.apartment
                    ?.location ?? "Unknown" }",
            style:
            TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("${widget.apartment?.price.toString() ?? "0"} ج م"),
              Row(
                children: [
                  Text(
                    widget.apartment?.numOfRooms.toString() ?? "  3   ",
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Icon(Icons.bed, size: 20.sp),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                apartmentDetails,
                arguments: widget.apartment,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Text(
              "عرض التفاصيل",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          )
          ],
        ),
      ),
    ),)
    ,
    );
  }
}
