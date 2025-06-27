import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'access_location_state.dart';

class AccessLocationCubit extends Cubit<AccessLocationState> {
  AccessLocationCubit() : super(AccessLocationInitial());
  late Position location;

  Future<Position?> getUserLocation() async {
    log("get User Location");
    emit(AccessLocationLoading());
    try {
      location = await Geolocator.getCurrentPosition();
      emit(AccessLocationLoaded(location: location));
      return location;
    } catch (e) {
      emit(AccessLocationError(message: e.toString()));
      return location;
    }
  }
}
