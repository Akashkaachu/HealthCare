import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/helper/sharedpreference.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/model/medicalmodel.dart';
import 'package:healthcare/remindernew.dart';
import 'package:image_picker/image_picker.dart';

class EditReminderPge extends StatefulWidget {
  const EditReminderPge(
      {super.key, required this.medicalRemainder, required this.index});
  final MedicalRemainder medicalRemainder;
  final int index;
  @override
  State<EditReminderPge> createState() => _EditReminderPgeState();
}

File? medSelectedImge;
bool _ischeckedOne = false;
bool _ischeckedTwo = false;
bool _ischeckedThree = false;
bool isSelected = false;
bool isChoice = false;
String? groupValue;
TextEditingController medicineNameEditingController = TextEditingController();

final formkey = GlobalKey<FormState>();
List<String> selectedDays = [];
bool isExpand = false;
String? useremail;
List<MedicalRemainder> remiderlist = [];

class _EditReminderPgeState extends State<EditReminderPge> {
  @override
  void initState() {
    medicineNameEditingController =
        TextEditingController(text: widget.medicalRemainder.medicineName);
    medSelectedImge = File(widget.medicalRemainder.medicineImage!);
    _ischeckedOne = widget.medicalRemainder.morningDose;
    _ischeckedTwo = widget.medicalRemainder.afternoonDose;
    _ischeckedThree = widget.medicalRemainder.eveningDose;
    groupValue = widget.medicalRemainder.medicineType;
    selectedDays = widget.medicalRemainder.days;
    getEmailFromSharedpreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusNode currentfocus = FocusScope.of(context);
        if (!currentfocus.hasPrimaryFocus) {
          currentfocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff7a73e7),
          title: const Text("Edit Reminder"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              )),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Container(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                TextFormField(
                  controller: medicineNameEditingController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.medication),
                      label: Text(
                        "Medicine Name",
                        style: GoogleFonts.poppins(),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 5,
                  ),
                  height: size.height / 8,
                  width: size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Medicine Image",
                          style: GoogleFonts.poppins(),
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: medSelectedImge != null
                                  ? FileImage(medSelectedImge!)
                                  : null,
                              radius: 30,
                            ),
                            const SizedBox(width: 30),
                            SizedBox(
                              width: 170,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff7a73e7),
                                  ),
                                ),
                                onPressed: () async {
                                  File? medPickedImg =
                                      await pickImageFromCamera(context);
                                  setState(() {
                                    medSelectedImge = medPickedImg;
                                  });
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.image_search,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Select Image",
                                      style: GoogleFonts.poppins(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 5,
                  ),
                  height: size.height / 8,
                  width: size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Medicine Type",
                          style: GoogleFonts.poppins(),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: size.width,
                          height: (size.height / 8) / 2,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              MediPillsWid(
                                onChanged: updateGroupValue,
                                groupvalue: groupValue,
                                size: size,
                                text: "Pills",
                              ),
                              const SizedBox(width: 8),
                              MediPillsWid(
                                  onChanged: updateGroupValue,
                                  size: size,
                                  text: "Cyrup",
                                  groupvalue: groupValue),
                              const SizedBox(width: 8),
                              MediPillsWid(
                                  onChanged: updateGroupValue,
                                  size: size,
                                  text: "Ointment",
                                  groupvalue: groupValue),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: size.width,
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(width: 10),
                      ChoiceChipsWidgets(
                          text: "Sun", selectedDays: selectedDays),
                      const SizedBox(width: 10),
                      ChoiceChipsWidgets(
                          text: "Mon", selectedDays: selectedDays),
                      const SizedBox(width: 10),
                      ChoiceChipsWidgets(
                          text: "Tue", selectedDays: selectedDays),
                      const SizedBox(width: 10),
                      ChoiceChipsWidgets(
                          text: "Wed", selectedDays: selectedDays),
                      const SizedBox(width: 10),
                      ChoiceChipsWidgets(
                          text: "Thu", selectedDays: selectedDays),
                      const SizedBox(width: 10),
                      ChoiceChipsWidgets(
                          text: "Fri", selectedDays: selectedDays),
                      const SizedBox(width: 10),
                      ChoiceChipsWidgets(
                          text: "Sat", selectedDays: selectedDays),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                    height: (size.height / 8) - 20,
                    width: size.width - 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CheckboxListTile(
                          title: const Text("Morning Dose"),
                          value: _ischeckedOne,
                          onChanged: (newValue1) {
                            setState(() {
                              _ischeckedOne = newValue1!;
                            });
                          },
                          activeColor: const Color(0xff7a73e7),
                          checkColor: Colors.white,
                        ))),
                const SizedBox(height: 10),
                Container(
                    height: (size.height / 8) - 20,
                    width: size.width - 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CheckboxListTile(
                          title: const Text("Afternoon Dose"),
                          value: _ischeckedTwo,
                          onChanged: (newValue2) {
                            setState(() {
                              _ischeckedTwo = newValue2!;
                            });
                          },
                          activeColor: const Color(0xff7a73e7),
                          checkColor: Colors.white,
                        ))),
                const SizedBox(height: 10),
                Container(
                    height: (size.height / 8) - 20,
                    width: size.width - 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CheckboxListTile(
                          title: const Text("Evening Dose"),
                          value: _ischeckedThree,
                          onChanged: (newValue3) {
                            setState(() {
                              _ischeckedThree = newValue3!;
                            });
                          },
                          activeColor: const Color(0xff7a73e7),
                          checkColor: Colors.white,
                        ))),
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width - 10,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                      Color(0xff7a73e7),
                    )),
                    onPressed: () async {
                      updateReminderDatas(context, widget.index);
                      Navigator.of(context).pop(MaterialPageRoute(
                        builder: (context) => const ReminderPage(),
                      ));
                      showSnackBarImage(
                          context,
                          "Medicine Reminder Successfully Updated",
                          Colors.green);
                    },
                    child: const Text("Update"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clearAllFeild() {
    setState(() {
      _ischeckedOne = false;
      _ischeckedTwo = false;
      _ischeckedThree = false;
      medicineNameEditingController.clear();
      groupValue = null;
      medSelectedImge = null;
      selectedDays = [];
    });
  }

  void updateGroupValue(String? value) {
    setState(() {
      groupValue = value;
    });
    // ignore: avoid_print
    print(groupValue);
  }

  void getEmailFromSharedpreference() async {
    await SharedPreferenceClass.getEmailLoggedIN().then((value) {
      setState(() {
        useremail = value;
      });
    });
  }
}

