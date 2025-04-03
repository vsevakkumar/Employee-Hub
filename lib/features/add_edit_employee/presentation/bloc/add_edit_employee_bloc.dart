import 'package:employee_hub/core/base/base/bloc/api_base_bloc/api_base_bloc.dart';
import 'package:employee_hub/core/base/base/bloc/base_bloc.dart';
import 'package:employee_hub/core/base/database/hive_database.dart';
import 'package:employee_hub/features/add_edit_employee/presentation/bloc/add_edit_employee_event.dart';
import 'package:employee_hub/features/add_edit_employee/presentation/bloc/add_edit_employee_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditEmployeeBloc
    extends BaseBloc<AddEditEmployeeEvent, AddEditEmployeeState> {
  AddEditEmployeeBloc({
    required ApiBaseBloc apiBaseBloc,
  }) : super(apiBaseBloc, AddEditAddressStateInitialState()) {
    on<SaveEmployeeEvent>(_saveEmployee);
  }

  Future<void> _saveEmployee(
      SaveEmployeeEvent event, Emitter<AddEditEmployeeState> emit) async {
    try {
      await HiveDatabase.addEmployee(event.employee);
      emit(SavedEmployeeSuccess());
    } catch (e) {
      emit(EmployeeErrorState("Failed to save employee: ${e.toString()}"));
    }
  }
}
