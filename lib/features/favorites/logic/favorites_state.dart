part of 'favorites_cubit.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class IsFavoritesLoading extends FavoritesState {}
final class IsFavoritesDone extends FavoritesState {
  final bool state ;
  IsFavoritesDone({required this.state});
}

final class FavoritesLoaded extends FavoritesState {
  final List<ApartmentModel> apartments;
  FavoritesLoaded({required this.apartments});
}

final class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError({required this.message});
}

final class DeleteFavoriteSuccess extends FavoritesState {}
final class DeleteFavoriteLoading extends FavoritesState {}

final class AddedFavoriteSuccess extends FavoritesState {}