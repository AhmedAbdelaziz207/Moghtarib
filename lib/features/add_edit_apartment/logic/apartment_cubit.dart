import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:mo3tarib/core/network/api_service.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_model.dart';
import '../../../core/di/di.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/api_error_handler.dart';
import '../../../core/network/dio_factory.dart';
import '../model/comment_model.dart';

part 'apartment_state.dart';

class ApartmentCubit extends Cubit<ApartmentState> {
  ApartmentCubit() : super(ApartmentInitial());
  ApiService apiService = getIt<ApiService>();

  List<File> imageFiles = [];

  double minPrice = 0;

  double maxPrice = 10000;

  double distance = 10;

  addApartmentToFavorites(id) {
    try {
      apiService.addFavoriteApartment({
        "apartmentId": id,
      });
      emit(ApartmentAddedToFavorites());
    } catch (e) {
      emit(ApartmentError(message: e.toString()));
    }
  }

  getApartmentComments(id) async {
    log("get apartment comments");

    emit(ApartmentCommentLoading());
    try {
      List<CommentModel> comments = await apiService.getApartmentComments(id);
      emit(ApartmentCommentLoaded(comments: comments));
    } catch (e) {
      log(" error: $e");
      emit(ApartmentCommentFailed(message: e.toString()));
    }
  }

  void getApartment({
    String? temp,
  }) async {
    emit(ApartmentLoading());
    try {
      List<ApartmentModel> apartments = await apiService.getApartments(
        minPrice: minPrice.toInt(),
        maxPrice: maxPrice.toInt(),
        distance: (distance * 10000).toInt(),
        temp: temp,
      );
      log("Get Apartment: ${apartments.length}");
      emit(ApartmentSuccess(apartments: apartments));
    } catch (e) {
      log(" error: $e");
      emit(ApartmentError(message: e.toString()));
    }
  }

  getBrokerApartments() async {
    emit(ApartmentLoading());
    try {
      List<ApartmentModel> apartments =
          await apiService.getAllApartmentForBroker();
      log("Get Apartment: ${apartments.length}");
      emit(ApartmentSuccess(apartments: apartments));
    } catch (e) {
      final errorMessage = ApiErrorHandler.handle(e).getErrorsMessage();
      emit(ApartmentError(
        message: errorMessage.toString(),
      ));
    }
  }

  Future<void> addApartment({
    required ApartmentModel apartment,
  }) async {
    emit(AddApartmentLoading());

    try {
      final Dio dio = DioFactory.getDio();

      // Extract fields from the apartment model
      final queryParams = {
        "City": apartment.city,
        "Village": apartment.village,
        "Location": apartment.location,
        "Price": apartment.price,
        "NumOfRooms": apartment.numOfRooms,
        "Type": apartment.type,
        "address_Lat": apartment.addressLat,
        "address_Lon": apartment.addressLong,
        "IsRent": apartment.isRent,
      };

      // Prepare FormData
      final formData = FormData.fromMap({
        "BaseImage": await MultipartFile.fromFile(
          imageFiles[0].path,
          filename: imageFiles[0].path.split('/').last,
        ),
        "Images": await Future.wait(imageFiles.map((file) async {
          return await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          );
        })),
      });

      // Make request
      await dio.post(
        ApiEndPoints.baseUrl + ApiEndPoints.addApartment,
        queryParameters: queryParams,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      emit(AddApartmentSuccess());

      log("Apartment added successfully.");
    } catch (e) {
      log("Error adding apartment: $e");
      final errorMessage = ApiErrorHandler.handle(e).getErrorsMessage();
      emit(AddApartmentFailed(message: errorMessage.toString()));
    }
  }

  deleteApartment(int id) async {
    try {
      await apiService.deleteApartment(id).then(
            (value) => getBrokerApartments(),
          );
    } catch (e) {
      final errorMessage = ApiErrorHandler.handle(e).getErrorsMessage();
      emit(DeleteApartmentFailed(message: errorMessage.toString()));
    }
  }

  Future<void> addComment(int id, String text) async {
    try {
      await apiService.addApartmentComments({
        "text": text,
        "apartmentId": id,
        "id": 0,
      });
    } catch (e) {
      ApiErrorHandler.handle(e).getErrorsMessage();
    }
  }

  void updateApartment(ApartmentModel updatedApartment) {

  }
}
