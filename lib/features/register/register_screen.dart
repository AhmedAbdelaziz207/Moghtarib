import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/constants/assets.dart';
import 'package:mo3tarib/features/department/logic/department_cubit.dart';
import 'package:mo3tarib/features/register/widgets/register_form.dart';
import '../../core/theme/colors.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _formOffset;
  late Animation<double> _logoFade;

  @override
  void initState() {
    super.initState();
    context.read<DepartmentCubit>().getDepartments();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _formOffset = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _logoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12.h),

            /// Fade-in Logo
            FadeTransition(
              opacity: _logoFade,
              child: Image.asset(
                Assets.appLogo,
                height: 80.h,
              ),
            ),

            SizedBox(height: 12.h),

            /// Slide-in Register Form
            SlideTransition(
              position: _formOffset,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 40.h),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: const RegisterForm(),
              ),
            ),

            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}
