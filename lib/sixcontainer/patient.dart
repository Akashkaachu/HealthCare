import 'package:flutter/material.dart';

class PatientRecPge extends StatefulWidget {
  const PatientRecPge({super.key});

  @override
  State<PatientRecPge> createState() => _PatientRecPgeState();
}

class _PatientRecPgeState extends State<PatientRecPge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff7a73e7),
        title: Text("Patient Record"),
        centerTitle: true,
      ),
    );
  }
}
