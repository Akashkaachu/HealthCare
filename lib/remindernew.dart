import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/helper/sharedpreference.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/model/medicalmodel.dart';
import 'package:healthcare/sixcontainer/addremainder.dart';
import 'package:healthcare/sixcontainer/editremindepge.dart';
import 'package:hive_flutter/adapters.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  @override
  void initState() {
    getEmailFromSharedpreference();
    super.initState();
  }

  String? useremail;
  List<MedicalRemainder> remiderlist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reminder",
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff7a73e7),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: remiderlist.length,
          itemBuilder: (context, index) {
            final reminder = remiderlist[index];
            return InkWell(
              onLongPress: () {},
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      EditReminderPge(medicalRemainder: reminder, index: index),
                ));
              },
              child: ListTile(
                trailing: Switch(
                  value: reminder.alarm,
                  onChanged: (value) {
                    reminder.alarm = value;
                    int key = getKeyOfReminder(reminder);
                    updateReminderInHive(reminder, key);
                    displaystoredremainderdata();
                  },
                  activeTrackColor: const Color(0xff7a73e7),
                  activeColor: const Color(0xff7a73e7),
                ),
                leading: CircleAvatar(
                    radius: 40,
                    backgroundImage: reminder.medicineImage != null
                        ? FileImage(File(reminder.medicineImage!))
                        : null),
                title: Text(
                  reminder.medicineName,
                  style: GoogleFonts.poppins(),
                ),
                subtitle: Text(
                  reminder.medicineType ?? "No Medicine type",
                  style: GoogleFonts.poppins(),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff7a73e7),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddRemainderPge(),
              ));
        },
      ),
    );
  }

  void getEmailFromSharedpreference() async {
    await SharedPreferenceClass.getEmailLoggedIN().then((value) {
      setState(() {
        useremail = value;
      });
    });
    displaystoredremainderdata();
  }

  void displaystoredremainderdata() async {
    final value = await getMedicineDetails(useremail!);
    setState(() {
      remiderlist = value;
      //  print(remiderlist.length);
    });
  }
}

int getKeyOfReminder(MedicalRemainder reminder) {
  var box = Hive.box<MedicalRemainder>('medicalReminders');
  var key = box.keyAt(box.values.toList().indexOf(reminder));
  return key;
}
//Reminderpage