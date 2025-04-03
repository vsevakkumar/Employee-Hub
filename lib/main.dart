import 'dart:async';

import 'package:employee_hub/core/app_constants.dart';
import 'package:employee_hub/core/base/database/hive_database.dart';
import 'package:employee_hub/core/colors/app_colors.dart';
import 'package:employee_hub/core/string_constants.dart';
import 'package:employee_hub/features/employees/presentation/employees_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: AppColors.darkPrimaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
      );
      await Hive.initFlutter();
      await HiveDatabase.init();
      runApp(
        MyApp(),
      );
    },
    (object, stackTrace) {
      try {} catch (error) {
        print(error);
      }
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: LABEL_APP_NAME,
          themeMode: ThemeMode.light,
          theme: ThemeData(
            primaryColor: AppColors.primaryColor,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            fontFamily: ROBOTO_FONT_FONT_FAMILY,
            appBarTheme: Theme.of(context).appBarTheme.copyWith(
                  color: AppColors.primaryColor,
                ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: AppColors.darkPrimaryColor,
              brightness: Theme.of(context).brightness,
            ),
          ),
          home: child,
        );
      },
      child: EmployeesPage(),
    );
  }
}
