import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'employee.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late Box<Employee> employeeBox;

  @override
void initState() {
  super.initState();
  employeeBox = Hive.box<Employee>('employees');
  if (employeeBox.isEmpty) {
    employeeBox.addAll([
      Employee(name: 'John', joinDate: DateTime(2015, 1, 1), isActive: true),
      Employee(name: 'Bob', joinDate: DateTime(2018, 1, 1), isActive: true),
      Employee(name: 'Charlie', joinDate: DateTime(2020, 1, 1), isActive: false),
    ]);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employees')),
      body: ValueListenableBuilder(
        valueListenable: employeeBox.listenable(),
        builder: (context, Box<Employee> box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text('No employees found.'));
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              Employee employee = box.getAt(index)!;
              bool isFlagged = employee.isActive &&
                  DateTime.now().difference(employee.joinDate).inDays > 1825;
              return ListTile(
                title: Text(employee.name),
                subtitle: Text(
                  'Joined: ${employee.joinDate.toLocal()}',
                  style: TextStyle(
                    color: isFlagged ? Colors.green : Colors.black,
                  ),
                ),
                trailing: Icon(
                  Icons.circle,
                  color: isFlagged ? Colors.green : Colors.red,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
