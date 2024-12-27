import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/api_error_handler.dart';
import '../../../core/network/services/webservice.dart';
import '../../../core/utils/di.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    emit(LoginLoading());
    try {
      await getIt<Webservice>().login({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim()
      });


      emit(LoginSuccess());
    } catch (e) {
      log("Login error: $e");
      if (e is DioException) {
        emit(LoginError(message: getErrorMessage(e)));
      } else {
        emit(LoginError(message: e.toString()));
      }

  }
}

@override
Future<void> close() {
  emailController.dispose();
  passwordController.dispose();
  return super.close();
}}
