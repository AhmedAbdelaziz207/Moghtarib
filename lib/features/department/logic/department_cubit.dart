import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3tarib/core/di/di.dart';
import 'package:mo3tarib/core/network/api_service.dart';
import 'package:mo3tarib/features/department/logic/department_state.dart';
import 'package:mo3tarib/features/department/model/department.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  DepartmentCubit() : super(DepartmentInitial());

  void getDepartments() async {
    emit(DepartmentLoading());
    try {
      List<Department> departments = await getIt<ApiService>().getDepartments();
      emit(DepartmentLoaded(departments: departments));
    } catch (e) {
      emit(DepartmentError());
    }
  }
}
