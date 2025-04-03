import 'package:employee_hub/core/base/base/base_page.dart';
import 'package:employee_hub/core/base/base/bloc/api_base_bloc/api_base_bloc.dart';
import 'package:employee_hub/features/add_edit_employee/presentation/bloc/add_edit_employee_bloc.dart';
import 'package:employee_hub/features/add_edit_employee/presentation/screen/add_edit_employee_screen.dart';
import 'package:employee_hub/features/employees/data/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditEmployeePage extends BasePage {
  final Employee? model;

  AddEditEmployeePage({super.key, this.model});

  @override
  State<AddEditEmployeePage> createState() => _AddEditEmployeePageState();
}

class _AddEditEmployeePageState extends BasePageState<AddEditEmployeePage> {
  @override
  Widget getChildBlocWidget(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditEmployeeBloc(
        apiBaseBloc: BlocProvider.of<ApiBaseBloc>(context),
      ),
      child: AddEditEmployeeScreen(
        model: widget.model,
      ),
    );
  }
}
