part of 'technicians_cubit.dart';

@immutable
sealed class TechniciansState {}

final class TechniciansInitial extends TechniciansState {}

final class TechniciansLoading extends TechniciansState {}

final class TechniciansSuccess extends TechniciansState {
  final List<TechnicalsModel>? technicians;

  TechniciansSuccess({this.technicians});
}

final class TechniciansError extends TechniciansState {
  final String? message;

  TechniciansError({this.message});
}