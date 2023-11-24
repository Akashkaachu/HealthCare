import 'package:hive_flutter/adapters.dart';
part 'pulsemodel.g.dart';

@HiveType(typeId: 3)
class PulseClassModel {
  @HiveField(0)
  DateTime date;
  @HiveField(1)
  DateTime time;
  @HiveField(2)
  int rateOfpulse;
  @HiveField(3)
  String email;
  PulseClassModel(
      {required this.date,
      required this.time,
      required this.rateOfpulse,
      required this.email});
}
