import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/editprofile.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/model/storeimgpdfmodel.dart';
import 'package:healthcare/profilepge.dart';
import 'package:open_file/open_file.dart';

class DisplayPatientRecorder extends StatefulWidget {
  const DisplayPatientRecorder({super.key, required this.appText});
  final String appText;

  @override
  State<DisplayPatientRecorder> createState() => _DisplayPatientRecorderState();
}

File? images;

class _DisplayPatientRecorderState extends State<DisplayPatientRecorder> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appText),
        centerTitle: true,
        backgroundColor: const Color(0xff7a73e7),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Color(0xff7a73e7),
        spacing: 12,
        spaceBetweenChildren: 12,
        children: [
          SpeedDialChild(
              child: Icon(
                Icons.picture_as_pdf,
                color: Colors.red,
              ),
              label: "PDF",
              labelStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                uploadPdf(widget.appText, context);
              }),
          SpeedDialChild(
              child: const Icon(
                Icons.image,
                color: Color(0xff7a73e7),
              ),
              label: "Image",
              labelStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () async {
                final image = await pickImageFromGallery(context);
                setState(() {
                  images = image;
                });
                final gettedVal = StoreImgPdfClassModel(
                    pdfName: '',
                    folderName: widget.appText,
                    folderPath: images!.path,
                    email: email!,
                    type: 'image');
                await addImagePdfTypes(gettedVal, context);
              })
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: size.width,
        child: FutureBuilder<List<StoreImgPdfClassModel>>(
          future: getImagePdfTypeDtls(email!, widget.appText),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text("Error");
            } else {
              List<StoreImgPdfClassModel> imgPdgList = snapshot.data!;
              return Expanded(
                child: ListView.builder(
                  itemCount: imgPdgList.length,
                  itemBuilder: (context, index) {
                    if (imgPdgList[index].type == 'image') {
                      return Container(
                          width: size.width,
                          child:
                              Image.file(File(imgPdgList[index].folderPath)));
                    } else if (imgPdgList[index].type == 'pdf') {
                      return InkWell(
                        onTap: () async {
                          try {
                            await OpenFile.open(imgPdgList[index].folderPath);
                          } catch (e) {
                            // Handle errors or log them
                            print("Error opening file: $e");
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            color: Color(0xff7a73e7),
                            width: size.width,
                            height: 70,
                            child: Row(children: [
                              const Icon(
                                Icons.picture_as_pdf,
                                color: Colors.red,
                              ),
                              Text(imgPdgList[index].pdfName!)
                            ]),
                          ),
                        ),
                      );
                    }
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

void uploadPdf(String folderName, BuildContext context) async {
  final pickedPdfFleMnger = await pdfPickerFromFleMnger();
  if (pickedPdfFleMnger != null) {
    final model = StoreImgPdfClassModel(
        pdfName: pickedPdfFleMnger.fileName,
        folderName: folderName,
        folderPath: pickedPdfFleMnger.file.path,
        email: email!,
        type: 'pdf');
    await addImagePdfTypes(model, context);

    showSnackBarImage(context, "PDF successfully saved", Colors.green);
  }
}

//file picker function
Future<PickedFile?> pdfPickerFromFleMnger() async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
  if (result != null) {
    File pickedFile = File(result.files.single.path!);
    String fileName = result.files.single.name;
    return PickedFile(file: pickedFile, fileName: fileName);
  }
  try {} catch (e) {}
}

class PickedFile {
  final File file;
  final String fileName;
  PickedFile({required this.file, required this.fileName});
}
