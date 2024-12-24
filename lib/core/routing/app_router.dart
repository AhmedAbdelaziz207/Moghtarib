import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3tarib/core/routing/routes.dart';
import 'package:mo3tarib/features/department/logic/department_cubit.dart';
import 'package:mo3tarib/features/forgot_password/views/forgot_password_screen.dart';
import 'package:mo3tarib/features/forgot_password/views/reset_password_screen.dart';
import 'package:mo3tarib/features/login/login_screen.dart';
import 'package:mo3tarib/features/onborading/onboarding_screen.dart';
import 'package:mo3tarib/features/register/logic/register_cubit.dart';
import 'package:mo3tarib/features/register/register_screen.dart';
import 'package:mo3tarib/features/select_role/select_role.dart';

import '../../features/login/logic/login_cubit.dart';
import '../../features/splash/splash_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splash:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case onboarding:
      return MaterialPageRoute(builder: (_) => const OnboardingScreen());
    case selectRole:
      return MaterialPageRoute(builder: (_) => const SelectUserRoleScreen());
    case login:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => LoginCubit(),
          child: const LoginScreen(),
        ),
      );
    case register:
      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(providers: [
          BlocProvider(create: (_) => RegisterCubit()),
          BlocProvider(create: (_) => DepartmentCubit()),
        ], child: const RegisterScreen()),
      );
    case forgotPassword:
      return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
    case resetPassword:
      return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

    default:
      return null;
  }
}
