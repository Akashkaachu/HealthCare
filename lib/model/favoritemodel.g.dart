// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favoritemodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavorateClassModelAdapter extends TypeAdapter<FavorateClassModel> {
  @override
  final int typeId = 8;

  @override
  FavorateClassModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavorateClassModel(
      email: fields[0] as String,
      type: fields[1] as String,
      path: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavorateClassModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavorateClassModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
