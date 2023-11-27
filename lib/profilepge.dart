import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/editprofile.dart';
import 'package:healthcare/helper/sharedpreference.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/homescreen.dart';
import 'package:healthcare/login.dart';
import 'package:healthcare/model/patientmodel.dart';

String? email = '';

class ProfilePge extends StatefulWidget {
  const ProfilePge({super.key});

  @override
  State<ProfilePge> createState() => _ProfilePgeState();
}

PatientsDetails patient =
    PatientsDetails(name: '', email: '', password: '', address: '', about: '');

class _ProfilePgeState extends State<ProfilePge> {
  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BottomNavigatorBar(),
              ));
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        backgroundColor: const Color(0xff7a73e7),
        elevation: 0,
        title: Text(
          "Profile".toUpperCase(),
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xff7a73e7),
                    radius: 60,
                    backgroundImage: selectedImage != null
                        ? FileImage(selectedImage!)
                        : null,
                    child: GestureDetector(
                      child: Stack(children: <Widget>[
                        Positioned(
                          bottom: 1,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xff7a73e7), width: 2)),
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfilePge(
                                                    mydetails: patient,
                                                  )));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Color(0xff7a73e7),
                                    ))),
                          ),
                        )
                      ]),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ListTileWidget(text: "Name", subtext: patient.name),
              ListTileWidget(text: "Email", subtext: patient.email),
              ListTileWidget(
                  text: "Address",
                  subtext: patient.address == null ? '' : patient.address!),
              ListTileWidget(
                  text: "Tell Us About Yourself",
                  subtext: patient.about == null ? '' : patient.about!),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("LogOut"),
                              content: const Text("Are you sure to Logout"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      SharedPreferenceClass.saveuserLoggedfun(
                                          false);
                                      SharedPreferenceClass.saveuserEmailfun(
                                          '');
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SignPge(),
                                          ),
                                          (route) => false);
                                    },
                                    child: const Text("Log out")),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"))
                              ],
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.red; // Color when button is pressed
                            }
                            return const Color(0xff7a73e7); // Default color
                          },
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.logout_outlined),
                          SizedBox(width: 10),
                          Text(
                            "Logout",
                          ),
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  void getUserDetails() async {
    await SharedPreferenceClass.getEmailLoggedIN().then((value) {
      setState(() {
        email = value;
      });
    });
    final OnePatientDetails = await getPatientsDetails(email!);
    setState(() {
      patient = OnePatientDetails!;
    });
  }
}

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.text,
    required this.subtext,
  });
  final String text;
  final String subtext;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
        const SizedBox(height: 10),
        Text(
          subtext,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        Divider(
          color: Colors.grey.withOpacity(0.5),
          thickness: 1,
        )
      ],
    );
  }
}
