import 'package:geolocator/geolocator.dart';

sealed class AccessLocationState {}

class AccessLocationInitial extends AccessLocationState {}

class AccessLocationLoading extends AccessLocationState {}

class AccessLocationLoaded extends AccessLocationState {
  Position location ;
  AccessLocationLoaded({required this.location});
}

class AccessLocationError extends AccessLocationState {
  final String message;
  AccessLocationError({required this.message});
}