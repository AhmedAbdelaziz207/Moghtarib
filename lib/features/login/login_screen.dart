import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/constants/assets.dart';
import 'package:mo3tarib/features/login/widgets/login_form.dart';

import '../../core/theme/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80.h),
              Image.asset(
                Assets.appLogo, // Replace with your logo path
                height: 80.h,
              ),
              SizedBox(height: 10.h),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: const LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
