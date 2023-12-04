import 'package:flutter/material.dart';
import 'package:healthcare/alarm/localpushnotification.dart';
import 'package:healthcare/model/bpmodel.dart';
import 'package:healthcare/model/favoritemodel.dart';
import 'package:healthcare/model/heightmodel.dart';
import 'package:healthcare/model/medicalmodel.dart';
import 'package:healthcare/model/patientmodel.dart';
import 'package:healthcare/model/pdfpatientrecorder.dart';
import 'package:healthcare/model/pulsemodel.dart';
import 'package:healthcare/model/storeimgpdfmodel.dart';
import 'package:healthcare/model/weightmodel.dart';
import 'package:healthcare/splash.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  if (!Hive.isAdapterRegistered(PatientsDetailsAdapter().typeId)) {
    Hive.registerAdapter(PatientsDetailsAdapter());
  }
  Hive.registerAdapter<MedicalRemainder>(MedicalRemainderAdapter());
  await Hive.openBox<MedicalRemainder>('medicalReminders');
//blood pressure
  Hive.registerAdapter<BloodPressureModel>(BloodPressureModelAdapter());
  await Hive.openBox<BloodPressureModel>('bloodBox');
//pulse
  Hive.registerAdapter<PulseClassModel>(PulseClassModelAdapter());
  await Hive.openBox<PulseClassModel>("pulseBox");
//sugar
  Hive.registerAdapter<HeightModelClass>(HeightModelClassAdapter());
  await Hive.openBox<HeightModelClass>("sugarBox");
//weight
  Hive.registerAdapter<WeightClassModel>(WeightClassModelAdapter());
  await Hive.openBox<WeightClassModel>('WeightBox');
//pdfPatientRecord
  Hive.registerAdapter<PdfPatientClassModel>(PdfPatientClassModelAdapter());
  await Hive.openBox<PdfPatientClassModel>("pdfPateintRecBox");
//storeImagePdfModel
  Hive.registerAdapter<StoreImgPdfClassModel>(StoreImgPdfClassModelAdapter());
  await Hive.openBox<StoreImgPdfClassModel>("ImagePdfBox");
  //favorate
  Hive.registerAdapter<FavorateClassModel>(FavorateClassModelAdapter());
  await Hive.openBox<FavorateClassModel>("favorateBox");
//hive    for  diary
  var box = await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScrn(),
      debugShowCheckedModeBanner: false,
    );
  }
}
