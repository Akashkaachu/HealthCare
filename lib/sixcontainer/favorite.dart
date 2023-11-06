import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoratePge extends StatefulWidget {
  const FavoratePge({super.key});

  @override
  State<FavoratePge> createState() => _FavoratePgeState();
}

class _FavoratePgeState extends State<FavoratePge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff7a73e7),
        title: Text(
          "Favorite",
          style: GoogleFonts.nosifer(),
        ),
        centerTitle: true,
      ),
    );
  }
}
