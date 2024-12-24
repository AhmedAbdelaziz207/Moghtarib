import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3tarib/core/network/services/webservice.dart';
import 'package:mo3tarib/features/department/logic/department_state.dart';

import '../../../core/network/model/department.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  DepartmentCubit() : super(DepartmentInitial());

  getDepartments() async {
    emit(DepartmentLoading());
    try {
      Response response = await Webservice().getDepartments();

      // Assuming response.data is a List<dynamic> containing department objects
      List<dynamic> responseData = response.data;

      // Parse the response into a list of Department objects
      List<Department> departments = responseData
          .map((departmentJson) => Department.fromJson(departmentJson))
          .toList();


      log("Department name: ${departments[0].name}");

      // Emit the loaded state with the list of departments
      emit(DepartmentLoaded(departments: departments));
    } catch (e) {
      log("Department error: $e");
      emit(DepartmentError());
    }
  }
}
