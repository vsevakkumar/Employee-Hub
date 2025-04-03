import 'package:employee_hub/core/base/base/bloc/api_base_bloc/api_base_bloc_state.dart';
import 'package:flutter/foundation.dart';

@immutable
class AddEditEmployeeState extends ApiBaseBlocState {}

class AddEditAddressStateInitialState extends AddEditEmployeeState {}

class SavedEmployeeSuccess extends AddEditEmployeeState {}

class EmployeeErrorState extends AddEditEmployeeState {
  final String message;

  EmployeeErrorState(this.message);
}
