import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/editprofile.dart';
import 'package:healthcare/helper/sharedpreference.dart';
import 'package:healthcare/homescreen.dart';
import 'package:healthcare/login.dart';

class ProfilePge extends StatefulWidget {
  const ProfilePge({super.key});

  @override
  State<ProfilePge> createState() => _ProfilePgeState();
}

class _ProfilePgeState extends State<ProfilePge> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        backgroundColor: const Color(0xff7a73e7),
        elevation: 0,
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        const AssetImage("assets/images/nullimage.jpg"),
                    child: GestureDetector(
                      child: Stack(children: <Widget>[
                        Positioned(
                          bottom: 1,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xff7a73e7), width: 2)),
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const EditProfilePge(),
                                      ));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Color(0xff7a73e7),
                                    ))),
                          ),
                        )
                      ]),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const ListTileWidget(text: "Name", subtext: "Hai"),
              const ListTileWidget(text: "Email", subtext: "akashvava29"),
              const ListTileWidget(
                  text: "Address",
                  subtext: "Akash.k Njarakunnu house Elankur po Edakkad "),
              const ListTileWidget(
                  text: "Tell Us About Yourself",
                  subtext: "Hai, my name akash."),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("LogOut"),
                              content: const Text("Are you sure to Logout"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      SharedPreferenceClass.saveuserLoggedfun(
                                          false);
                                      SharedPreferenceClass.saveuserEmailfun(
                                          '');
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SignPge(),
                                          ),
                                          (route) => false);
                                    },
                                    child: const Text("Log out")),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"))
                              ],
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.red; // Color when button is pressed
                            }
                            return const Color(0xff7a73e7); // Default color
                          },
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.logout_outlined),
                          SizedBox(width: 10),
                          Text(
                            "Logout",
                          ),
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.text,
    required this.subtext,
  });
  final String text;
  final String subtext;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
        const SizedBox(height: 10),
        Text(
          subtext,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        Divider(
          color: Colors.grey.withOpacity(0.5),
          thickness: 1,
        )
      ],
    );
  }
}
