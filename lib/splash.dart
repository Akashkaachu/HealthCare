import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/helper/sharedpreference.dart';
import 'package:healthcare/homescreen.dart';
import 'package:healthcare/login.dart';
import 'package:lottie/lottie.dart';

class SplashScrn extends StatefulWidget {
  const SplashScrn({super.key});

  @override
  State<SplashScrn> createState() => _SplashScrnState();
}

bool userlogged = false;

class _SplashScrnState extends State<SplashScrn> {
  @override
  void initState() {
    getSharedPreferenceData();
    splashTime(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 247, 247),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            width: size.width,
            height: size.height / 2,
            child: Image.asset(
              filterQuality: FilterQuality.medium,
              "assets/images/Virustransmission-pana.png",
            ),
          ),
          Text("Welcome to \nHEALTHCARE ❤️",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 30, fontWeight: FontWeight.bold)),
          Lottie.asset("assets/animation/De76f2dfR5.json",
              width: size.width / 2, height: size.height / 2)
        ]),
      ),
    );
  }

  void splashTime(BuildContext contex) async {
    await Future.delayed(const Duration(milliseconds: 3500));

    // ignore: use_build_context_synchronously
    Navigator.of(contex).pushReplacement(MaterialPageRoute(
      builder: (context) =>
          userlogged ? const BottomNavigatorBar() : const SignPge(),
    ));
  }

  void getSharedPreferenceData() async {
    await SharedPreferenceClass.getUserLoggedIn().then((value) {
      if (value != null) {
        setState(() {
          userlogged = value;
        });
      }
    });
  }
}
