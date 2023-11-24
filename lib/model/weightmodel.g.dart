// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weightmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeightClassModelAdapter extends TypeAdapter<WeightClassModel> {
  @override
  final int typeId = 5;

  @override
  WeightClassModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeightClassModel(
      date: fields[0] as DateTime,
      time: fields[1] as DateTime,
      controller: fields[2] as double,
      email: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WeightClassModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.controller)
      ..writeByte(3)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeightClassModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
