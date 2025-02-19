import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'access_location_state.dart';

class AccessLocationCubit extends Cubit<AccessLocationState> {
  AccessLocationCubit() : super(AccessLocationInitial());
  late Position location;

  Future<void> getUserLocation() async {
    log("get User Location");
    try {
      emit(AccessLocationLoaded(location: location));
    } catch (e) {
      emit(AccessLocationError(message: e.toString()));
    }
  }


}
