import 'package:employee_hub/features/employees/data/employee_model.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AddEditEmployeeEvent {}

class SaveEmployeeEvent extends AddEditEmployeeEvent {
  final Employee employee;
  final bool isEdit;

  SaveEmployeeEvent(this.employee, this.isEdit);
}
