// ignore_for_file: body_might_complete_normally_nullable, annotate_overrides

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/helper/sharedpreference.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/homescreen.dart';
import 'package:healthcare/model/patientmodel.dart';
import 'package:healthcare/profilepge.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePge extends StatefulWidget {
  final PatientsDetails mydetails;
  const EditProfilePge({super.key, required this.mydetails});

  @override
  State<EditProfilePge> createState() => _EditProfilePgeState();
}

final formkey = GlobalKey<FormState>();
late TextEditingController nameEditingcontrollerr;
late TextEditingController emailEditingcontrollerr;
late TextEditingController addressEditingcontrollerr;
late TextEditingController tellUsEditingcontrollerr;
File? selectedImage;

class _EditProfilePgeState extends State<EditProfilePge> {
  @override
  void initState() {
    nameEditingcontrollerr = TextEditingController(text: widget.mydetails.name);
    emailEditingcontrollerr =
        TextEditingController(text: widget.mydetails.email);
    addressEditingcontrollerr =
        TextEditingController(text: widget.mydetails.address);
    tellUsEditingcontrollerr =
        TextEditingController(text: widget.mydetails.about);
    if (widget.mydetails.imagesrc != null) {
      selectedImage = File(widget.mydetails.imagesrc!);
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentfocus = FocusScope.of(context);
        if (!currentfocus.hasPrimaryFocus) {
          currentfocus.unfocus();
        }
      },
      child: Scaffold(
          backgroundColor: Colors.blue[50],
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfilePge(),
                  ));
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xff7a73e7),
            elevation: 0,
            title: Text(
              "Edit Profile",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            // ignore: avoid_unnecessary_containers
            child: Container(
                child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  File? pickedImage =
                                      await pickImageFromGallery(context);
                                  setState(() {
                                    selectedImage = pickedImage;
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey.shade200,
                                  radius: 60,
                                  backgroundImage: selectedImage != null
                                      ? FileImage(selectedImage!)
                                      : null,
                                  child: selectedImage == null
                                      ? Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            const Center(
                                              child: Positioned(
                                                child: Icon(Icons.person,
                                                    color: Color(0xff7a73e7),
                                                    size: 59),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 1,
                                              right: 0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xff7a73e7),
                                                    width: 2,
                                                  ),
                                                ),
                                                child: selectedImage == null
                                                    ? CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                            Icons
                                                                .image_search_outlined,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      )
                                                    : null,
                                              ),
                                            ),
                                          ],
                                        )
                                      : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 35),
                          ProfileTextfldWidget(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter your Name";
                                } else if (value.length < 3) {
                                  return "YOu must Enter Atleast 3 charecters";
                                } else {
                                  return null;
                                }
                              },
                              controller: nameEditingcontrollerr,
                              icons: Icons.person,
                              name: "name"),
                          const SizedBox(height: 15),
                          ProfileTextfldWidget(
                              validator: (value) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value!)
                                    ? null
                                    : "Please enter a valid email";
                              },
                              keyboard: TextInputType.emailAddress,
                              controller: emailEditingcontrollerr,
                              name: "Email",
                              icons: Icons.email_outlined),
                          const SizedBox(height: 15),
                          ProfileTextfldWidget(
                              validator: (value) {},
                              controller: addressEditingcontrollerr,
                              icons: Icons.home_outlined,
                              name: "Address"),
                          const SizedBox(height: 15),
                          ProfileTextfldWidget(
                              validator: (value) {},
                              controller: tellUsEditingcontrollerr,
                              icons: Icons.edit_note_outlined,
                              name: "Tell Us About Your Self"),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: 340,
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Color(0xff7a73e7)),
                                ),
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    if (selectedImage != null) {
                                      final key = getKeyOfProfileSelfUpdate(
                                          widget.mydetails);

                                      final value = PatientsDetails(
                                          name: nameEditingcontrollerr.text,
                                          email: emailEditingcontrollerr.text,
                                          password: widget.mydetails.password,
                                          address:
                                              addressEditingcontrollerr.text,
                                          about: tellUsEditingcontrollerr.text,
                                          imagesrc: selectedImage!.path);

                                      updateEditedProfile(value, key);
                                      SharedPreferenceClass.saveuserEmailfun(
                                          emailEditingcontrollerr.text);
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const BottomNavigatorBar(),
                                          ),
                                          (route) => false);
                                    } else {
                                      showSnackBarImage(
                                          context,
                                          "Please select Profile Image",
                                          Colors.red);
                                    }
                                  }
                                },
                                child: const Text("UPDATE")),
                          )
                        ],
                      ),
                    ))),
          )),
    );
  }
}

class ProfileTextfldWidget extends StatelessWidget {
  const ProfileTextfldWidget({
    super.key,
    required this.name,
    required this.icons,
    required this.controller,
    required this.validator,
    this.keyboard,
  });
  final String name;
  final IconData icons;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? keyboard;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      validator: validator,
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          prefixIcon: Icon(
            icons,
            color: Colors.black,
          ),
          label: Text(name),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)))),
    );
  }
}

Future<File?> pickImageFromGallery(BuildContext con) async {
  File? image;
  final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  try {
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    // ignore: use_build_context_synchronously
    showSnackBarImage(con, e.toString(), Colors.redAccent);
  }
  return image;
}

void showSnackBarImage(BuildContext c, String content, Color color) {
  ScaffoldMessenger.of(c).showSnackBar(SnackBar(
    content: Text(content),
    backgroundColor: color,
  ));
}

int getKeyOfProfileSelfUpdate(PatientsDetails patient) {
  var box = Hive.box<PatientsDetails>('patient');
  var key = box.keyAt(box.values.toList().indexOf(patient));
  return key;
}
