import 'package:hive_flutter/adapters.dart';
part 'weightmodel.g.dart';

@HiveType(typeId: 5)
class WeightClassModel {
  @HiveField(0)
  DateTime date;
  @HiveField(1)
  DateTime time;
  @HiveField(2)
  double controller;
  @HiveField(3)
  String email;
  WeightClassModel(
      {required this.date,
      required this.time,
      required this.controller,
      required this.email});
}
