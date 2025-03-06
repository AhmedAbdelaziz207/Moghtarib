part of 'apartment_cubit.dart';

@immutable
sealed class ApartmentState {}

final class ApartmentInitial extends ApartmentState {}

final class ApartmentLoading extends ApartmentState {}

final class GetApartmentSuccess extends ApartmentState {
  final List<ApartmentModel>? apartments;

  GetApartmentSuccess({this.apartments});
}

final class ApartmentError extends ApartmentState {
  final String? message;

  ApartmentError({this.message});
}

final class AddApartmentSuccess extends ApartmentState {}

final class AddApartmentCommentSuccess extends ApartmentState {}

final class GetApartmentCommentSuccess extends ApartmentState {
  final List<ApartmentComment>? comments;

  GetApartmentCommentSuccess({this.comments});
}
