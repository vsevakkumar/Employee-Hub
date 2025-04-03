import 'dart:async';

import 'package:employee_hub/core/base/base/screen/base_screen.dart';
import 'package:employee_hub/core/colors/app_colors.dart';
import 'package:employee_hub/core/extensions/image_extensions.dart';
import 'package:employee_hub/core/extensions/text_styles_extension.dart';
import 'package:employee_hub/core/image_constants.dart';
import 'package:employee_hub/core/string_constants.dart';
import 'package:employee_hub/core/utils/common_methods.dart';
import 'package:employee_hub/core/utils/date_utils.dart';
import 'package:employee_hub/core/widgets/calendar_dialog.dart';
import 'package:employee_hub/core/widgets/common_app_bar.dart';
import 'package:employee_hub/core/widgets/custom_button.dart';
import 'package:employee_hub/core/widgets/custom_text_field.dart';
import 'package:employee_hub/features/add_edit_employee/data/role_model.dart';
import 'package:employee_hub/features/add_edit_employee/presentation/bloc/add_edit_employee_bloc.dart';
import 'package:employee_hub/features/add_edit_employee/presentation/bloc/add_edit_employee_event.dart';
import 'package:employee_hub/features/add_edit_employee/presentation/bloc/add_edit_employee_state.dart';
import 'package:employee_hub/features/employees/data/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditEmployeeScreen extends BaseScreen {
  final Employee? model;

  const AddEditEmployeeScreen({super.key, this.model});

  @override
  State<AddEditEmployeeScreen> createState() => _AddEditEmployeeScreenState();
}

