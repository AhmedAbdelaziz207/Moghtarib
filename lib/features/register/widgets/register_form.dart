import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/features/register/logic/register_cubit.dart';
import 'package:mo3tarib/features/register/widgets/professionDropDown.dart';

import '../../../core/theme/colors.dart';
import '../../../core/widgets/custom_text_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hintText: 'الأسم الاول',
            prefixIcon: Icons.person,
            controller: context.read<RegisterCubit>().firstNameController,
          ),
          SizedBox(height: 15.h),
          CustomTextFormField(
            hintText: 'الأسم الاخير',
            prefixIcon: Icons.person,
            controller: context.read<RegisterCubit>().lastNameController,
          ),
          SizedBox(height: 15.h),
          CustomTextFormField(
            prefixIcon: Icons.lock,
            hintText: 'كلمة المرور',
            obscureText: true,
            controller: context.read<RegisterCubit>().passwordController,
          ),
          SizedBox(height: 15.h),
          CustomTextFormField(
            hintText: 'رقم الموبيل',
            prefixIcon: Icons.phone,
            controller: context.read<RegisterCubit>().phoneNumberController,
          ),
          SizedBox(height: 15.h),
          CustomTextFormField(
            hintText: 'رقم الواتساب',
            prefixIcon: Icons.phone,
            controller: context.read<RegisterCubit>().whatsappController,
          ),
          SizedBox(height: 15.h),
          CustomTextFormField(
            hintText: 'الرقم القومي',
            prefixIcon: Icons.add_card_sharp,
            controller: context.read<RegisterCubit>().nationalIdController,
          ),
          SizedBox(height: 15.h),
          CustomTextFormField(
            prefixIcon: Icons.web,
            hintText: 'لينك موقعك الإلكتروني',
            obscureText: true,
            controller: context.read<RegisterCubit>().websiteController,
          ),
          SizedBox(height: 20.h),
          const ProfessionDropdown(),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<RegisterCubit>().register();
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
            child: Text(
              'انشاء حساب',
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
