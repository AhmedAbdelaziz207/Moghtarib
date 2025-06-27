
import 'package:flutter/material.dart';

import '../../register/model/user_model.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}
final class ProfileSuccess extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final UserModel user;

  ProfileLoaded({required this.user});
}

final class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});
}
