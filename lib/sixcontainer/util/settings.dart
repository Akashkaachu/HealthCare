// ignore_for_file: non_constant_identifier_names, avoid_print, sort_child_properties_last, use_build_context_synchronously, must_be_immutable, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/editprofile.dart';
import 'package:healthcare/helper/sharedpreference.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/login.dart';
import 'package:healthcare/model/patientmodel.dart';
import 'package:healthcare/profilepge.dart';
import 'package:healthcare/sixcontainer/util/feedback.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

String? Settingemail = '';
TextEditingController changePasswordEditingController = TextEditingController();
PatientsDetails usermodel = PatientsDetails(name: '', email: '', password: '');
final formKeyUpdatePass = GlobalKey<FormState>();

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  void getUserDetails() async {
    await SharedPreferenceClass.getEmailLoggedIN().then((value) {
      setState(() {
        Settingemail = value;
      });
    });
    PatientsDetails? OnePatientDetails =
        await getPatientsDetails(Settingemail!);
    print(OnePatientDetails!.imagesrc);
    setState(() {
      usermodel = OnePatientDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xff7a73e7).withOpacity(0.6),
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            child: Image.asset(
              "assets/images/patient-settings.png",
              width: size.width,
            ),
            color: const Color(0xff7a73e7).withOpacity(0.6),
            width: size.width,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2, right: 2, top: 160),
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: size.height,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 90,
                            backgroundImage: usermodel.imagesrc != null
                                ? FileImage(File(usermodel.imagesrc!))
                                : null,
                            child: usermodel.imagesrc == null
                                ? const Stack(
                                    alignment: Alignment.center,
                                    children: [
                                        Center(
                                          child: Positioned(
                                            child: Icon(Icons.person,
                                                color: Color(0xff7a73e7),
                                                size: 99),
                                          ),
                                        ),
                                      ]) // Replace with the actual path to your default image asset
                                : null),
                        const SizedBox(height: 30),
                        SettingWidgets(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const UserFeedBack(),
                              ));
                            },
                            title: 'User Feedback',
                            leading: Icons.chat,
                            trailing: Icons.arrow_right),
                        SettingWidgets(
                            onTap: () {
                              launchAmazonApp();
                            },
                            title: 'Rate Us',
                            leading: Icons.star_half,
                            trailing: Icons.arrow_right),
                        SettingWidgets(
                          onTap: () {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                )),
                                context: context,
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: Container(
                                      color: const Color(0xff7a73e7)
                                          .withOpacity(0.1),
                                      height: 450,
                                      child: Column(children: [
                                        const SizedBox(height: 15),
                                        Text(
                                          "Change Password",
                                          style:
                                              GoogleFonts.poppins(fontSize: 20),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Form(
                                            key: formKeyUpdatePass,
                                            child: TextFormField(
                                              controller:
                                                  changePasswordEditingController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Enter new password";
                                                } else if (value.length < 6) {
                                                  return "Enter a Strong Password";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                  label: Text(
                                                      "Change Your password"),
                                                  border: OutlineInputBorder()),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width - 30,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                if (formKeyUpdatePass
                                                    .currentState!
                                                    .validate()) {
                                                  final key =
                                                      await getKeyChangingPassword(
                                                          usermodel);
                                                  final updatedmodel =
                                                      PatientsDetails(
                                                          name: usermodel.name,
                                                          email:
                                                              usermodel.email,
                                                          password:
                                                              changePasswordEditingController
                                                                  .text);
                                                  updateChangingPassword(
                                                      key, updatedmodel);

                                                  Navigator.pop(context);
                                                  changePasswordEditingController
                                                      .clear();

                                                  showSnackBarImage(
                                                      context,
                                                      "Passoword successfully Updated",
                                                      Colors.green);
                                                } else {
                                                  showSnackBarImage(
                                                      context,
                                                      "Don't submit before entering a value!",
                                                      Colors.red);
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xff7a73e7)),
                                              child: const Text(
                                                "SUBMIT",
                                              )),
                                        )
                                      ]),
                                    ),
                                  );
                                });
                          },
                          title: 'Change password',
                          leading: Icons.key,
                          // trailing: Icons.add_location_outlined
                        ),
                        SettingWidgets(
                          onTap: () {
                            deleteAccount(context, email!);
                          },
                          title: 'Delete account ',
                          leading: Icons.delete,
                          // trailing: Icons.add_location_outlined,
                        ),
                      ],
                    ),
                  ),
                )),
          )
        ],
      )),
    );
  }
}

class SettingWidgets extends StatelessWidget {
  SettingWidgets({
    super.key,
    required this.onTap,
    this.trailing,
    required this.leading,
    required this.title,
  });
  void Function()? onTap;
  final IconData? trailing;
  final IconData? leading;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(title),
        leading: Icon(
          leading,
          color: const Color(0xff7a73e7),
        ),
        trailing: Icon(trailing),
        // onTap: () {},
      ),
    );
  }
}

//rate Us
Future<void> launchAmazonApp() async {
  const String amazonAppUrl = 'amzn://apps/android?p=com.amazon.windowshop';
  const String fallbackUrl =
      'https://www.amazon.com/dp/B0CLKWX2YH/ref=apps_sf_sta';

  if (await canLaunch(amazonAppUrl)) {
    await launch(amazonAppUrl);
  } else {
    print('Amazon App is not installed. Opening in a browser.');
    await launch(fallbackUrl);
  }
}

//Delete account
void deleteAccount(
  BuildContext context,
  String email,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete Account"),
        content: Text(
          "Do you want Delete this Account?",
          style: GoogleFonts.poppins(color: Colors.red),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () async {
                await deleteuser(email);
                await deleteUserAccount(email);
                SharedPreferenceClass.saveuserLoggedfun(false);
                SharedPreferenceClass.saveuserEmailfun('');
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const SignPge(),
                    ),
                    (route) => false);
              },
              child: const Text("Delete"))
        ],
      );
    },
  );
}
