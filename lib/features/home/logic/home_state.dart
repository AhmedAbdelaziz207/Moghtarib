part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetTechnicals extends HomeState {
  final List<UserModel> techs;

  GetTechnicals({required this.techs});
}

final class GetTechnicalsLoading extends HomeState {}

final class GetTechnicalsError extends HomeState {
  final String message;

  GetTechnicalsError({required this.message});
}

final class NavigateToTechnicalsPage extends HomeState {}

final class NavigateToApartmentPage extends HomeState {}
