import 'package:flutter/material.dart';
import 'package:healthcare/helper/sharedpreference.dart';
import 'package:healthcare/homescreen.dart';
import 'package:healthcare/model/medicalmodel.dart';
import 'package:healthcare/model/patientmodel.dart';
import 'package:healthcare/signup.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> addPatientDetails(PatientsDetails rogi) async {
  await Hive.initFlutter();
  final box = await Hive.openBox<PatientsDetails>('patient');
  box.add(rogi);
}

Future<PatientsDetails?> getPatientsDetails(String email) async {
  final box = await Hive.openBox<PatientsDetails>('patient');
  final patients = box.values.toList();
  for (PatientsDetails i in patients) {
    if (i.email == email) {
      print(i.name);
      return i;
    }
  }
  return null;
}

void checkCredentialsAndNavigate(
    String email, String password, BuildContext context) async {
  final userBox = await Hive.openBox<PatientsDetails>('patient');
  final List<PatientsDetails> users = userBox.values.toList();

  for (var user in users) {
    if (user.email == email && user.password == password) {
      SharedPreferenceClass.saveuserLoggedfun(true);
      SharedPreferenceClass.saveuserEmailfun(email);
      showSnackBar(context, Colors.green, 'Successfully Logined ');
      Navigator.of(context).pushReplacement(
        // the new route
        MaterialPageRoute(
          builder: (BuildContext context) => const BottomNavigatorBar(),
        ),
      );

      return; // Exit the loop since we found a match
    }
  }
  showSnackBar(context, Colors.red, 'Invalid email and Password');
  // If no match is found, display an error message or handle the login failure
  // ignore: avoid_print
  print("Invalid email or password");
}

Future<bool> addMedicalReminder(MedicalRemainder reminder) async {
  final box = await Hive.openBox<MedicalRemainder>('medicalReminders');

  try {
    final index = await box.add(reminder);
    if (index >= 0) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<List<MedicalRemainder>> getMedicineDetails(String email) async {
  List<MedicalRemainder> userremaindercollection = [];
  final medgetbox = await Hive.openBox<MedicalRemainder>("medicalReminders");
  List<MedicalRemainder> allremaindercollections = medgetbox.values.toList();
  for (var i in allremaindercollections) {
    if (i.email == email) {
      userremaindercollection.add(i);
    }
  }
  return userremaindercollection;
}

Future<void> updateReminderInHive(MedicalRemainder reminder, int key) async {
  var box = await Hive.openBox<MedicalRemainder>('medicalReminders');
  await box.put(key, reminder); // Using the key to update the object in Hive
}

void editAllfieldInRemainderInHive(
    int index, MedicalRemainder updatedReminder) async {
  try {
    final box = await Hive.openBox<MedicalRemainder>('medicalReminders');
    if (box.containsKey(index)) {
      await box.put(index, updatedReminder);
      // Close the box after the update
      await box.close();
    } else {
      print('Reminder at index $index does not exist.');
    }
  } catch (e) {
    print('Error updating reminder: $e');
  }
}

Future<void> updateEditedProfile(PatientsDetails selfUpdate, int key) async {
  var box = await Hive.openBox<PatientsDetails>('patient');
  await box.put(key, selfUpdate);
}

//for storing diary datas
class DiaryDataBase {
  List diaryList = [];
  final _myBox = Hive.box("mybox");

//load the data from database
  void loadData() {
    diaryList = _myBox.get("DIARY");
  }

//update the database
  void updateDataBase() {
    _myBox.put("DIARY", diaryList);
  }
}
