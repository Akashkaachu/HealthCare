import 'package:hive_flutter/adapters.dart';
part 'favoritemodel.g.dart';

@HiveType(typeId: 8)
class FavorateClassModel {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String type;
  @HiveField(2)
  final String path;

  FavorateClassModel({
    required this.email,
    required this.type,
    required this.path,
  });
}
