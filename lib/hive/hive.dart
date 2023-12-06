// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:healthcare/helper/sharedpreference.dart';
import 'package:healthcare/homescreen.dart';
import 'package:healthcare/model/bpmodel.dart';
import 'package:healthcare/model/favoritemodel.dart';
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
import 'package:healthcare/sixcontainer/util/signuputil.dart';
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
      emailEditingController.clear();
      passwordEditingController.clear();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const BottomNavigatorBar(),
        ),
      );

      // return; // Exit the loop since we found a match
    }
  }
  showSnackBar(context, Colors.red, 'Invalid email or Password');
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
  final HeightDatas = box.values.toList();
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

  final WeightDatas = box.values.toList();
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

//favorate
Future<void> addFavorateDetails(
    FavorateClassModel favorateModel, BuildContext context) async {
  final box = await Hive.openBox<FavorateClassModel>("favorateBox");
  await box.add(favorateModel);
}

Future<List<FavorateClassModel>> getFavorateDetails(String email) async {
  List<FavorateClassModel> getFavValues = [];
  final box = await Hive.openBox<FavorateClassModel>("favorateBox");
  final favVal = box.values.toList();
  for (var i in favVal) {
    if (i.email == email) {
      getFavValues.add(i);
    }
  }
  return getFavValues;
}

//delete patients recorder ...folders from  hive...
Future<int> getKeyFromHive(PdfPatientClassModel deletingModel) async {
  final box = await Hive.openBox<PdfPatientClassModel>("pdfPateintRecBox");
  int key = box.keyAt(box.values.toList().indexOf(deletingModel));
  return key;
}

Future<void> deleteFolderFromHive(int key) async {
  final box = await Hive.openBox<PdfPatientClassModel>("pdfPateintRecBox");
  box.delete(key);
}

//delete patient recorder...image & pdf from hive

Future<int> getKeyOfImageAndPdf(StoreImgPdfClassModel ImgPdfModel) async {
  final box = await Hive.openBox<StoreImgPdfClassModel>("ImagePdfBox");
  final keys = box.keyAt(box.values.toList().indexOf(ImgPdfModel));
  return keys;
}

Future<void> deleteImgAndPdgFrmHive(int key) async {
  final box = await Hive.openBox<StoreImgPdfClassModel>("ImagePdfBox");
  box.delete(key);
}

//delete Blood pressure from hive
Future<int> getKeysOfBPFromHive(BloodPressureModel BAndPModel) async {
  final box = await Hive.openBox<BloodPressureModel>("bloodBox");
  final key = box.keyAt(box.values.toList().indexOf(BAndPModel));
  return key;
}

Future<void> deleteBAndPModel(int key) async {
  final box = await Hive.openBox<BloodPressureModel>("bloodBox");
  box.delete(key);
}

//deleting pulse from hive
Future<int> getKeyFormHive(PulseClassModel pulseKeyModel) async {
  final box = await Hive.openBox<PulseClassModel>("pulseBox");
  final key = box.keyAt(box.values.toList().indexOf(pulseKeyModel));
  return key;
}

Future<void> deletePulseFromHive(int key) async {
  final box = await Hive.openBox<PulseClassModel>("pulseBox");
  box.delete(key);
}
//delete weight from hive

Future<int> getKeyOfWeight(WeightClassModel weightModel) async {
  final box = await Hive.openBox<WeightClassModel>("WeightBox");
  final key = box.keyAt(box.values.toList().indexOf(weightModel));
  return key;
}

Future<void> deleteWeightFromHive(int key) async {
  final box = await Hive.openBox<WeightClassModel>("WeightBox");
  box.delete(key);
}

//delete sugar from hive(heightModelClass paranjal ..aadhyam height ayirunn pinne ath  change cheyth sugar aaki appo error varanda vachit aan heightmodel enn vachath)
Future<int> getKeyOfSugar(HeightModelClass sugarModel) async {
  final box = await Hive.openBox<HeightModelClass>("sugarBox");
  final key = box.keyAt(box.values.toList().indexOf(sugarModel));
  return key;
}

Future<void> deleteSugarFromHive(int key) async {
  final box = await Hive.openBox<HeightModelClass>("sugarBox");
  box.delete(key);
}

//delete displayed reminder from hive

Future<void> deleteReminder(int key) async {
  final box = await Hive.openBox<MedicalRemainder>("medicalReminders");
  box.delete(key);
}

//changing password
Future<int> getKeyChangingPassword(PatientsDetails updatePassword) async {
  final box = await Hive.openBox<PatientsDetails>("patient");
  final key = box.keyAt(box.values.toList().indexOf(updatePassword));
  return key;
}

Future<void> updateChangingPassword(
    int key, PatientsDetails updatemodel) async {
  final box = await Hive.openBox<PatientsDetails>("patient");
  box.put(key, updatemodel);
}

//delete account
Future<void> deleteuser(String email) async {
  final box = await Hive.openBox<PatientsDetails>("patient");
  final keyList = box.keys.where((key) {
    final user = box.get(key);
    return user != null && user.email == email;
  }).toList();
  for (var i in keyList) {
    await box.delete(i);
  }
}

Future<void> deleteUserAccount(String email) async {
  final box = await Hive.openBox<PatientsDetails>("patients");
  final keyforDlt = box.keys.where((key) {
    final user = box.get(key);
    return user != null && user.email == email;
  }).toList();
  for (final i in keyforDlt) {
    await box.delete(i);
  }
}

//get key favorite
Future<int> getKeyOfFavorite(FavorateClassModel favoriteModel) async {
  final box = await Hive.openBox<FavorateClassModel>("favorateBox");
  final key = box.keyAt(box.values.toList().indexOf(favoriteModel));
  return key;
}

//get delete
Future<void> deleteFavoriteUsingKey(int key) async {
  final box = await Hive.openBox<FavorateClassModel>("favorateBox");
  box.delete(key);
}
