// ignore_for_file: avoid_print, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/model/favoritemodel.dart';
import 'package:healthcare/model/pdfpatientrecorder.dart';
import 'package:healthcare/sixcontainer/newpatientrec.dart';
import 'package:healthcare/profilepge.dart';
import 'package:healthcare/sixcontainer/addremainder.dart';
import 'package:lottie/lottie.dart';

class PatientRecPge extends StatefulWidget {
  const PatientRecPge({super.key});

  @override
  State<PatientRecPge> createState() => _PatientRecPgeState();
}

TextEditingController ptEdiditinRecorder = TextEditingController();

List<PdfPatientClassModel> getstoreFtrList = [];
List<FavorateClassModel> getFavoratesList = [];
bool isFolder = false;
int? gettedKey;

class _PatientRecPgeState extends State<PatientRecPge> {
  @override
  void initState() {
    displayFutureFolderPatientDtls();
    displayGetFavorateList();
    super.initState();
  }

  void displayFutureFolderPatientDtls() async {
    final storeFtrFuction = await getFolderPatientRecDetails(email!);
    setState(() {
      getstoreFtrList = storeFtrFuction;
    });
  }

  void displayGetFavorateList() async {
    final value = await getFavorateDetails(email!);
    setState(() {
      getFavoratesList = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff7a73e7),
        title: Text(
          "Patient Record".toUpperCase(),
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: getstoreFtrList.isEmpty
                ? LottieBuilder.asset(
                    "assets/animation/Animation - 1701342007210.json")
                : ListView.separated(
                    itemCount: getstoreFtrList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      PdfPatientClassModel pdfFolder = getstoreFtrList[index];
                      bool? isLove;
                      FavorateClassModel? deleteFavModel;
                      for (var i in getFavoratesList) {
                        if (i.path == pdfFolder.Foldername) {
                          isLove = true;
                          deleteFavModel = i;

                          break;
                        } else {
                          isLove = false;
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DisplayPatientRecorder(
                                  appText: pdfFolder.Foldername),
                            ));
                          },
                          child: Slidable(
                            endActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  const SizedBox(width: 5),
                                  SlidableAction(
                                    borderRadius: BorderRadius.circular(10),
                                    onPressed: (context) async {
                                      print(isLove);
                                      if (isLove == true) {
                                        final key = await getKeyOfFavorite(
                                            deleteFavModel!);
                                        await deleteFavoriteUsingKey(key);
                                        displayGetFavorateList();
                                      } else {
                                        final getFavClass = FavorateClassModel(
                                            email: email!,
                                            type: 'folder',
                                            path: pdfFolder.Foldername);
                                        await addFavorateDetails(
                                            getFavClass, context);
                                        displayGetFavorateList();
                                      }
                                    },
                                    label: 'Fav',
                                    icon: isLove == true
                                        ? Icons.favorite_sharp
                                        : Icons.favorite_outline_sharp,
                                    spacing: 5,
                                    backgroundColor: Colors.yellow,
                                  ),
                                  const SizedBox(width: 5),
                                  SlidableAction(
                                    borderRadius: BorderRadius.circular(10),
                                    onPressed: (context) async {
                                      await alerting(context, index, pdfFolder);
                                      displayFutureFolderPatientDtls();
                                    },
                                    label: 'Delete',
                                    icon: Icons.delete,
                                    spacing: 5,
                                    backgroundColor: Colors.redAccent,
                                  )
                                ]),
                            child: Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xff7a73e7).withOpacity(0.4),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                pdfFolder.Foldername,
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff7a73e7).withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Create Record"),
                content: SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: ptEdiditinRecorder,
                    decoration: InputDecoration(
                        hintText: "Create a Folder",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(
                            0xff7a73e7), // Change this to your desired background color
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel")),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(
                            0xff7a73e7), // Change this to your desired background color
                      ),
                      onPressed: () async {
                        for (var i in getstoreFtrList) {
                          if (i.Foldername.trim() ==
                              ptEdiditinRecorder.text.trim()) {
                            isFolder = true;
                            showSnackBarImage(context,
                                "Folder Name Already Exist", Colors.red);
                            return;
                          }
                        }
                        if (ptEdiditinRecorder.text.isNotEmpty) {
                          final pdfCreate = PdfPatientClassModel(
                              ptEdiditinRecorder.text, email!);
                          await addFolderPatientRecDetails(pdfCreate, context);
                          displayFutureFolderPatientDtls();
                          Navigator.of(context).pop();
                        } else {
                          showSnackBarImage(
                              context, "Please Create a folder", Colors.red);
                        }
                      },
                      child: const Text("Add")),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add, size: 39),
      ),
    );
  }
}

Future<void> alerting(
  BuildContext context,
  int index,
  PdfPatientClassModel deletingModel,
) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete"),
        content: const Text("Are you sure to delete?"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () async {
                final keyValue = await getKeyFromHive(deletingModel);
                await deleteFolderFromHive(keyValue);
                Navigator.pop(context);
              },
              child: const Text("Delete"))
        ],
      );
    },
  );
}
