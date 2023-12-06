// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/model/bpmodel.dart';
import 'package:healthcare/model/heightmodel.dart';
import 'package:healthcare/model/pulsemodel.dart';
import 'package:healthcare/model/weightmodel.dart';
import 'package:healthcare/profilepge.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class MeasurementDisPage extends StatefulWidget {
  final String appText;
  final String searchBar;
  const MeasurementDisPage(
      {super.key, required this.appText, required this.searchBar});

  @override
  State<MeasurementDisPage> createState() => _MeasurementDisPageState();
}

ValueNotifier<List<BloodPressureModel>> getValueOfBP =
    ValueNotifier<List<BloodPressureModel>>([]);

ValueNotifier<List<PulseClassModel>> getValuesOFPulse =
    ValueNotifier<List<PulseClassModel>>([]);

ValueNotifier<List<WeightClassModel>> getValuesOfWeight =
    ValueNotifier<List<WeightClassModel>>([]);

ValueNotifier<List<HeightModelClass>> getValuesOfSugar =
    ValueNotifier<List<HeightModelClass>>([]);

TextEditingController searchEditingController = TextEditingController();

class _MeasurementDisPageState extends State<MeasurementDisPage> {
  @override
  void initState() {
    displayBPValueNoti(email!);
    displayPulseValueNoti(email!);
    dispalyWeightNoti(email!);
    displaySugarNoti(email!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.appText,
          style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff7a73e7),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
          child: Column(
        children: [
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                searchFuction(value);
              },
              controller: searchEditingController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.bloodtype_outlined,
                    color: Colors.red,
                  ),
                  label: Text(
                    widget.searchBar,
                    style: GoogleFonts.poppins(),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          widget.appText == 'BLOOD PRESSURE'
              ? ValueListenableBuilder(
                  valueListenable: getValueOfBP,
                  builder: (context, list, child) {
                    return FutureBuilder<List<BloodPressureModel>>(
                      future: getBloodPressureDetails(email!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text('Error');
                        } else {
                          List<BloodPressureModel> bloodPrsrList = list;
                          if (searchEditingController.text.isNotEmpty) {
                            bloodPrsrList = bloodPrsrList
                                .where((element) =>
                                    element.bloodmmcount
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchEditingController.text
                                            .toLowerCase()) ||
                                    DateFormat('dd MMM yyyy')
                                        .format(element.date)
                                        .toLowerCase()
                                        .contains(searchEditingController.text
                                            .toLowerCase()))
                                .toList();
                          }
                          return Expanded(
                            child: bloodPrsrList.isEmpty
                                ? SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        LottieBuilder.asset(
                                            "assets/animation/Animation - 1701342007210.json"),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    itemBuilder: (context, index) {
                                      BloodPressureModel bpModel =
                                          bloodPrsrList[index];
                                      String formattedDate =
                                          DateFormat('dd MMM yyyy')
                                              .format(bpModel.date);
                                      return InkWell(
                                        onLongPress: () {
                                          alertBP(context, bpModel);
                                        },
                                        child: ListTile(
                                          title: Text(
                                              "${bpModel.bloodmmcount.toString()}/${bpModel.bloodHgCount} mmHg"),
                                          subtitle: Text(formattedDate),
                                        ),
                                      );
                                    },
                                    itemCount: bloodPrsrList.length,
                                  ),
                          );
                        }
                      },
                    );
                  })
              : Container(),
          widget.appText == 'PULSE'
              ? ValueListenableBuilder(
                  valueListenable: getValuesOFPulse,
                  builder: (context, listBP, child) {
                    return FutureBuilder<List<PulseClassModel>>(
                      future: getPulseDetails(email!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text('Error');
                        } else {
                          List<PulseClassModel> pulseList = listBP;
                          if (searchEditingController.text.isNotEmpty) {
                            pulseList = pulseList
                                .where((element) =>
                                    element.rateOfpulse
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchEditingController.text
                                            .toLowerCase()) ||
                                    DateFormat('dd MMM yyyy')
                                        .format(element.date)
                                        .toLowerCase()
                                        .contains(searchEditingController.text
                                            .toLowerCase()))
                                .toList();
                          }
                          return Expanded(
                            child: pulseList.isEmpty
                                ? LottieBuilder.asset(
                                    "assets/animation/Animation - 1701342007210.json")
                                : ListView.builder(
                                    itemBuilder: (context, index) {
                                      PulseClassModel pulseModel =
                                          pulseList[index];
                                      String formattedDate =
                                          DateFormat('dd MMM yyyy')
                                              .format(pulseModel.date);
                                      return InkWell(
                                        onLongPress: () {
                                          alertPulse(context, pulseModel);
                                        },
                                        child: ListTile(
                                          title: Text(
                                              "${pulseModel.rateOfpulse.toString()} beats/min"),
                                          subtitle: Text(formattedDate),
                                        ),
                                      );
                                    },
                                    itemCount: pulseList.length,
                                  ),
                          );
                        }
                      },
                    );
                  })
              : Container(),
          widget.appText == 'WEIGHT'
              ? ValueListenableBuilder(
                  valueListenable: getValuesOfWeight,
                  builder: (context, ListWeight, child) {
                    return FutureBuilder<List<WeightClassModel>>(
                      future: getWeightStrDetails(email!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text("Error");
                        } else {
                          List<WeightClassModel> weightList = ListWeight;
                          if (searchEditingController.text.isNotEmpty) {
                            weightList = weightList
                                .where((element) =>
                                    element.controller
                                        .toInt()
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchEditingController.text
                                            .toLowerCase()) ||
                                    DateFormat('dd MMM yyyy')
                                        .format(element.date)
                                        .toLowerCase()
                                        .contains(searchEditingController.text
                                            .toLowerCase()))
                                .toList();
                          }
                          return Expanded(
                            child: weightList.isEmpty
                                ? LottieBuilder.asset(
                                    "assets/animation/Animation - 1701342007210.json")
                                : ListView.builder(
                                    itemBuilder: (context, index) {
                                      WeightClassModel weightModel =
                                          weightList[index];
                                      String formattedDate =
                                          DateFormat('dd MMM yyy')
                                              .format(weightModel.date);
                                      return InkWell(
                                        onLongPress: () {
                                          alertWeight(context, weightModel);
                                        },
                                        child: ListTile(
                                          title: Text(
                                              "${weightModel.controller.toInt().toString()} Kg."),
                                          subtitle: Text(formattedDate),
                                        ),
                                      );
                                    },
                                    itemCount: weightList.length,
                                  ),
                          );
                        }
                      },
                    );
                  })
              : Container(),
          widget.appText == 'SUGAR LEVEL'
              ? ValueListenableBuilder(
                  valueListenable: getValuesOfSugar,
                  builder: (context, ListSugar, child) {
                    return FutureBuilder(
                      future: getSugarLevelDeatails(email!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text("Error");
                        } else {
                          List<HeightModelClass> SugarList = ListSugar;
                          if (searchEditingController.text.isNotEmpty) {
                            SugarList = SugarList.where((element) =>
                                element.textController
                                    .toInt()
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchEditingController.text
                                        .toLowerCase()) ||
                                DateFormat('dd MMM yyyy')
                                    .format(element.date)
                                    .toLowerCase()
                                    .contains(searchEditingController.text
                                        .toLowerCase())).toList();
                          }
                          return Expanded(
                            child: SugarList.isEmpty
                                ? LottieBuilder.asset(
                                    "assets/animation/Animation - 1701342007210.json")
                                : ListView.builder(
                                    itemCount: SugarList.length,
                                    itemBuilder: (context, index) {
                                      HeightModelClass sugarModel =
                                          SugarList[index];
                                      String fomattedDate =
                                          DateFormat('dd MMM yyyy')
                                              .format(sugarModel.date);
                                      return InkWell(
                                        onLongPress: () {
                                          alertSugar(context, sugarModel);
                                        },
                                        child: ListTile(
                                          title: Text(
                                              "${sugarModel.textController} mg/Dl"),
                                          subtitle: Text(fomattedDate),
                                        ),
                                      );
                                    },
                                  ),
                          );
                        }
                      },
                    );
                  })
              : Container()
        ],
      )),
    );
  }

  void searchFuction(String value) {
    setState(() {
      searchEditingController.text = value;
      getBloodPressureDetails(email!);
    });
  }

  @override
  void dispose() {
    searchEditingController.clear();
    super.dispose();
  }
}

