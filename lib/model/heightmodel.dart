import 'package:hive_flutter/adapters.dart';
part 'heightmodel.g.dart';

@HiveType(typeId: 4)
class HeightModelClass {
  @HiveField(0)
  DateTime date;
  @HiveField(1)
  DateTime time;
  @HiveField(2)
  double textController;
  @HiveField(3)
  String email;
  HeightModelClass(
      {required this.date,
      required this.time,
      required this.email,
      required this.textController});
}