class _AddEditEmployeeScreenState
    extends BaseScreenState<AddEditEmployeeScreen> {
  TextEditingController employeeNameController = TextEditingController();
  TextEditingController selectRoleController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  RoleModel? selectedRole;
  StreamController<bool> refreshStreamController =
      StreamController<bool>.broadcast();
  DateTime? startDate;
  DateTime? endDate;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isEdit = false;
  Employee? model;

  @override
  void initState() {
    model = widget.model;
    if (model != null) {
      isEdit = true;
      loadInitialData();
    }
    super.initState();
  }

  void loadInitialData() {
    employeeNameController.text = model?.name ?? "";
    selectRoleController.text = model?.role ?? "";
    selectedRole = roles.firstWhere((item) => item.name == model?.role);
    startDate = model?.startDate;
    endDate = model?.endDate;
    fromDateController.text = model?.startDate.getDisplayDateFormat() ?? "";
    toDateController.text = model?.endDate.getDisplayDateFormat() ?? "";
    refreshStreamController.add(true);
  }

  @override
  Widget body(BuildContext context) {
    return BlocConsumer<AddEditEmployeeBloc, AddEditEmployeeState>(
      listener: (_, state) async {
        if (state is SavedEmployeeSuccess) {
          showMessage(LABEL_EMPLOYEE_SAVED);
          await Future.delayed(Duration(seconds: 1));
          goBack(context);
        } else if (state is EmployeeErrorState) {
          showMessage(state.message);
        }
      },
      builder: (_, state) {
        return StreamBuilder<bool>(
            stream: refreshStreamController.stream,
            builder: (context, snapshot) {
              return Scaffold(
                appBar: CommonAppBar(
                  title: isEdit
                      ? LABEL_EDIT_EMPLOYEE_DETAILS
                      : LABEL_ADD_EDIT_EMPLOYEE_DETAILS,
                  actions: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.delete,
                        color: AppColors.primaryColor,
                      ),
                    )
                  ],
                ),
                backgroundColor: AppColors.whiteColor,
                bottomNavigationBar: bottomNavigationWidget(),
                body: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenUtil.setWidth(16),
                    vertical: screenUtil.setHeight(24),
                  ),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: employeeNameController,
                          hintText: LABEL_EMPLOYEE_NAME,
                          prefixIcon: IC_USER.getImage(
                              screenUtil: screenUtil, height: 24, width: 24),
                          onChanged: (text) {
                            checkValidation();
                          },
                          validator: (text) {
                            if (employeeNameController.text.isEmpty) {
                              return EMPTY_EMPLOYEE_NAME;
                            } else if (employeeNameController.text.length < 3) {
                              return INVALID_EMPLOYEE_NAME;
                            } else {
                              return null;
                            }
                          },
                        ),
                        heightBox(),
                        CustomTextField(
                          readOnly: true,
                          controller: selectRoleController,
                          onChanged: (text) {
                            checkValidation();
                          },
                          validator: (text) {
                            if (selectRoleController.text.isEmpty) {
                              return ERROR_SELECT_ROLE;
                            } else {
                              return null;
                            }
                          },
                          onTap: () {
                            showCommonBottomSheet(
                              context: context,
                              isScrollable: true,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: screenUtil.setHeight(16),
                                  horizontal: screenUtil.setWidth(16),
                                ),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (_, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        selectedRole = roles[index];
                                        selectRoleController.text =
                                            selectedRole?.name ?? "";
                                        refreshStreamController.add(true);
                                        checkValidation();
                                        goBack(context);
                                      },
                                      child: roles[index].name.getText16W400(
                                            textAlign: TextAlign.center,
                                            screenUtil: screenUtil,
                                          ),
                                    );
                                  },
                                  itemCount: roles.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: screenUtil.setHeight(12),
                                      ),
                                      child: Divider(
                                        color: AppColors.greyBackgroundColor,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              screenUtil: screenUtil,
                            );
                          },
                          hintText: LABEL_SELECT_ROLE,
                          prefixIcon: IC_ROLE.getImage(
                              screenUtil: screenUtil, height: 24, width: 24),
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.primaryColor,
                            size: 26,
                          ),
                        ),
                        heightBox(),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                readOnly: true,
                                controller: fromDateController,
                                onChanged: (text) {
                                  checkValidation();
                                },
                                validator: (text) {
                                  if (fromDateController.text.isEmpty) {
                                    return ERROR_SELECT_START_DATE;
                                  } else {
                                    return null;
                                  }
                                },
                                hintText: LABEL_NO_DATE,
                                prefixIcon: IC_EVENT.getImage(
                                  screenUtil: screenUtil,
                                  height: 24,
                                  width: 24,
                                ),
                                onTap: () {
                                  showAppDialog(
                                    context: context,
                                    screenUtil: screenUtil,
                                    child: CalendarWidget(
                                      selectedDate: startDate,
                                      onDateSelected: (date) {
                                        startDate = date;
                                        fromDateController.text =
                                            startDate!.getDisplayDateFormat();
                                        checkValidation();
                                        refreshStreamController.add(true);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: screenUtil.setWidth(12),
                            ),
                            Icon(
                              Icons.arrow_right_alt_sharp,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(
                              width: screenUtil.setWidth(12),
                            ),
                            Expanded(
                              child: CustomTextField(
                                readOnly: true,
                                controller: toDateController,
                                hintText: LABEL_NO_DATE,
                                onChanged: (text) {
                                  checkValidation();
                                },
                                validator: (text) {
                                  if (toDateController.text.isEmpty) {
                                    return ERROR_SELECT_END_DATE;
                                  } else {
                                    return null;
                                  }
                                },
                                onTap: () {
                                  showAppDialog(
                                    context: context,
                                    screenUtil: screenUtil,
                                    child: CalendarWidget(
                                      selectedDate: endDate,
                                      initialDate: startDate,
                                      onDateSelected: (date) {
                                        endDate = date;
                                        toDateController.text =
                                            endDate!.getDisplayDateFormat();
                                        checkValidation();
                                        refreshStreamController.add(true);
                                      },
                                    ),
                                  );
                                },
                                prefixIcon: IC_EVENT.getImage(
                                  screenUtil: screenUtil,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: message.getWhiteText16W400(screenUtil: screenUtil),
      ),
    );
  }

  Widget bottomNavigationWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Divider(
          color: AppColors.greyBackgroundColor,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenUtil.setWidth(16),
            vertical: screenUtil.setHeight(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                text: LABEL_CANCEL,
                width: 80,
                textColor: AppColors.primaryColor,
                backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                onPressed: () {
                  goBack(context);
                },
              ),
              SizedBox(
                width: screenUtil.setWidth(16),
              ),
              CustomButton(
                text: LABEl_SAVE,
                width: 80,
                backgroundColor: AppColors.primaryColor,
                onPressed: () {
                  isCheckValidation = true;
                  var isValid = checkValidation();
                  if (isValid) {
                    if (isEdit) {
                      BlocProvider.of<AddEditEmployeeBloc>(context).add(
                        SaveEmployeeEvent(
                          Employee(
                            id: model!.id,
                            name: employeeNameController.text,
                            role: selectedRole!.name,
                            startDate: startDate!,
                            endDate: endDate!,
                          ),
                          true,
                        ),
                      );
                    } else {
                      BlocProvider.of<AddEditEmployeeBloc>(context).add(
                        SaveEmployeeEvent(
                          Employee(
                            id: DateTime.now()
                                .microsecondsSinceEpoch
                                .toString(),
                            name: employeeNameController.text,
                            role: selectedRole!.name,
                            startDate: startDate!,
                            endDate: endDate!,
                          ),
                          false,
                        ),
                      );
                    }
                  }
                },
              )
            ],
          ),
        )
      ],
    );
  }

  Widget heightBox() {
    return SizedBox(
      height: screenUtil.setHeight(23),
    );
  }

  bool isCheckValidation = false;

  bool checkValidation() {
    if (isCheckValidation) {
      return formkey.currentState?.validate() ?? false;
    }
    return false;
  }
}
