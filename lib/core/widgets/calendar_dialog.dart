import 'package:employee_hub/core/base/base/screen/base_screen.dart';
import 'package:employee_hub/core/colors/app_colors.dart';
import 'package:employee_hub/core/string_constants.dart';
import 'package:employee_hub/core/utils/common_methods.dart';
import 'package:employee_hub/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

enum QuickSelectOption { today, nextMonday, nextTuesday, afterAWeek }

class CalendarWidget extends BaseScreen {
  final DateTime? selectedDate;
  final DateTime? initialDate;
  final Function(DateTime) onDateSelected;

  const CalendarWidget(
      {required this.selectedDate,
      required this.onDateSelected,
      this.initialDate});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends BaseScreenState<CalendarWidget> {
  DateTime? _tempSelectedDate;
  QuickSelectOption? _selectedOption;

  @override
  void initState() {
    super.initState();
    _tempSelectedDate = widget.selectedDate;
  }

  void _updateDate(DateTime date, QuickSelectOption? option) {
    setState(() {
      _tempSelectedDate = date;
      _selectedOption = option;
    });
  }

  void _handleQuickSelect(QuickSelectOption option) {
    DateTime newDate;
    switch (option) {
      case QuickSelectOption.today:
        newDate = DateTime.now();
        break;
      case QuickSelectOption.nextMonday:
        newDate = _nextWeekday(1);
        break;
      case QuickSelectOption.nextTuesday:
        newDate = _nextWeekday(2);
        break;
      case QuickSelectOption.afterAWeek:
        newDate = DateTime.now().add(Duration(days: 7));
        break;
    }
    _updateDate(newDate, option);
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuickSelectButton(LABEL_TODAY, QuickSelectOption.today),
              SizedBox(width: screenUtil.setWidth(16)),
              _buildQuickSelectButton(
                  LABEL_NEXT_MONDAY, QuickSelectOption.nextMonday),
            ],
          ),
          SizedBox(height: screenUtil.setHeight(16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuickSelectButton(
                  LABEL_NEXT_TUESDAY, QuickSelectOption.nextTuesday),
              SizedBox(width: screenUtil.setWidth(16)),
              _buildQuickSelectButton(
                  LABEL_AFTER_A_WEEK, QuickSelectOption.afterAWeek),
            ],
          ),
          SizedBox(height: 10),
          CalendarDatePicker(
            initialDate: _tempSelectedDate,
            firstDate: widget.initialDate ?? DateTime(2000),
            lastDate: DateTime(2100),
            onDateChanged: (date) {
              _updateDate(date, _selectedOption);
            },
          ),
          SizedBox(height: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Divider(color: AppColors.greyBackgroundColor),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: screenUtil.setHeight(12)),
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
                    SizedBox(width: screenUtil.setWidth(16)),
                    CustomButton(
                      text: LABEl_SAVE,
                      width: 80,
                      backgroundColor: AppColors.primaryColor,
                      onPressed: () {
                        if (_tempSelectedDate != null) {
                          goBack(context);
                          widget.onDateSelected(_tempSelectedDate!);
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildQuickSelectButton(String label, QuickSelectOption option) {
    return Expanded(
      child: CustomButton(
        text: label,
        textColor: _selectedOption == option
            ? AppColors.whiteColor
            : AppColors.primaryColor,
        backgroundColor: _selectedOption == option
            ? AppColors.primaryColor
            : AppColors.primaryColor.withOpacity(0.1),
        onPressed: () => _handleQuickSelect(option),
      ),
    );
  }

  DateTime _nextWeekday(int weekday) {
    DateTime now = DateTime.now();
    int daysUntilNext = (weekday - now.weekday + 7) % 7;
    return now.add(Duration(days: daysUntilNext == 0 ? 7 : daysUntilNext));
  }
}
