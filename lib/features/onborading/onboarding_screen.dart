import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/routing/routes.dart';
import 'package:mo3tarib/core/theme/colors.dart';

import '../../core/widgets/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 70.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image at the top
              Image.asset(
                'assets/images/onboarding_image.png',
                // Replace with your image asset
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 24),
              // Title
              Text(
                'مرحبًا بك في مغترب',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Subtitle
              Text(
                'مغترب يتيح لك البحث عن سكن والوصول الى سمسار ويتيح لك الوصول الى صنايعي',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),


              const SizedBox(height: 24),
              // Button

              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
                child: CustomElevatedButton(
                  backgroundColor: primaryColor,
                  onPressed: () {
                    Navigator.pushNamed(context, selectRole);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.arrow_back, color: Colors.white),
                      Text("التالي",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
