import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3tarib/core/routing/routes.dart';
import 'package:mo3tarib/features/add_edit_apartment/add_edit_apartment_screen.dart';
import 'package:mo3tarib/features/add_edit_apartment/edit_apartment_screen.dart';
import 'package:mo3tarib/features/add_edit_apartment/logic/apartment_cubit.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_model.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_params.dart';
import 'package:mo3tarib/features/apartment_details/ui/apartment_details_screen.dart';
import 'package:mo3tarib/features/chat/logic/chat_cubit.dart';
import 'package:mo3tarib/features/chat/ui/message_screen.dart';
import 'package:mo3tarib/features/department/logic/department_cubit.dart';
import 'package:mo3tarib/features/favorites/logic/favorites_cubit.dart';
import 'package:mo3tarib/features/forgot_password/views/forgot_password_screen.dart';
import 'package:mo3tarib/features/forgot_password/views/reset_password_screen.dart';
import 'package:mo3tarib/features/home/logic/home_cubit.dart';
import 'package:mo3tarib/features/home/ui/student_home_screen.dart';
import 'package:mo3tarib/features/landing/landing_screen.dart';
import 'package:mo3tarib/features/login/login_screen.dart';
import 'package:mo3tarib/features/onborading/onboarding_screen.dart';
import 'package:mo3tarib/features/otp/logic/otp_cubit.dart';
import 'package:mo3tarib/features/otp/otp_screen.dart';
import 'package:mo3tarib/features/profile/logic/profile_cubit.dart';
import 'package:mo3tarib/features/register/logic/register_cubit.dart';
import 'package:mo3tarib/features/register/register_screen.dart';
import 'package:mo3tarib/features/select_role/select_role.dart';
import '../../features/access_apartmen_location/access_location_screen.dart';
import '../../features/access_apartmen_location/logic/access_location_cubit.dart';
import '../../features/login/logic/login_cubit.dart';
import '../../features/register/model/user_model.dart';
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
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => OtpCubit(),
          child: const ForgotPasswordScreen(),
        ),
      );
    case resetPassword:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => ProfileCubit(),
          child: const ResetPasswordScreen(),
        ),
      );
    case otp:
      final args = settings.arguments as Map<String, dynamic>?;
      final email = args?['email'];
      final code = args?['code'].toString();
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => OtpCubit(),
          child: OtpScreen(
            phoneNumberOrEmail: email ?? "email@example.com",
            code: code,
          ),
        ),
      );
    // case home:
    //   return MaterialPageRoute(
    //     builder: (_) => MultiBlocProvider(
    //       providers: [
    //         BlocProvider(create: (_) => HomeCubit()..navigateToApartment()),
    //         BlocProvider(create: (_) => ApartmentCubit()),
    //       ],
    //       child: const StudentHomeBody(),
    //     ),
    //   );
    case landing:
      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => HomeCubit()..navigateToApartment()),
            BlocProvider(create: (_) => ApartmentCubit()),
            BlocProvider(create: (_) => FavoritesCubit()),
            BlocProvider(create: (_) => ProfileCubit()),
          ],
          child: const LandingScreen(),
        ),
      );

    case editApartment:
      final params = settings.arguments as ApartmentModel;

      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ApartmentCubit()),
            BlocProvider(create: (_) => AccessLocationCubit()),
          ],
          child: EditApartmentScreen(
            apartment: params,
          ),
        ),
      );

    case addOrEditApartment:
      final params = settings.arguments as ApartmentDetailsParams;

      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ApartmentCubit()),
            BlocProvider(create: (_) => AccessLocationCubit()),
          ],
          child: AddEditApartmentScreen(
            params: params,
          ),
        ),
      );

    case apartmentDetails:
      final params = settings.arguments as ApartmentModel;

      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ApartmentCubit()),
            BlocProvider(create: (_) => FavoritesCubit()),
          ],
          child: ApartmentDetailsScreen(
            apartment: params,
          ),
        ),
      );
    case chat:
      final params = settings.arguments as UserModel;
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => ChatCubit(),
          child: MessagesScreen(
            receiver: params,
          ),
        ),
      );
    default:
      return null;
  }
}
