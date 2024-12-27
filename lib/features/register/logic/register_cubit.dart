import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3tarib/core/network/model/UserModel.dart';
import 'package:mo3tarib/core/utils/preference_manager.dart';
import '../../../core/helpers/api_error_handler.dart';
import '../../../core/network/model/user_role.dart';
import '../../../core/network/services/webservice.dart';
import '../../../core/utils/di.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();

  int? selectedDepartmentId;

  Future<void> register() async {
    emit(RegisterLoading());

    try {
      await getIt<Webservice>().createAccount(
        UserModel(
          userName: userNameController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,
          phoneNumber: phoneNumberController.text,
          nationalId: nationalIdController.text,
          websiteURL: websiteController.text,
          whatsappNumber: whatsappController.text,
          role: PreferenceManager.getUserRole() ?? UserRole.student,
        ).toJson(),
      );

      emit(RegisterSuccess());
    } catch (e) {
      // Check if the exception is a DioException and get the error message from it

      if (e is DioException) {
        emit(RegisterError(message: getErrorMessage(e)));
      } else {
        emit(RegisterError(message: e.toString()));
      }
      log("Register error: $e");
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    websiteController.dispose();
    whatsappController.dispose();
    phoneNumberController.dispose();
    nationalIdController.dispose();
    emailController.dispose();
    passwordController.dispose();

    return super.close();
  }
}
