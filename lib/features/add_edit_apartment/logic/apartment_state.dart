part of 'apartment_cubit.dart';

@immutable
sealed class ApartmentState {}

final class ApartmentInitial extends ApartmentState {}

final class ApartmentLoading extends ApartmentState {}

final class ApartmentCommentLoading extends ApartmentState {}

final class ApartmentCommentLoaded extends ApartmentState {
  final List<CommentModel> comments;

  ApartmentCommentLoaded({required this.comments});
}

final class ApartmentCommentFailed extends ApartmentState {
  final String message;

  ApartmentCommentFailed({required this.message});
}

final class ApartmentAddedToFavorites extends ApartmentState {}

final class ApartmentSuccess extends ApartmentState {
  final List<ApartmentModel> apartments;

  ApartmentSuccess({required this.apartments});
}

final class ApartmentError extends ApartmentState {
  final String message;

  ApartmentError({required this.message});
}

final class AddApartmentSuccess extends ApartmentState {}

final class DeleteApartmentFailed extends ApartmentState {
  final String message;

  DeleteApartmentFailed({required this.message});
}

final class AddApartmentLoading extends ApartmentState {}

final class AddApartmentFailed extends ApartmentState {
  final String message;

  AddApartmentFailed({required this.message});
}
final class GetRatingSuccess extends ApartmentState {
  final int ratings;

  GetRatingSuccess({required this.ratings});
}