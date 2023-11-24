// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heightmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HeightModelClassAdapter extends TypeAdapter<HeightModelClass> {
  @override
  final int typeId = 4;

  @override
  HeightModelClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HeightModelClass(
      date: fields[0] as DateTime,
      time: fields[1] as DateTime,
      email: fields[3] as String,
      textController: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, HeightModelClass obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.textController)
      ..writeByte(3)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeightModelClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
