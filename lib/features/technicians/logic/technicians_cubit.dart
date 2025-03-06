import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/di.dart';
import '../../../core/network/api_error_handler.dart';
import '../../../core/network/api_service.dart';
import '../model/technicians_model.dart';
part 'technicians_state.dart';

class TechniciansCubit extends Cubit<TechniciansState> {
  TechniciansCubit() : super(TechniciansInitial());

  void getTechnicians() async {
    emit(TechniciansLoading());
    try {
      List<TechnicalsModel> technicians =
          await getIt<ApiService>().getAllTechnicians();
      emit(TechniciansSuccess(technicians: technicians));
    } catch (e) {
      final message = ApiErrorHandler.handle(e).getErrorsMessage();

      emit(TechniciansError(message: message));
    }
  }
}
