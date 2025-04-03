import 'package:employee_hub/core/base/base/bloc/api_base_bloc/api_base_bloc.dart';
import 'package:employee_hub/core/base/base/bloc/base_bloc.dart';
import 'package:employee_hub/features/employees/data/employee_model.dart';
import 'package:employee_hub/features/employees/presentation/bloc/employees_event.dart';
import 'package:employee_hub/features/employees/presentation/bloc/employees_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class EmployeesBloc extends BaseBloc<EmployeesEvent, EmployeesState> {
  EmployeesBloc({
    required ApiBaseBloc apiBaseBloc,
  }) : super(apiBaseBloc, EmployeeInitialState()) {
    on<FetchEmployeesEvent>(_fetchEmployees);
    on<DeleteEmployeesEvent>(_deleteEvent);
  }

  Future<void> _fetchEmployees(
      FetchEmployeesEvent event, Emitter<EmployeesState> emit) async {
    try {
      var box = Hive.box<Employee>('employees');
      List<Employee> allEmployees = box.values.toList();

      DateTime today = DateTime.now();

      List<Employee> currentEmployees = allEmployees
          .where((employee) => employee.endDate.isAfter(today))
          .toList();

      List<Employee> previousEmployees = allEmployees
          .where((employee) => employee.endDate.isBefore(today))
          .toList();

      emit(EmployeesLoadedState(
        currentEmployees: currentEmployees,
        previousEmployees: previousEmployees,
      ));
    } catch (e) {
      emit(EmployeesErrorState(
          message: "Failed to load employees: ${e.toString()}"));
    }
  }

  Future<void> _deleteEvent(
      DeleteEmployeesEvent event, Emitter<EmployeesState> emit) async {
    try {
      var box = Hive.box<Employee>('employees');
      if (box.containsKey(event.id)) {
        await box.delete(event.id);
        add(FetchEmployeesEvent());
        emit(EmployeeDeleteSuccessState());
      } else {
        emit(EmployeesErrorState(message: "Employee not found in database."));
      }
    } catch (e) {
      emit(EmployeesErrorState(
          message: "Failed to delete employee: ${e.toString()}"));
    }
  }
}
