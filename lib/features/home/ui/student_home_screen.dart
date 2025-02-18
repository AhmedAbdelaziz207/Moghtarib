import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mo3tarib/core/constants/assets.dart';
import 'package:mo3tarib/core/widgets/map_screen.dart';

class StudentHomeBody extends StatelessWidget {
  const StudentHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        physics:  const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 30.h,),
              SizedBox(
                height: 500.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: const MapScreen(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
