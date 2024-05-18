import 'package:hive/hive.dart';

part 'employee.g.dart';

@HiveType(typeId: 0)
class Employee extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final DateTime joinDate;

  @HiveField(2)
  final bool isActive;

  Employee({required this.name, required this.joinDate, required this.isActive});
}
