import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3tarib/core/di/di.dart';
import 'package:mo3tarib/core/network/api_error_handler.dart';
import 'package:mo3tarib/core/network/api_service.dart';
import 'package:mo3tarib/core/utils/preference_manager.dart';
import 'package:mo3tarib/features/login/logic/login_request_body.dart';
import 'package:mo3tarib/features/login/logic/login_response.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  void login() async {
    emit(LoginLoading());

    try {
      LoginResponse response = (await getIt<ApiService>().login(
        LoginRequestBody(
          email: emailController.text,
          password: passwordController.text,
        ).toJson(),
      )) ;


      log("response: ${response.toJson()}");

      saveCredentials(response);

      emit(LoginSuccess());
    } catch (e) {
      log(" error: $e");
      final errorMessage = ApiErrorHandler.handle(e).getErrorsMessage();
      emit(LoginError(message: errorMessage));
    }
  }

  void saveCredentials(LoginResponse response) {
     PreferenceManager.saveToken(response.token);
     PreferenceManager.saveUsername(response.userName);
     PreferenceManager.saveUserRole(response.role!);
  }
}
