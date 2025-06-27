import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/routing/routes.dart';
import 'package:mo3tarib/features/otp/logic/otp_cubit.dart';
import 'package:mo3tarib/features/otp/logic/otp_state.dart';

import '../../../core/theme/colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const SizedBox(),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Text(
                'هل نسيت كلمة المرور؟',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Text(
                'لا داعي للقلق من الوصول مرة أخرى\nباستخدام بريدك الإلكتروني أو رقم الهاتف',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h),
              Form(
                key: formKey,
                child: TextFormField(
                  controller: context.read<OtpCubit>().emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'البريد الإلكتروني لا يمكن ان يكون فارغ';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'البريد الإلكتروني أو رقم الهاتف',
                    hintStyle: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1.5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              BlocConsumer<OtpCubit, OtpState>(
                listener: (context, state) {
                  if (state is OtpSentSuccess) {
                    Navigator.pushNamed(
                      context,
                      otp,
                      arguments: {
                        'email': context.read<OtpCubit>().emailController.text,
                        "code": state.code
                      },
                    );
                  }
                  if (state is OtpErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      context.read<OtpCubit>().sendEmailOTP();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      minimumSize: Size(double.infinity, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: state is OtpSentLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'إرسال الرمز',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                },
              ),
              SizedBox(height: 100.h),
              Image.asset(
                'assets/images/app_logo.png', // Replace with your logo path
                height: 60.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
