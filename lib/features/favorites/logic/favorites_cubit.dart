import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:mo3tarib/core/network/api_service.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_model.dart';

import '../../../core/di/di.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());
  ApiService apiService = getIt<ApiService>();
  List<ApartmentModel> apartments = [];

  getFavorites() async {
    emit(FavoritesLoading());
    try {
      final List<ApartmentModel> apartments =
          await apiService.getFavoriteApartments();


      emit(FavoritesLoaded(apartments: apartments));
      return apartments;
    } catch (e) {
      emit(
        FavoritesError(
          message: e.toString(),
        ),
      );
      return [];
    }
  }

  Future<bool> isFavorite(int id) async {
    emit(IsFavoritesLoading());

    final favorites = await getFavorites();

    if (favorites == null) {
      log("⚠️ Favorites list is null");
      emit(IsFavoritesDone(state: false));
      return false;
    }

    for (ApartmentModel apartment in favorites) {
      if (apartment.id == id) {
        log("✅ isFavorite: ${apartment.id}");
        emit(IsFavoritesDone(state: true));
        return true;
      }
    }

    log("❌ Is not Favorite");
    emit(IsFavoritesDone(state: false));
    return false;
  }

  addApartmentToFavorites(id) {
    try {
      apiService.addFavoriteApartment({
        "apartmentId": id,
      });
      emit(AddedFavoriteSuccess());
    } catch (e) {

    }
  }

  removeFavoriteApartment(int id) async {
    emit(DeleteFavoriteLoading());
    try {
      await apiService.removeFavoriteApartment(id);
      getFavorites();
      emit(DeleteFavoriteSuccess());
    } catch (e) {
      emit(
        FavoritesError(
          message: e.toString(),
        ),
      );
    }
  }
}