//AlertBox---BloodPressure
void alertBP(BuildContext context, BloodPressureModel BAndPModel) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete Bloodpressure"),
        content: Text(
          "Do you want to Delete BloodPressure?",
          style: GoogleFonts.poppins(color: Colors.redAccent),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff7a73e7),
              ),
              child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () async {
                final getBPKey = await getKeysOfBPFromHive(BAndPModel);
                await deleteBAndPModel(getBPKey);
                await displayBPValueNoti(BAndPModel.email);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff7a73e7),
              ),
              child: const Text("Delete"))
        ],
      );
    },
  );
}

//AlertBox---pulse
void alertPulse(BuildContext context, PulseClassModel pulseKeyModel) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Delete Pulse",
          style: GoogleFonts.poppins(),
        ),
        content: Text(
          "Do you want to delete Pulse?",
          style: GoogleFonts.poppins(color: Colors.red),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7a73e7)),
              child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () async {
                final pulseKey = await getKeyFormHive(pulseKeyModel);
                await deletePulseFromHive(pulseKey);
                await displayPulseValueNoti(pulseKeyModel.email);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7a73e7)),
              child: const Text("Delete"))
        ],
      );
    },
  );
}

//AlertBox---weight
void alertWeight(BuildContext context, WeightClassModel weightModel) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete Weight"),
        content: Text(
          "Do you Want to delete weight?",
          style: GoogleFonts.poppins(color: Colors.red),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7a73e7)),
              child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () async {
                final WeightKey = await getKeyOfWeight(weightModel);
                await deleteWeightFromHive(WeightKey);
                await dispalyWeightNoti(weightModel.email);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7a73e7)),
              child: const Text("Delete"))
        ],
      );
    },
  );
}

//AlertBox---sugar
alertSugar(BuildContext context, HeightModelClass sugarModel) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete the Sugar Level"),
        content: Text(
          "Do you want to Delete Sugar level?",
          style: GoogleFonts.poppins(color: Colors.red),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7a73e7)),
              child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () async {
                final sugarKey = await getKeyOfSugar(sugarModel);
                await deleteSugarFromHive(sugarKey);
                displaySugarNoti(email!);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7a73e7)),
              child: const Text("Delete"))
        ],
      );
    },
  );
}

Future<void> displayBPValueNoti(String email) async {
  final value = await getBloodPressureDetails(email);
  getValueOfBP.value = value;
  getValueOfBP.notifyListeners();
}

Future<void> displayPulseValueNoti(String email) async {
  final value = await getPulseDetails(email);
  getValuesOFPulse.value = value;
  getValuesOFPulse.notifyListeners();
}

Future<void> dispalyWeightNoti(String email) async {
  final value = await getWeightStrDetails(email);
  getValuesOfWeight.value = value;
  getValuesOfWeight.notifyListeners();
}

Future<void> displaySugarNoti(String email) async {
  final value = await getSugarLevelDeatails(email);
  getValuesOfSugar.value = value;
  getValuesOfSugar.notifyListeners();
}
