import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare/sixcontainer/measure_util/bp.dart';
import 'package:healthcare/sixcontainer/measure_util/pulse.dart';

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
          title: const Text("MEASUREMENTS"),
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
                backgroundColor: Colors.amber,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BloodPressurePage(),
                  ));
                }),
            SpeedDialChild(
                child: const Icon(Icons.add_box_rounded),
                label: "PULSE",
                backgroundColor: Colors.amber,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PulsePage(),
                  ));
                }),
            SpeedDialChild(
              child: const Icon(Icons.expand),
              label: "HIGHT",
              backgroundColor: Colors.amber,
            ),
            SpeedDialChild(
              child: const Icon(Icons.settings_accessibility_outlined),
              label: "WEIGHT",
              backgroundColor: Colors.amber,
            ),
            SpeedDialChild(
              child: const Icon(Icons.water_drop_rounded),
              label: "SUGAR LEVEL",
              backgroundColor: Colors.amber,
            ),
          ],
        ));
  }
}
