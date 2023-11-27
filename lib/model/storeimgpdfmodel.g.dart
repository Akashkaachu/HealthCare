// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storeimgpdfmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoreImgPdfClassModelAdapter extends TypeAdapter<StoreImgPdfClassModel> {
  @override
  final int typeId = 7;

  @override
  StoreImgPdfClassModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreImgPdfClassModel(
      folderName: fields[0] as String,
      folderPath: fields[1] as String,
      email: fields[2] as String,
      type: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StoreImgPdfClassModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.folderName)
      ..writeByte(1)
      ..write(obj.folderPath)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreImgPdfClassModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
