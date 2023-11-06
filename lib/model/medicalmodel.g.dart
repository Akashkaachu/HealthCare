// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicalmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicalRemainderAdapter extends TypeAdapter<MedicalRemainder> {
  @override
  final int typeId = 1;

  @override
  MedicalRemainder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicalRemainder(
      alarm: fields[8] as bool,
      email: fields[7] as String,
      medicineName: fields[0] as String,
      medicineImage: fields[1] as String?,
      medicineType: fields[2] as String?,
      days: (fields[3] as List).cast<String>(),
      morningDose: fields[4] as bool,
      afternoonDose: fields[5] as bool,
      eveningDose: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MedicalRemainder obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.medicineName)
      ..writeByte(1)
      ..write(obj.medicineImage)
      ..writeByte(2)
      ..write(obj.medicineType)
      ..writeByte(3)
      ..write(obj.days)
      ..writeByte(4)
      ..write(obj.morningDose)
      ..writeByte(5)
      ..write(obj.afternoonDose)
      ..writeByte(6)
      ..write(obj.eveningDose)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.alarm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicalRemainderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
