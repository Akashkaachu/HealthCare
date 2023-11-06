import 'package:hive/hive.dart';
part 'patientmodel.g.dart';

@HiveType(typeId: 0) //for creating unique id for class
class PatientsDetails {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;
  PatientsDetails(
      {required this.name, required this.email, required this.password});
}
