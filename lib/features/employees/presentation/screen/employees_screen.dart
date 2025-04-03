import 'package:employee_hub/core/base/base/screen/base_screen.dart';
import 'package:employee_hub/core/colors/app_colors.dart';
import 'package:employee_hub/core/extensions/image_extensions.dart';
import 'package:employee_hub/core/extensions/text_styles_extension.dart';
import 'package:employee_hub/core/image_constants.dart';
import 'package:employee_hub/core/string_constants.dart';
import 'package:employee_hub/core/utils/common_methods.dart';
import 'package:employee_hub/core/utils/date_utils.dart';
import 'package:employee_hub/core/widgets/common_app_bar.dart';
import 'package:employee_hub/features/add_edit_employee/presentation/add_edit_employee_page.dart';
import 'package:employee_hub/features/employees/data/employee_model.dart';
import 'package:employee_hub/features/employees/presentation/bloc/employees_bloc.dart';
import 'package:employee_hub/features/employees/presentation/bloc/employees_event.dart';
import 'package:employee_hub/features/employees/presentation/bloc/employees_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeesScreen extends BaseScreen {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends BaseScreenState<EmployeesScreen> {
  @override
  void initState() {
    getEmployeeListEvent();
    super.initState();
  }

  void getEmployeeListEvent() {
    BlocProvider.of<EmployeesBloc>(context).add(FetchEmployeesEvent());
  }

  List<Employee> currentEmployees = [];
  List<Employee> previousEmployees = [];

  @override
  Widget body(BuildContext context) {
    return BlocConsumer<EmployeesBloc, EmployeesState>(
      listener: (_, state) {
        if (state is EmployeeDeleteSuccessState) {
          showMessage(LABEL_EMPLOYEE_DATA_HAS_BEEN_REMOVED);
        }
      },
      builder: (_, state) {
        if (state is EmployeesLoadedState) {
          currentEmployees = state.currentEmployees;
          previousEmployees = state.previousEmployees;
        }
        return Scaffold(
          appBar: CommonAppBar(
            title: LABEL_EMPLOYEE_LIST,
          ),
          backgroundColor: AppColors.greyBackgroundColor,
          body: (currentEmployees.isEmpty && previousEmployees.isEmpty)
              ? noEmployeesWidget()
              : employeeWidget(),
          floatingActionButton: fabButtonWidget(),
        );
      },
    );
  }

  Widget employeeWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (currentEmployees.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 18.h,
                horizontal: 16.w,
              ),
              child: LABEL_CURRENT_EMPLOYEES.getPrimaryText16W500(
                  screenUtil: screenUtil),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: currentEmployees.length,
              itemBuilder: (context, index) {
                return listItem(
                    item: currentEmployees[index], isPrevious: false);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1.h,
                  color: AppColors.dividerColor,
                );
              },
            ),
          ],
          if (previousEmployees.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 18.h,
                horizontal: 16.w,
              ),
              child: LABEL_PREVIOUS_EMPLOYEES.getPrimaryText16W500(
                  screenUtil: screenUtil),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: previousEmployees.length,
              itemBuilder: (context, index) {
                return listItem(
                    item: previousEmployees[index], isPrevious: true);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1.h,
                  color: AppColors.dividerColor,
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget listItem({required Employee item, required bool isPrevious}) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16.w),
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return true;
      },
      onDismissed: (direction) {
        deleteEmployee(item);
      },
      child: GestureDetector(
        onTap: () async {
          await navigatePush(
            context,
            AddEditEmployeePage(
              model: item,
            ),
          );
          getEmployeeListEvent();
        },
        child: Container(
          color: AppColors.whiteColor,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            vertical: screenUtil.setHeight(16),
            horizontal: screenUtil.setWidth(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item.name.getText16W400(screenUtil: screenUtil),
              sizedBox06(),
              item.role.getDesc14W400(screenUtil: screenUtil),
              sizedBox06(),
              if (isPrevious) ...[
                ("${item.startDate.getDisplayDateFormat2()} - ${item.endDate.getDisplayDateFormat2()}")
                    .getDesc14W400(screenUtil: screenUtil),
              ] else ...[
                Row(
                  children: [
                    LABEL_FORM.getDesc14W400(screenUtil: screenUtil),
                    item.startDate
                        .getDisplayDateFormat2()
                        .getDesc14W400(screenUtil: screenUtil),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  SizedBox sizedBox06() {
    return SizedBox(
      height: screenUtil.setHeight(8),
    );
  }

  Widget fabButtonWidget() {
    return GestureDetector(
      onTap: () async {
        await navigatePush(
          context,
          AddEditEmployeePage(),
        );
        getEmployeeListEvent();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenUtil.setHeight(16),
          vertical: screenUtil.setWidth(16),
        ),
        child: IC_PLUS_ICON.getImage(
          screenUtil: screenUtil,
          height: 18,
          width: 18,
        ),
      ),
    );
  }

  Widget noEmployeesWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: IC_NO_EMPLOYEES.getImage(screenUtil: screenUtil)),
        SizedBox(
          height: 5.h,
        ),
        LABEL_NO_EMPLOYEES_RECORDS.getText18W500Text(
          screenUtil: screenUtil,
        )
      ],
    );
  }

  void deleteEmployee(Employee item) {
    BlocProvider.of<EmployeesBloc>(context).add(
      DeleteEmployeesEvent(
        id: item.id,
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: message.getWhiteText16W400(screenUtil: screenUtil),
      ),
    );
  }
}
