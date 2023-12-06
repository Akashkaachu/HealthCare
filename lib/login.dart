import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/signup.dart';

class SignPge extends StatefulWidget {
  const SignPge({super.key});

  @override
  State<SignPge> createState() => _SignPgeState();
}

final TextEditingController emailEditingController = TextEditingController();
final TextEditingController passwordEditingController = TextEditingController();
final formkey = GlobalKey<FormState>();
bool obscureText = true;

class _SignPgeState extends State<SignPge> {
  void clearAllLogin() {
    setState(() {
      emailEditingController.clear();
      passwordEditingController.clear();
    });
  }

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
        backgroundColor: Colors.white,
        body: Container(
          width: size.width,
          height: size.height,
          color: const Color(0xff7a73e7).withOpacity(0.06),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                Padding(
                    padding:
                        const EdgeInsets.only(left: 75, top: 50, right: 75),
                    child: Image.asset(
                      "assets/images/Medicine-bro.png",
                      width: size.width,
                      height: size.height / 2 - 100,
                    )),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : "Please enter a valid email";
                          },
                          controller: emailEditingController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Color(0xff7a73e7),
                              ),
                              label: const Text("Email"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter the Password";
                            } else if (value.length < 6) {
                              return "Enter atleast 6 Variables";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.multiline,
                          controller: passwordEditingController,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                              label: const Text("Password"),
                              prefixIcon: const Icon(
                                Icons.fingerprint_outlined,
                                color: Color(0xff7a73e7),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                icon: obscureText
                                    ? const Icon(Icons.visibility_off_outlined)
                                    : const Icon(
                                        Icons.visibility,
                                        color: Colors.grey,
                                      ),
                              ),
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 201, 138, 138)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                    width: 340,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          final email = emailEditingController.text;
                          final password = passwordEditingController.text;
                          checkCredentialsAndNavigate(email, password, context);
                          clearAllLogin();
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xff7a73e7))),
                      child: const Text("LOGIN"),
                    )),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const SignUpPge(),
                            ));
                          },
                          child: Row(
                            children: [
                              Text(
                                "Don't have an ccount?",
                                style: GoogleFonts.poppins(),
                              ),
                              Text(
                                "Signup ",
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff7a73e7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
