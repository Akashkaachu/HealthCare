import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/sixcontainer/measure_util/bp.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserFeedBack extends StatefulWidget {
  const UserFeedBack({super.key});

  @override
  State<UserFeedBack> createState() => _UserFeedBackState();
}

final formKey = GlobalKey<FormState>();
TextEditingController feedbackEditingController = TextEditingController();

class _UserFeedBackState extends State<UserFeedBack> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(children: [
            Stack(
              children: [
                SizedBox(
                  // ignore: sort_child_properties_last
                  child: Image.asset(
                    "assets/images/feedbackimg.png",
                    height: size.height,
                  ),
                  width: size.width,
                  height: 179,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3, top: 160),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                    height: 650,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Form(
                            key: formKey,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter your Feedback";
                                } else {
                                  return null;
                                }
                              },
                              controller: feedbackEditingController,
                              maxLines: 20,
                              decoration: InputDecoration(
                                label: Text(
                                  "        Write your valuable Feedback",
                                  style: GoogleFonts.poppins(),
                                ),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: size.width,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await sendEmail(
                                        "akashvava29@gmail.com",
                                        feedbackEditingController.text,
                                        "Feedback");
                                    feedbackEditingController.clear();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff7a73e7)),
                                child: const Text("SEND")),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

Future<void> sendEmail(
    String emailRecipients, String subject, String body) async {
  String emailUrl = 'mailto:$emailRecipients?subject=$subject&body=$body';

  if (await canLaunchUrlString(emailUrl)) {
    await launchUrlString(emailUrl);
  } else {}
}
