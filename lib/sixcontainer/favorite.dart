import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/helper/sharedpreference.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/model/favoritemodel.dart';
import 'package:healthcare/model/pdfpatientrecorder.dart';
import 'package:healthcare/profilepge.dart';
import 'package:healthcare/sixcontainer/newpatientrec.dart';
import 'package:healthcare/sixcontainer/patient.dart';

class FavoratePge extends StatefulWidget {
  const FavoratePge({super.key});

  @override
  State<FavoratePge> createState() => _FavoratePgeState();
}

class _FavoratePgeState extends State<FavoratePge> {
  @override
  void initState() {
    getEmailFromSharedFromSP();
    super.initState();
  }

  void getEmailFromSharedFromSP() async {
    await SharedPreferenceClass.getEmailLoggedIN().then((value) {
      setState(() {
        email = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xff7a73e7),
          title: Text(
            "Favorite".toUpperCase(),
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true),
      body: Container(
          child: Column(
        children: [
          FutureBuilder<List<FavorateClassModel>>(
            future: getFavorateDetails(email!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text("Error");
              } else {
                List<FavorateClassModel> FavorList = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: FavorList.length,
                    itemBuilder: (context, index) {
                      FavorateClassModel favorateModel = FavorList[index];

                      const SizedBox(height: 10);
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DisplayPatientRecorder(
                                appText: favorateModel.path),
                          ));
                        },
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: const Color(0xff7a73e7)
                                        .withOpacity(0.4),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  favorateModel.path,
                                  style: GoogleFonts.poppins(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      )),
    );
  }
}
