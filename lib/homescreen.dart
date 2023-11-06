import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/profilepge.dart';
import 'package:healthcare/remindernew.dart';
import 'package:healthcare/sixcontainer/dairy.dart';
import 'package:healthcare/sixcontainer/diseasecom.dart';
import 'package:healthcare/sixcontainer/favorite.dart';
import 'package:healthcare/sixcontainer/firstaid.dart';
import 'package:healthcare/sixcontainer/measure.dart';
import 'package:healthcare/sixcontainer/patient.dart';

class BottomNavigatorBar extends StatefulWidget {
  const BottomNavigatorBar({super.key});

  @override
  State<BottomNavigatorBar> createState() => _BottomNavigatorBarState();
}

int currentindex = 1;
List<Widget> pages = [
  const MeasurePge(),
  const HomePage(),
  const FavoratePge()
];

class _BottomNavigatorBarState extends State<BottomNavigatorBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentindex],
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: Color.fromARGB(255, 221, 237, 250),
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              currentindex = index;
            });
          },
          items: const [
            Icon(
              Icons.bar_chart_outlined,
              color: Color(0xff7a73e7),
            ),
            Icon(
              Icons.home,
              color: Color(0xff7a73e7),
            ),
            Icon(
              Icons.favorite,
              color: Color(0xff7a73e7),
            )
          ]),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xff7a73e7),
            title: Text(
              "HEALTH CARE ",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfilePge(),
                    ));
                  },
                  child: const CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/courserpic1.jpg"),
                  ),
                ),
              )
            ],
          ),
          body: Container(
            width: size.width,
            height: size.height,
            color: const Color(0xff7a73e7).withOpacity(0.04),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(height: 5),
                      CarouselSlider(
                          items: const [
                            cousersWidgets(image: "assets/images/D&P.jpg"),
                            cousersWidgets(
                                image: "assets/images/courserpic1.jpg"),
                            cousersWidgets(
                                image: "assets/images/courserpic2.jpeg"),
                          ],
                          options: CarouselOptions(
                              height: 200,
                              aspectRatio: 16 / 8,
                              viewportFraction: 1,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              enlargeCenterPage: true,
                              enlargeFactor: 0.4)),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 18, right: 17, top: 15),
                        child: Column(
                          children: [
                            ContainerWidget(
                                image: "assets/images/firstaidHm.png",
                                text: "FIRST AID",
                                size: size,
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const FirstaidPge(),
                                  ));
                                }),
                            const SizedBox(height: 14),
                            // ContainerWidget(
                            //   image: "assets/images/icons8-diary-100.png",
                            //   text: "Diary",
                            //   size: size,
                            //   onTap: () {
                            //     Navigator.of(context).push(MaterialPageRoute(
                            //       builder: (context) => const DiaryPge(),
                            //     ));
                            //   },
                            // ),
                            const SizedBox(height: 14),
                            ContainerWidget(
                              image: "assets/images/icons8-remainder-64.png",
                              text: " REMINDER",
                              size: size,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ReminderPage(),
                                ));
                              },
                            ),
                            const SizedBox(height: 15),
                            ContainerWidget(
                              image: "assets/images/icons8-report-64.png",
                              text: "PATIENT RECORD ",
                              size: size,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const PatientRecPge(),
                                ));
                              },
                            ),
                            const SizedBox(height: 14),
                            ContainerWidget(
                              image: "assets/images/icons8-infection-64.png",
                              text: "DISEASE COMPILISATION ",
                              size: size,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const DeseaseComPge(),
                                ));
                              },
                            ),
                            const SizedBox(height: 14),
                            // ContainerWidget(
                            //   image:
                            //       "assets/images/icons8-add-to-favorites-64.png",
                            //   text: "Favorite",
                            //   size: size,
                            //   onTap: () {
                            //     Navigator.of(context).push(MaterialPageRoute(
                            //       builder: (context) => const FavoratePge(),
                            //     ));
                            //   },
                            // ),
                            const SizedBox(height: 15),
                            ContainerWidget(
                              image:
                                  "assets/images/icons8-resize-vertical-64.png",
                              text: "MEASUREMENTS ",
                              size: size,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const MeasurePge(),
                                ));
                              },
                            ),
                            const SizedBox(height: 14),
                            // ContainerWidget(
                            //   image: "assets/images/icons8-test-tube-32.png",
                            //   text: "Test",
                            //   size: size,
                            //   onTap: () {
                            //     Navigator.of(context).push(MaterialPageRoute(
                            //       builder: (context) => const MeasurePge(),
                            //     ));
                            //   },
                            // ),
                            const SizedBox(height: 25),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    super.key,
    required this.size,
    required this.onTap,
    required this.image,
    required this.text,
  });

  final Size size;
  final void Function()? onTap;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.width / 2,
        width: size.height / 4 + 200,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, blurRadius: 2.0, offset: Offset(1.0, 1.0))
            ],
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.grey, width: 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.width / 8 + 20,
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              text,
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

class cousersWidgets extends StatelessWidget {
  const cousersWidgets({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(25)),
    );
  }
}