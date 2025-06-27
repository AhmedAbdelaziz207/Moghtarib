import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import '../../core/routing/routes.dart';
import '../../core/theme/colors.dart';
import 'logic/otp_cubit.dart';
import 'logic/otp_state.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    this.phoneNumberOrEmail,
    this.code,
  });

  final String? phoneNumberOrEmail;
  final String? code;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otpCode = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.r),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text("رمز التحقق"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ادخل رمز التحقق المرسل إليك",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Icon(Icons.mail_outline, color: Colors.grey.shade600),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        widget.phoneNumberOrEmail ?? "",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "تغيير",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Center(
                    child: Pinput(
                      length: 4,
                      autofocus: true,
                      showCursor: true,
                      onChanged: (value) {
                        otpCode = value;
                        log("otpCode: $otpCode");
                        setState(() {});
                      },
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                BlocConsumer<OtpCubit, OtpState>(
                  listener: (context, state) {

                    if (state is OtpErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(state.message),
                        ),
                      );
                    }

                    if (state is OtpSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("تم التحقق بنجاح"),
                        ),
                      );
                      Navigator.pushReplacementNamed(context, resetPassword);
                    }

                  },
                  builder: (context, state) => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        log("Code : ${widget.code} - OtpCode: $otpCode");
                        context.read<OtpCubit>().verifyEmailOTP(widget.code!,otpCode);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        minimumSize: Size(double.infinity, 50.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: state is OtpLoadingState
                          ? const CircularProgressIndicator()
                          : Text(
                              'تاكيد',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                // Center(
                //   child: ResendOtp(
                //     phoneNumberOrEmail: widget.phoneNumberOrEmail,
                //     token: widget.token,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
