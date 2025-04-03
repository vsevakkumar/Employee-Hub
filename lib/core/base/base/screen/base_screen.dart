import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);
}

abstract class BaseScreenState<T extends BaseScreen> extends State<T>
    with WidgetsBindingObserver {
  late ScreenUtil screenUtil;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    setScreenUtil();
    super.didChangeDependencies();
  }

  @override
  Widget build(_) => body(context);

  Widget body(BuildContext context);

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void setScreenUtil() {
    screenUtil = ScreenUtil();
  }

  void removeFocus() => FocusScope.of(context).requestFocus(FocusNode());
}
