import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/features/department/logic/department_cubit.dart';
import 'package:mo3tarib/features/register/widgets/register_form.dart';
import 'package:mo3tarib/features/register/widgets/register_image.dart';
import '../../core/theme/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  @override
  void initState() {
    context.read<DepartmentCubit>().getDepartments();
    super.initState();
  }

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
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const RegisterImage(),
              SizedBox(
                height: 12.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 40.h),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: const RegisterForm(),
              ),
              SizedBox(
                height: 12.h,
              ),
              Image(
                image: const AssetImage("assets/images/app_logo.png"),
                height: 40.h,
              ),
              SizedBox(
                height: 12.h,
              )
            ],
          ),
        ));
  }
}
