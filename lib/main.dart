import 'package:flutter/material.dart';
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
  Hive.registerAdapter(
      MedicalRemainderAdapter()); // Replace with the actual generated adapter name
  await Hive.openBox<MedicalRemainder>('medicalReminders');
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
