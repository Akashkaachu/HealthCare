import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/helper/sharedpreference.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/model/medicalmodel.dart';
import 'package:healthcare/sixcontainer/addremainder.dart';
import 'package:healthcare/sixcontainer/editremindepge.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

ValueNotifier<List<MedicalRemainder>> remiderlist =
    ValueNotifier<List<MedicalRemainder>>([]);

class _ReminderPageState extends State<ReminderPage> {
  @override
  void initState() {
    getEmailFromSharedpreference();
  }

  String? useremail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "REMINDER",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
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
      body: ValueListenableBuilder(
          valueListenable: remiderlist,
          builder: (context, listReminder, child) {
            return listReminder.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieBuilder.asset(
                          "assets/animation/Animation - 1701342007210.json"),
                    ],
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                      );
                    },
                    itemCount: listReminder.length,
                    itemBuilder: (context, index) {
                      final reminder = listReminder[index];
                      return InkWell(
                        onLongPress: () {
                          alertReminder(context, reminder, useremail!);
                        },
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditReminderPge(
                                medicalRemainder: reminder, index: index),
                          ));
                        },
                        child: ListTile(
                          trailing: Switch(
                            value: reminder.alarm,
                            onChanged: (value) {
                              reminder.alarm = value;
                              int key = getKeyOfReminder(reminder);
                              updateReminderInHive(reminder, key);
                              displayReminderList(useremail!);
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
                    });
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
    displayReminderList(useremail!);
  }

  // void displaystoredremainderdata() async {
  //   final value = await getMedicineDetails(useremail!);
  //   setState(() {
  //     remiderlist = value;
  //     //  print(remiderlist.length);
  //   });
  // }
}

int getKeyOfReminder(MedicalRemainder reminder) {
  var box = Hive.box<MedicalRemainder>('medicalReminders');
  var key = box.keyAt(box.values.toList().indexOf(reminder));
  return key;
}

void alertReminder(
    BuildContext context, MedicalRemainder medReminderModel, String useremail) {
  showAdaptiveDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete Reminder"),
        content: const Text("Do you want to delete Reminder"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () async {
                int key = getKeyOfReminder(medReminderModel);
                print(key);
                await deleteReminder(key);
                await displayReminderList(useremail);
                Navigator.pop(context);
              },
              child: const Text('Delete'))
        ],
      );
    },
  );
}

Future<void> displayReminderList(String email) async {
  final value = await getMedicineDetails(email);
  remiderlist.value = value;
  remiderlist.notifyListeners();
}