class ChoiceChipsWidgets extends StatefulWidget {
  final String text;
  final List<String> selectedDays;

  ChoiceChipsWidgets({
    required this.text,
    required this.selectedDays,
  });

  @override
  State<ChoiceChipsWidgets> createState() => _ChoiceChipsWidgetsState();
}

class _ChoiceChipsWidgetsState extends State<ChoiceChipsWidgets> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      labelStyle: TextStyle(
          color: widget.selectedDays.contains(widget.text)
              ? Colors.white
              : Colors.black),
      selectedColor: const Color(0xff7a73e7),
      label: Text(
        widget.text,
        style: GoogleFonts.poppins(),
      ),
      selected: widget.selectedDays.contains(widget.text),
      onSelected: (active) {
        setState(() {
          if (active) {
            widget.selectedDays.add(widget.text);
          } else {
            widget.selectedDays.remove(widget.text);
          }
          print(widget.selectedDays);
        });
      },
    );
  }
}

class MediPillsWid extends StatefulWidget {
  const MediPillsWid({
    super.key,
    required this.size,
    required this.text,
    required this.groupvalue,
    required this.onChanged,
  });

  final Size size;
  final String text;
  final String? groupvalue;
  final ValueChanged<String?> onChanged;
  @override
  State<MediPillsWid> createState() => _MediPillsWidState();
}

class _MediPillsWidState extends State<MediPillsWid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: (widget.size.height / 8),
      width: widget.size.width / 2 - 40,
      child: Row(children: [
        Radio(
          value: widget.text,
          groupValue: widget.groupvalue,
          onChanged: (value) {
            widget.onChanged(value);
          },
        ),
        Text(widget.text)
      ]),
    );
  }
}

Future<File?> pickImageFromCamera(BuildContext con) async {
  File? image;
  final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
  try {
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
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

void updateReminderDatas(BuildContext c, int index) async {
  if (formkey.currentState!.validate()) {
    if (groupValue == null || selectedDays.isEmpty || medSelectedImge == null) {
      showSnackBarImage(c, "Please Select all options", Colors.redAccent);
    } else if (_ischeckedOne == false &&
        _ischeckedTwo == false &&
        _ischeckedThree == false) {
      showSnackBarImage(c, "Please select at least one dose", Colors.redAccent);
    } else {
      final updatedReminder = MedicalRemainder(
        alarm: true,
        email: useremail!,
        medicineName: medicineNameEditingController.text,
        medicineImage: medSelectedImge!.path,
        medicineType: groupValue,
        days: selectedDays,
        morningDose: _ischeckedOne,
        afternoonDose: _ischeckedTwo,
        eveningDose: _ischeckedThree,
      );
      editAllfieldInRemainderInHive(index, updatedReminder);
    }
  }
}
/// Edit Medicine Reminder