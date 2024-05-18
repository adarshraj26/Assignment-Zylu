import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './components/employee.dart';
import 'components/employee_list.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeAdapter());
  await Hive.openBox<Employee>('employees');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee App',
      home: EmployeeListScreen(),
    );
  }
}
