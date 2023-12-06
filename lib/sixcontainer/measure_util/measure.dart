// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/model/bpmodel.dart';
import 'package:healthcare/model/heightmodel.dart';
import 'package:healthcare/model/pulsemodel.dart';
import 'package:healthcare/model/weightmodel.dart';
import 'package:healthcare/profilepge.dart';
import 'package:healthcare/sixcontainer/measure_util/bp.dart';
import 'package:healthcare/sixcontainer/measure_util/mstdisplaypge.dart';
import 'package:healthcare/sixcontainer/measure_util/pulse.dart';
import 'package:healthcare/sixcontainer/measure_util/sugar.dart';
import 'package:healthcare/sixcontainer/measure_util/weight.dart';
import 'package:intl/intl.dart';

class MeasurePge extends StatefulWidget {
  const MeasurePge({super.key});

  @override
  State<MeasurePge> createState() => _MeasurePgeState();
}

ValueNotifier<List<BloodPressureModel>> getStoredBloodPsr =
    ValueNotifier<List<BloodPressureModel>>([]);
ValueNotifier<List<PulseClassModel>> getStoredPulse =
    ValueNotifier<List<PulseClassModel>>([]);
ValueNotifier<List<HeightModelClass>> getStoredHeight =
    ValueNotifier<List<HeightModelClass>>([]);
ValueNotifier<List<WeightClassModel>> getStoredWeight =
    ValueNotifier<List<WeightClassModel>>([]);

var formate = DateFormat('dd MMM yyyy');

class _MeasurePgeState extends State<MeasurePge> {
  @override
  void initState() {
    strdGetFtrBP(email!);
    strdGetPulse(email!);
    strdGetSugarLevel(email!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff7a73e7),
        title: Text(
          "MEASUREMENTS",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: const Color(0xff7a73e7),
        overlayOpacity: 0.4,
        spacing: 12,
        spaceBetweenChildren: 12,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.bloodtype),
              label: "BP ",
              labelStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.amber,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const BloodPressurePage(),
                ));
              }),
          SpeedDialChild(
              child: const Icon(Icons.add_box_rounded),
              label: "PULSE",
              labelStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.amber,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PulsePage(),
                ));
              }),
          SpeedDialChild(
              child: const Icon(Icons.settings_accessibility_outlined),
              label: "WEIGHT",
              labelStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.amber,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const WeightPage(),
                ));
              }),
          SpeedDialChild(
              child: const Icon(Icons.water_drop_rounded),
              label: "SUGAR LEVEL",
              labelStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.amber,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SugarLevelMeasurement(),
                ));
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MeasurementContainerWidget(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MeasurementDisPage(
                        appText: "BLOOD PRESSURE",
                        searchBar: "Search BloodPressure"),
                  ));
                },
                size: size,
                image: "assets/images/DocCheckBp.png",
                text: "BLOOD PRESSURE"),
            MeasurementContainerWidget(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MeasurementDisPage(
                      appText: "PULSE", searchBar: "Search Pulse"),
                ));
              },
              size: size,
              image: 'assets/images/DocPulChk.png',
              text: 'PULSE',
            ),
            MeasurementContainerWidget(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MeasurementDisPage(
                      appText: "WEIGHT", searchBar: "Search Weight"),
                ));
              },
              size: size,
              image: 'assets/images/weightmeasuring.png',
              text: 'WEIGHT',
            ),
            MeasurementContainerWidget(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MeasurementDisPage(
                      appText: "SUGAR LEVEL", searchBar: "Search SugarLevel"),
                ));
              },
              size: size,
              image: 'assets/images/sugarlevelimage.png',
              text: 'SUGAR LEVEL',
            ),
          ],
        ),
      ),
    );
  }
}

class MeasurementContainerWidget extends StatelessWidget {
  const MeasurementContainerWidget({
    super.key,
    required this.size,
    required this.image,
    required this.text,
    required this.onTap,
  });

  final Size size;
  final String image;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xff7a73e7).withOpacity(0.6),
              borderRadius: BorderRadius.circular(10.0)),
          width: size.width,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 67,
                backgroundImage: AssetImage(image),
              ),
              const SizedBox(width: 19),
              Text(
                text,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> strdGetFtrBP(String email) async {
  final value = await getBloodPressureDetails(email);
  getStoredBloodPsr.value = value;
  getStoredBloodPsr.notifyListeners();
}

Future<void> strdGetPulse(String email) async {
  final value = await getPulseDetails(email);
  getStoredPulse.value = value;
  getStoredPulse.notifyListeners();
}

Future<void> strdGetSugarLevel(String email) async {
  final value = await getSugarLevelDeatails(email);
  getStoredHeight.value = value;
  getStoredHeight.notifyListeners();
}

Future<void> strdGetWeight(String email) async {
  final value = await getWeightStrDetails(email);
  getStoredWeight.value = value;
  getStoredWeight.notifyListeners();
}
