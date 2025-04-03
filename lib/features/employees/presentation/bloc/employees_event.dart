import 'package:flutter/foundation.dart';

@immutable
abstract class EmployeesEvent {}

class FetchEmployeesEvent extends EmployeesEvent {}

class DeleteEmployeesEvent extends EmployeesEvent {
  final String id;

  DeleteEmployeesEvent({required this.id});
}
