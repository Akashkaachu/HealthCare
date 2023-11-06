import 'package:flutter/material.dart';

class DiaryPge extends StatefulWidget {
  const DiaryPge({super.key});

  @override
  State<DiaryPge> createState() => _DiaryPgeState();
}

class _DiaryPgeState extends State<DiaryPge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff7a73e7),
        title: Text("Diary"),
        centerTitle: true,
      ),
    );
  }
}
