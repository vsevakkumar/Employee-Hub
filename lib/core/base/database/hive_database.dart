import 'package:employee_hub/features/employees/data/employee_model.dart';
import 'package:hive/hive.dart';

class HiveDatabase {
  static const String _boxName = "employees";

  static Future<void> init() async {
    Hive.registerAdapter(EmployeeAdapter());
    await Hive.openBox<Employee>(_boxName);
  }

  static Future<void> addEmployee(Employee employee) async {
    var box = Hive.box<Employee>(_boxName);
    await box.put(employee.id, employee);
  }

  static List<Employee> getEmployees() {
    var box = Hive.box<Employee>(_boxName);
    return box.values.toList();
  }
}
