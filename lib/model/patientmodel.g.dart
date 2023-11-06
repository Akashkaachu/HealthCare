// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PatientsDetailsAdapter extends TypeAdapter<PatientsDetails> {
  @override
  final int typeId = 0;

  @override
  PatientsDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PatientsDetails(
      name: fields[0] as String,
      email: fields[1] as String,
      password: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PatientsDetails obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientsDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}