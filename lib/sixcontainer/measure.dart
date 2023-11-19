import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/model/bpmodel.dart';
import 'package:healthcare/profilepge.dart';
import 'package:healthcare/sixcontainer/measure_util/bp.dart';
import 'package:healthcare/sixcontainer/measure_util/pulse.dart';
import 'package:intl/intl.dart';

class MeasurePge extends StatefulWidget {
  const MeasurePge({super.key});

  @override
  State<MeasurePge> createState() => _MeasurePgeState();
}

List<BloodPressureModel> getStoredBloodPsr = [];
var formate = DateFormat('dd/MM/yyyy');

class _MeasurePgeState extends State<MeasurePge> {
  @override
  void initState() {
    strGetFtrBP(email!);
    super.initState();
  }

  void strGetFtrBP(String email) async {
    final value = await getBloodPressureDetails(email);
    setState(() {
      getStoredBloodPsr = value;
    });
    print(getStoredBloodPsr);
  }

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
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemBuilder: (BuildContext, int index) {
              BloodPressureModel singleValue = getStoredBloodPsr[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BloodPressurePage(),
                  ));
                },
                child: ListTile(
                  title: Text(
                    '${singleValue.bloodmmcount.toString()}/${singleValue.bloodHgCount.toString()}',
                  ),
                  subtitle: Text('${formate.format(singleValue.date)}'),
                ),
              );
            },
            itemCount: getStoredBloodPsr.length,
          ))
        ],
      )),
    );
  }
}
