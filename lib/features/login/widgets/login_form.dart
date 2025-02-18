import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/features/login/logic/login_cubit.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/colors.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../logic/login_state.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Text(
            'أهلاً بك نحن سعداء بانضمامك',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15.h),
          CustomTextFormField(
            hintText: 'البريد الإلكتروني',
            prefixIcon: Icons.email,
            controller: context.read<LoginCubit>().emailController,
          ),
          SizedBox(height: 15.h),
          CustomTextFormField(
            prefixIcon: Icons.lock,
            hintText: 'كلمة المرور',
            obscureText: true,
            controller: context.read<LoginCubit>().passwordController,
          ),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, forgotPassword),
              child: Text(
                'هل نسيت كلمة المرور؟',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          BlocConsumer<LoginCubit, LoginState>(
            listener: handleLoginState,
            builder: (context,state) {
              return ElevatedButton(
                onPressed: state is LoginLoading ? (){} : () {
                  if (formKey.currentState!.validate()) {
                    context.read<LoginCubit>().login();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: secondaryColor,
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: state is LoginLoading ? CircularProgressIndicator(color: secondaryColor,) : Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          ),
          SizedBox(height: 15.h),

               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ليس لديك حساب؟',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {


                      Navigator.pushNamed(context, register);
                    },
                    child: Text(
                      'إنشاء حساب',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],

          ),
        ],
      ),
    );
  }

  handleLoginState(BuildContext context, LoginState state) {
    if (state is LoginError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message ?? 'Unknown error occurred'),
        ),
      );

    }
    if(state is LoginSuccess){
      Navigator.pushNamedAndRemoveUntil(context, home, (route) => false);
    }

  }
}
