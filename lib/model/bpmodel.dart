import 'package:hive_flutter/adapters.dart';
part 'bpmodel.g.dart';

@HiveType(typeId: 2)
class BloodPressureModel {
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final DateTime time;
  @HiveField(2)
  final int bloodmmcount;
  @HiveField(3)
  final int bloodHgCount;
  @HiveField(4)
  final String email;
  BloodPressureModel(
      {required this.date,
      required this.time,
      required this.bloodmmcount,
      required this.bloodHgCount,
      required this.email});
}
