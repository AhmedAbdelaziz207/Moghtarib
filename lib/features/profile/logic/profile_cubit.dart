import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:mo3tarib/core/network/api_service.dart';
import 'package:mo3tarib/core/utils/preference_manager.dart';
import 'package:mo3tarib/features/profile/logic/profile_state.dart';

import '../../../core/di/di.dart';
import '../../../core/network/api_error_handler.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  ApiService apiService = getIt<ApiService>();

  changePassword(email, password) async {
    emit(ProfileLoading());
    try {
      await apiService.changePassword({
        "email": email,
        "password": password,
      });
      emit(ProfileSuccess());
    } catch (e) {
      final errorMessage = ApiErrorHandler.handle(e).getErrorsMessage();
      emit(ProfileError(message: errorMessage.toString()));
    }
  }

  getProfile() async {
    emit(ProfileLoading());
    try {
      emit(
        ProfileLoaded(
          user:
              await apiService.getProfile(PreferenceManager.getUserId() ?? ""),
        ),
      );
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
