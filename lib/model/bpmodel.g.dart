// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bpmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodPressureModelAdapter extends TypeAdapter<BloodPressureModel> {
  @override
  final int typeId = 2;

  @override
  BloodPressureModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodPressureModel(
      date: fields[0] as DateTime,
      time: fields[1] as DateTime,
      bloodmmcount: fields[2] as int,
      bloodHgCount: fields[3] as int,
      email: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BloodPressureModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.bloodmmcount)
      ..writeByte(3)
      ..write(obj.bloodHgCount)
      ..writeByte(4)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodPressureModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
