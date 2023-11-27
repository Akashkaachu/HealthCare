// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdfpatientrecorder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PdfPatientClassModelAdapter extends TypeAdapter<PdfPatientClassModel> {
  @override
  final int typeId = 6;

  @override
  PdfPatientClassModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PdfPatientClassModel(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PdfPatientClassModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.Foldername)
      ..writeByte(1)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PdfPatientClassModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
