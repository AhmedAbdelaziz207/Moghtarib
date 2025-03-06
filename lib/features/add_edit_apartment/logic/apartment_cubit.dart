
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_model.dart';

import '../../../core/di/di.dart';
import '../../../core/network/api_error_handler.dart';
import '../../../core/network/api_service.dart';
import '../model/apartment_comment.dart';
part 'apartment_state.dart';

class ApartmentCubit extends Cubit <ApartmentState> {
  ApartmentCubit() : super(ApartmentInitial());

  void getApartments() async {
    emit(ApartmentLoading());
    try {
      List<ApartmentModel>? apartments =
          await getIt<ApiService>().getApartments();
      emit(GetApartmentSuccess(apartments: apartments));
    } catch (e) {
      final message = ApiErrorHandler.handle(e).getErrorsMessage();
      emit(ApartmentError(message: message));
    }
  }

  void getFavoriteApartments() async {
    emit(ApartmentLoading());
    try {
      List<ApartmentModel>? apartments =
          await getIt<ApiService>().getFavouriteApartments();
      emit(GetApartmentSuccess(apartments: apartments));
    } catch (e) {
      final message = ApiErrorHandler.handle(e).getErrorsMessage();
      emit(ApartmentError(message: message));
    }
  }

  void addApartmentToFavourites(apartmentId) async {
    emit(ApartmentLoading());
    try {
          await getIt<ApiService>().addFavouriteApartment(apartmentId);
    } catch (e) {
      final message = ApiErrorHandler.handle(e).getErrorsMessage();
      emit(ApartmentError(message: message));
    }
  }
  void removeApartmentFromFavourites(apartmentId) async {
    emit(ApartmentLoading());
    try {
          await getIt<ApiService>().addFavouriteApartment(apartmentId);
    } catch (e) {
      final message = ApiErrorHandler.handle(e).getErrorsMessage();
      emit(ApartmentError(message: message));
    }
  }


}
