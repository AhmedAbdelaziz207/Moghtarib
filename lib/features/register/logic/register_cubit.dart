import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3tarib/core/constants/user_role.dart';
import 'package:mo3tarib/core/di/di.dart';
import 'package:mo3tarib/core/network/api_service.dart';
import 'package:mo3tarib/core/utils/preference_manager.dart';
import 'package:mo3tarib/features/register/model/UserModel.dart';
import 'package:mo3tarib/features/register/model/register_repsonse.dart';
import '../../../core/network/api_error_handler.dart';
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
      final RegisterResponse response = await getIt<ApiService>().register(
        UserModel(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          userName: userNameController.text,
          email: emailController.text,
          nationalId: nationalIdController.text,
          phoneNumber: phoneNumberController.text,
          whatsappNumber: whatsappController.text,
          password: passwordController.text,
          websiteURL: websiteController.text,
          role: UserRole.translate(PreferenceManager.getUserRole()),
          departmentId: selectedDepartmentId,
        ).toJson(),
      );

      emit(RegisterSuccess(response: response));
    } catch (e) {
      final errorMessage = ApiErrorHandler.handle(e).getErrorsMessage();
      emit(RegisterError(
        message: errorMessage,
      ));
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
