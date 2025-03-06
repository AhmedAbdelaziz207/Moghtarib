import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/widgets/map_screen.dart';
import 'package:mo3tarib/features/home/widget/home_technicals_section.dart';

import '../../../core/utils/dummy.dart';
import '../widget/user_home_header_section.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  String? searchCategory = "شقة";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              UserHomeHeaderSection(
                onSelected: (value) {
                  setState(() {
                    searchCategory = value;
                  });
                },
              ),
              if (searchCategory == "شقة")
                SizedBox(
                  height: 420.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: MapScreen(
                      displayedApartment: apartments,
                      showInfoWindow: true,
                      showMyLocation: true,
                    ),
                  ),
                ),
              if (searchCategory != "شقة")
                SizedBox(
                  height: MediaQuery.of(context).size.height - 200.h,
                  child: const HomeTechnicalsSection(),
                )
            ],
          ),
        ),
      ),
    );
  }
}
