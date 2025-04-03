import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String getDisplayDateFormat() {
    return DateFormat("d MMM yyyy").format(this);
  }
  String getDisplayDateFormat2() {
    return DateFormat("d MMM, yyyy").format(this);
  }
}
