import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/model/bpmodel.dart';
import 'package:healthcare/model/pulsemodel.dart';
import 'package:healthcare/profilepge.dart';
import 'package:intl/intl.dart';

class MeasurementDisPage extends StatefulWidget {
  final String appText;
  final String searchBar;
  const MeasurementDisPage(
      {super.key, required this.appText, required this.searchBar});

  @override
  State<MeasurementDisPage> createState() => _MeasurementDisPageState();
}

TextEditingController searchEditingController = TextEditingController();

class _MeasurementDisPageState extends State<MeasurementDisPage> {
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
              ? FutureBuilder<List<BloodPressureModel>>(
                  future: getBloodPressureDetails(email!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error');
                    } else {
                      List<BloodPressureModel> bloodPrsrList = snapshot.data!;
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
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            BloodPressureModel bpModel = bloodPrsrList[index];
                            String formattedDate =
                                DateFormat('dd MMM yyyy').format(bpModel.date);
                            return ListTile(
                              title: Text(
                                  "${bpModel.bloodmmcount.toString()}/${bpModel.bloodHgCount} mmHg"),
                              subtitle: Text(formattedDate),
                            );
                          },
                          itemCount: bloodPrsrList.length,
                        ),
                      );
                    }
                  },
                )
              : Container(),
          widget.appText == 'PULSE'
              ? FutureBuilder<List<PulseClassModel>>(
                  future: getPulseDetails(email!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error');
                    } else {
                      List<PulseClassModel> bloodPrsrList = snapshot.data!;
                      if (searchEditingController.text.isNotEmpty) {
                        bloodPrsrList = bloodPrsrList
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
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            PulseClassModel pulseModel = bloodPrsrList[index];
                            String formattedDate = DateFormat('dd MMM yyyy')
                                .format(pulseModel.date);
                            return ListTile(
                              title: Text(
                                  "${pulseModel.rateOfpulse.toString()} beats/min"),
                              subtitle: Text(formattedDate),
                            );
                          },
                          itemCount: bloodPrsrList.length,
                        ),
                      );
                    }
                  },
                )
              : Container(),
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