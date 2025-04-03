import 'package:employee_hub/core/base/base/bloc/api_base_bloc/api_base_bloc_state.dart';
import 'package:employee_hub/features/employees/data/employee_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class EmployeesState extends ApiBaseBlocState {}

class EmployeeInitialState extends EmployeesState {}


class EmployeesLoadedState extends EmployeesState {
  final List<Employee> currentEmployees;
  final List<Employee> previousEmployees;

  EmployeesLoadedState({
    required this.currentEmployees,
    required this.previousEmployees,
  });
}


class EmployeesErrorState extends EmployeesState {
  final String message;

  EmployeesErrorState({required this.message});
}

class EmployeeDeleteSuccessState extends EmployeesState {


}
