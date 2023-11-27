import 'package:hive_flutter/adapters.dart';
part 'pdfpatientrecorder.g.dart';

@HiveType(typeId: 6)
class PdfPatientClassModel {
  @HiveField(0)
  final String Foldername;
  @HiveField(1)
  final String email;

  PdfPatientClassModel(this.Foldername, this.email);
}
