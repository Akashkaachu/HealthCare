import 'package:hive_flutter/adapters.dart';
part 'storeimgpdfmodel.g.dart';

@HiveType(typeId: 7)
class StoreImgPdfClassModel {
  @HiveField(0)
  String folderName;
  @HiveField(1)
  String folderPath;
  @HiveField(2)
  String email;
  @HiveField(4)
  String type;
  @HiveField(5)
  String? pdfName;
  StoreImgPdfClassModel(
      {required this.folderName,
      required this.folderPath,
      required this.email,
      required this.type,
      this.pdfName});
}
