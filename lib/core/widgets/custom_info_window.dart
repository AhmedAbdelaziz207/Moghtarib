

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyInfoWindow extends StatefulWidget {
  const MyInfoWindow({
    super.key,
  });


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
        ),
      ),
    );
  }
}
