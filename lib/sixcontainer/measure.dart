import 'package:flutter/material.dart';

class MeasurePge extends StatefulWidget {
  const MeasurePge({super.key});

  @override
  State<MeasurePge> createState() => _MeasurePgeState();
}

class _MeasurePgeState extends State<MeasurePge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff7a73e7),
        title: Text("measure"),
        centerTitle: true,
      ),
    );
  }
}
