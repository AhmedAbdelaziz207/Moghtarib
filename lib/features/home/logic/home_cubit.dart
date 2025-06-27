import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:mo3tarib/core/di/di.dart';
import 'package:mo3tarib/core/network/api_service.dart';
import 'package:mo3tarib/features/register/model/user_model.dart';

import '../../../core/network/api_error_handler.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  ApiService apiService = getIt<ApiService>();

  navigateToTechnical() {
    emit(NavigateToTechnicalsPage());
  }
  navigateToApartment() {
    emit(NavigateToApartmentPage());
  }

  getTechnicals() async {
    try {
      emit(GetTechnicalsLoading());
      List<UserModel> technicians = await apiService.getAllTechnicians();

      emit(GetTechnicals(techs: technicians));
    } catch (e) {
      final errorMessage = ApiErrorHandler.handle(e).getErrorsMessage();

      emit(GetTechnicalsError(message: errorMessage.toString()));
    }
  }



}
