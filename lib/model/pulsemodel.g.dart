// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pulsemodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PulseClassModelAdapter extends TypeAdapter<PulseClassModel> {
  @override
  final int typeId = 3;

  @override
  PulseClassModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PulseClassModel(
      date: fields[0] as DateTime,
      time: fields[1] as DateTime,
      rateOfpulse: fields[2] as int,
      email: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PulseClassModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.rateOfpulse)
      ..writeByte(3)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PulseClassModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
