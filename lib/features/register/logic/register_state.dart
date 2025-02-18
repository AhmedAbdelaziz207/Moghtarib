import 'package:mo3tarib/features/register/model/register_repsonse.dart';

sealed class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterError extends RegisterState {
  final String? message;

  RegisterError({this.message});
}

class RegisterSuccess extends RegisterState {
  final RegisterResponse response;

  RegisterSuccess({required this.response});
}
