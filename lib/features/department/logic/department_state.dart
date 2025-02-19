import '../model/department.dart';

sealed class DepartmentState {}

class DepartmentInitial extends DepartmentState {}

class DepartmentLoading extends DepartmentState {}

class DepartmentLoaded extends DepartmentState {
  final List<Department>? departments;

  DepartmentLoaded({this.departments});
}

class DepartmentError extends DepartmentState {}