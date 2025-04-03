import 'package:employee_hub/core/base/base/base_page.dart';
import 'package:employee_hub/core/base/base/bloc/api_base_bloc/api_base_bloc.dart';
import 'package:employee_hub/features/employees/presentation/bloc/employees_bloc.dart';
import 'package:employee_hub/features/employees/presentation/screen/employees_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesPage extends BasePage {
  EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends BasePageState<EmployeesPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeesBloc(
        apiBaseBloc: BlocProvider.of<ApiBaseBloc>(context),
      ),
      child: EmployeesScreen(),
    );
  }
}
