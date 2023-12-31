import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/helper/sharedpreference.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/homescreen.dart';
import 'package:healthcare/login.dart';
import 'package:healthcare/model/patientmodel.dart';
import 'package:healthcare/sixcontainer/util/signuputil.dart';

class SignUpPge extends StatefulWidget {
  const SignUpPge({super.key});
  @override
  State<SignUpPge> createState() => _SignUpPgeState();
}

final formkey = GlobalKey<FormState>();
final TextEditingController nameEditingController = TextEditingController();
final TextEditingController emailEditingController = TextEditingController();
final TextEditingController passwordEditingController = TextEditingController();
final TextEditingController cpasswordEditingController =
    TextEditingController();
bool obscureboolpass = true;
bool obscureboolcpass = true;

class _SignUpPgeState extends State<SignUpPge> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusNode currentfocus = FocusScope.of(context);
        if (!currentfocus.hasPrimaryFocus) {
          currentfocus.unfocus();
        }
      },
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          color: const Color(0xff7a73e7).withOpacity(0.06),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 75, right: 75),
                    child: Image.asset("assets/images/Medical care-rafiki.png",
                        width: size.width + 900, height: size.height / 2 - 200),
                  ),
                  TextFormfld(
                      icons1: Icons.person,
                      label: "Name",
                      controller: nameEditingController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your Name";
                        } else if (value.length < 3) {
                          return "Enter Atleast 3 Charecters";
                        } else {
                          return null;
                        }
                      }),
                  TextFormfld(
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                            ? null
                            : "Please enter a valid email";
                      },
                      keybrd: TextInputType.emailAddress,
                      icons1: Icons.mail,
                      label: "Email",
                      controller: emailEditingController),
                  TextFormfld(
                      onpress: () {
                        setState(() {
                          obscureboolpass = !obscureboolpass;
                        });
                      },
                      obscure: obscureboolpass,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your Password";
                        } else if (value.length < 6) {
                          return "Enter Atleast 6 strong password";
                        } else {
                          return null;
                        }
                      },
                      icons1: Icons.fingerprint_outlined,
                      label: "Password",
                      icons2: obscureboolpass
                          ? Icons.visibility_off_outlined
                          : Icons.visibility,
                      controller: passwordEditingController),
                  TextFormfld(
                      onpress: () {
                        setState(() {
                          obscureboolcpass = !obscureboolcpass;
                        });
                      },
                      obscure: obscureboolcpass,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your Name";
                        } else if (value.length < 6) {
                          return "Enter Atleast 3 Charecters";
                        } else {
                          return null;
                        }
                      },
                      icons1: Icons.lock_outline,
                      icons2: obscureboolcpass
                          ? Icons.visibility_off_outlined
                          : Icons.visibility,
                      label: "Confirm Password",
                      controller: cpasswordEditingController),
                  SizedBox(
                    width: 340,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          if (passwordEditingController.text ==
                              cpasswordEditingController.text) {
                            final rogi = PatientsDetails(
                              email: emailEditingController.text,
                              name: nameEditingController.text,
                              password: passwordEditingController.text,
                            );

                            SharedPreferenceClass.saveuserLoggedfun(true);
                            SharedPreferenceClass.saveuserEmailfun(
                                emailEditingController.text);
                            addPatientDetails(rogi);
                            clearAllSignUpFld();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BottomNavigatorBar(),
                              ),
                            );
                          } else {
                            showSnackBar(context, Colors.red,
                                "Please Check both Password and Confirm Password");
                          }
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color?>(
                              const Color(0xff7a73e7))),
                      child: const Text("SIGNUP "),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const SignPge(),
                            ));
                          },
                          child: Row(children: [
                            Text(
                              "If already registered ",
                              style: GoogleFonts.poppins(),
                            ),
                            Text(
                              "Login",
                              style: GoogleFonts.poppins(
                                color: const Color(0xff7a73e7),
                              ),
                            )
                          ]),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearAllSignUpFld() {
    setState(() {
      nameEditingController.clear();
      emailEditingController.clear();
      passwordEditingController.clear();
      cpasswordEditingController.clear();
    });
  }
}
