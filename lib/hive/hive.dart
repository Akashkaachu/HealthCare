import 'package:flutter/material.dart';
import 'package:healthcare/helper/sharedpreference.dart';
import 'package:healthcare/homescreen.dart';
import 'package:healthcare/model/bpmodel.dart';
import 'package:healthcare/model/heightmodel.dart';
import 'package:healthcare/model/medicalmodel.dart';
import 'package:healthcare/model/patientmodel.dart';
import 'package:healthcare/model/pdfpatientrecorder.dart';
import 'package:healthcare/model/pulsemodel.dart';
import 'package:healthcare/model/storeimgpdfmodel.dart';
import 'package:healthcare/model/weightmodel.dart';
import 'package:healthcare/profilepge.dart';
import 'package:healthcare/signup.dart';
import 'package:healthcare/sixcontainer/addremainder.dart';
import 'package:healthcare/sixcontainer/measure_util/measure.dart';
import 'package:healthcare/sixcontainer/patient.dart';
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
} //Making Hivebox for bloodpressureDetails

Future<void> addBloodPressureDetails(
    BloodPressureModel blood, BuildContext context) async {
  await Hive.initFlutter();
  final box = await Hive.openBox<BloodPressureModel>("bloodBox");
  final index = await box.add(blood);
  if (index >= 0) {
    strdGetFtrBP(email!);
    showSnackBarImage(context, "The blood pressure data stored", Colors.green);
  } else {
    showSnackBarImage(
        context, "The blood pressure data is not Saving", Colors.red);
  }
}

Future<List<BloodPressureModel>> getBloodPressureDetails(String email) async {
  List<BloodPressureModel> userCreatedList = [];
  final box = await Hive.openBox<BloodPressureModel>('bloodBox');
  final valueBloodBox = box.values.toList();
  for (BloodPressureModel i in valueBloodBox) {
    if (i.email == email) {
      userCreatedList.add(i);
    }
  }
  return userCreatedList;
}

Future<void> addPulseModelDetails(
    PulseClassModel pulse, BuildContext context) async {
  await Hive.initFlutter();
  final box = await Hive.openBox<PulseClassModel>('pulseBox');
  final index = await box.add(pulse);
  if (index >= 0) {
    strdGetPulse(email!);
    showSnackBar(context, Colors.green, "Pulse rate successfully added");
  } else {
    showSnackBar(context, Colors.redAccent, "Pulse rate not added");
  }
}

Future<List<PulseClassModel>> getPulseDetails(String email) async {
  List<PulseClassModel> gettedPulseDtls = [];
  final box = await Hive.openBox<PulseClassModel>('pulseBox');
  final valuePulseDtls = box.values.toList();
  for (var i in valuePulseDtls)
    if (i.email == email) {
      gettedPulseDtls.add(i);
    }
  return gettedPulseDtls;
}

Future<void> addSugarLevelDetails(
    HeightModelClass height, BuildContext context) async {
  await Hive.initFlutter();
  final box = await Hive.openBox<HeightModelClass>("sugarBox");
  final index = await box.add(height);
  if (index >= 0) {
    strdGetSugarLevel(email!);
    showSnackBarImage(
        context, "The Height is successfully added", Colors.green);
  } else {
    showSnackBarImage(context, "The Height is already exist", Colors.red);
  }
}

Future<List<HeightModelClass>> getSugarLevelDeatails(String email) async {
  List<HeightModelClass> gettedHeightDtls = [];
  final box = await Hive.openBox<HeightModelClass>("sugarBox");
  final HeightDatas = await box.values.toList();
  for (var i in HeightDatas) {
    if (i.email == email) {
      gettedHeightDtls.add(i);
    }
  }
  return gettedHeightDtls;
}

Future<void> addWeightDetails(
    WeightClassModel weight, BuildContext context) async {
  await Hive.initFlutter();
  final box = await Hive.openBox<WeightClassModel>("WeightBox");
  final index = await box.add(weight);
  if (index >= 0) {
    strdGetWeight(email!);
    showSnackBarImage(
        context, "The weight is successfully added", Colors.green);
  } else {
    showSnackBarImage(context, "Weight is already exist", Colors.red);
  }
}

Future<List<WeightClassModel>> getWeightStrDetails(String email) async {
  List<WeightClassModel> StoredWeightDtls = [];
  final box = await Hive.openBox<WeightClassModel>('WeightBox');
  final WeightDatas = await box.values.toList();
  for (var i in WeightDatas) {
    if (i.email == email) {
      StoredWeightDtls.add(i);
    }
  }
  return StoredWeightDtls;
}

Future<void> addFolderPatientRecDetails(
    PdfPatientClassModel pdfCreate, BuildContext context) async {
  await Hive.initFlutter();
  final box = await Hive.openBox<PdfPatientClassModel>("pdfPateintRecBox");
  final index = await box.add(pdfCreate);
  if (index >= 0) {
    showSnackBarImage(context, "Folder Seccessfully added", Colors.green);
    clearTxt();
  } else {
    showSnackBarImage(context, 'Folder Already Exist', Colors.red);
  }
}

void clearTxt() {
  ptEdiditinRecorder.clear();
}

Future<List<PdfPatientClassModel>> getFolderPatientRecDetails(
    String email) async {
  List<PdfPatientClassModel> gettedFolderDtls = [];
  final box = await Hive.openBox<PdfPatientClassModel>("pdfPateintRecBox");
  final folderDtls = box.values.toList();
  for (var i in folderDtls) {
    if (i.email == email) {
      gettedFolderDtls.add(i);
    }
  }
  return gettedFolderDtls;
}

Future<void> addImagePdfTypes(
    StoreImgPdfClassModel imgpdf, BuildContext context) async {
  Hive.initFlutter();
  final box = await Hive.openBox<StoreImgPdfClassModel>("ImagePdfBox");
  final index = await box.add(imgpdf);
  if (index >= 0) {
    showSnackBarImage(context, "Successfully saved", Colors.green);
  } else {
    showSnackBarImage(context, 'Invalid Pdf', Colors.red);
  }
}

Future<List<StoreImgPdfClassModel>> getImagePdfTypeDtls(
    String email, String folderName) async {
  List<StoreImgPdfClassModel> gettedImgPdfDtls = [];
  final box = await Hive.openBox<StoreImgPdfClassModel>('ImagePdfBox');
  final gettedBox = box.values.toList();
  for (var i in gettedBox) {
    if (i.email == email && i.folderName == folderName) {
      gettedImgPdfDtls.add(i);
    }
  }
  return gettedImgPdfDtls;
}

// void showSnackBarImage(BuildContext c, String content, Color color) {
//   ScaffoldMessenger.of(c).showSnackBar(SnackBar(
//     content: Text(content),
//     backgroundColor: color,
//   ));
// }
