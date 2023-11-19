import 'package:flutter/material.dart';
import 'package:healthcare/model/bpmodel.dart';
import 'package:healthcare/model/medicalmodel.dart';
import 'package:healthcare/model/patientmodel.dart';
import 'package:healthcare/splash.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(PatientsDetailsAdapter().typeId)) {
    Hive.registerAdapter(PatientsDetailsAdapter());
  }
  Hive.registerAdapter(MedicalRemainderAdapter());
  await Hive.openBox<MedicalRemainder>('medicalReminders');
  Hive.registerAdapter(BloodPressureModelAdapter());
  await Hive.openBox('name');
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
