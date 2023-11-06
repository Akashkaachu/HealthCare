import 'package:hive/hive.dart';
part 'medicalmodel.g.dart';

@HiveType(typeId: 1)
class MedicalRemainder {
  @HiveField(0)
  final String medicineName;
  @HiveField(1)
  final String? medicineImage;
  @HiveField(2)
  final String? medicineType;
  @HiveField(3)
  final List<String> days;
  @HiveField(4)
  final bool morningDose;
  @HiveField(5)
  final bool afternoonDose;
  @HiveField(6)
  final bool eveningDose;
  @HiveField(7)
  final String email;
  @HiveField(8)
  bool alarm;
  MedicalRemainder(
      {required this.alarm,
      required this.email,
      required this.medicineName,
      required this.medicineImage,
      required this.medicineType,
      required this.days,
      required this.morningDose,
      required this.afternoonDose,
      required this.eveningDose});
}
