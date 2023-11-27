import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/model/weightmodel.dart';
import 'package:healthcare/profilepge.dart';
import 'package:healthcare/sixcontainer/addremainder.dart';
import 'package:intl/intl.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({super.key});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

final GlobalKey<FutureBuilderclass4State> _futureBuilderKeyWeight =
    GlobalKey<FutureBuilderclass4State>();

class _WeightPageState extends State<WeightPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("WEIGHT"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xff7a73e7),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                "assets/images/weightmeasuring.png",
                height: size.height / 2 - 40,
              )),
          const SizedBox(height: 40),
          Center(
            child: SizedBox(
              height: 400,
              child: FutureBuilderclass4(
                key: _futureBuilderKeyWeight,
              ),
            ),
          ),
          SizedBox(
            width: size.width - 50,
            child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                Color(0xff7a73e7),
              )),
              onPressed: () {
                ShowBottumWeightSheet.show(context, size);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add),
                  const SizedBox(width: 4),
                  Text(
                    " Add Record",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
} //new1

class FutureBuilderclass4 extends StatefulWidget {
  const FutureBuilderclass4({Key? key}) : super(key: key);

  @override
  FutureBuilderclass4State createState() => FutureBuilderclass4State();
}

class FutureBuilderclass4State extends State<FutureBuilderclass4> {
  late Future<List<Map<String, dynamic>>> future;

  @override
  void initState() {
    super.initState();
//new4
    future = graphWeight();
  }

//new3
  // Method to trigger a rebuild of the FutureBuilder
  void refresh() {
    setState(() {
      future = graphWeight();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text("error");
        } else {
          final value = snapshot.data!;
          return BarChartSample5(passingWeightVal: value);
        }
      },
    );
  }
}

class BarChartSample5 extends StatefulWidget {
  BarChartSample5({
    super.key,
    required this.passingWeightVal,
  });
  final List<Map<String, dynamic>> passingWeightVal;
  Color leftBarColor = Colors.yellow;
  final Color rightBarColor = Colors.green;
  final Color avgColor = Colors.blue;

  @override
  State<StatefulWidget> createState() => BarChartSample5State();
}

class BarChartSample5State extends State<BarChartSample5> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;
  final WeighttTitles = <String>[];

  @override
  void initState() {
    super.initState();
    List<BarChartGroupData> weightItems = [];
    for (var i = 0; i < widget.passingWeightVal.length; i++) {
      double value = (widget.passingWeightVal[i]['calorie']).toDouble() / 10;
      if (value > 8) {
        widget.leftBarColor = Colors.green;
      } else if (value < 8) {
        widget.leftBarColor = Colors.red;
      }
      setState(() {
        weightItems.add(makeGroupData(i, value));
      });
    }
    rawBarGroups = weightItems;
    showingBarGroups = rawBarGroups;
    for (var i in widget.passingWeightVal) {
      setState(() {
        WeighttTitles.add(i['date']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 38,
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 20,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.grey,
                      getTooltipItem: (a, b, c, d) => null,
                    ),
                    touchCallback: (FlTouchEvent event, response) {
                      //     if (response == null || response.spot == null) {
                      //       setState(() {
                      //         touchedGroupIndex = -1;
                      //         showingBarGroups = List.of(rawBarGroups);
                      //       });
                      //       return;
                      //     }

                      //     touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                      //     setState(() {
                      //       if (!event.isInterestedForInteractions) {
                      //         touchedGroupIndex = -1;
                      //         showingBarGroups = List.of(rawBarGroups);
                      //         return;
                      //       }
                      //       showingBarGroups = List.of(rawBarGroups);
                      //       if (touchedGroupIndex != -1) {
                      //         var sum = 0.0;
                      //         for (final rod
                      //             in showingBarGroups[touchedGroupIndex].barRods) {
                      //           sum += rod.toY;
                      //         }
                      //         final avg = sum /
                      //             showingBarGroups[touchedGroupIndex]
                      //                 .barRods
                      //                 .length;

                      //         showingBarGroups[touchedGroupIndex] =
                      //             showingBarGroups[touchedGroupIndex].copyWith(
                      //           barRods: showingBarGroups[touchedGroupIndex]
                      //               .barRods
                      //               .map((rod) {
                      //             return rod.copyWith(
                      //                 toY: avg, color: widget.avgColor);
                      //           }).toList(),
                      //         );
                      //       }
                      //     });
                      //   },
                      // ),
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value == 10) {
      text = '50 Weight';
    } else if (value == 19) {
      text = '110 Weight';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final Widget text = Text(
      WeighttTitles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}

Future<List<Map<String, dynamic>>> graphWeight() async {
  List<Map<String, dynamic>> getedWeightVal = [];
  final values = await getWeightStrDetails(email!);
  for (var i in values) {
    getedWeightVal.add(
        {'date': '${i.date.day}/${i.date.month}', 'calorie': i.controller});
  }
  return getedWeightVal;
}

class ShowBottumWeightSheet extends StatefulWidget {
  ShowBottumWeightSheet({
    super.key,
    required this.size,
  });
  final size;
  static show(BuildContext context, size) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        )),
        context: context,
        builder: (BuildContext context) {
          return ShowBottumWeightSheet(
            size: size,
          );
        });
  }

  @override
  State<ShowBottumWeightSheet> createState() => _ShowBottumWeightSheetState();
}

var formate = DateFormat('dd MMM yyyy');

DateTime selectedDate = DateTime.now();
DateTime selectedTime = DateTime.now();
List<WeightClassModel> storeFtrGetWeight = [];

final TextEditingController weightEditingController = TextEditingController();

class _ShowBottumWeightSheetState extends State<ShowBottumWeightSheet> {
  @override
  void initState() {
    getWeightDtls();
    super.initState();
  }

  void getWeightDtls() async {
    final value = await getWeightStrDetails(email!);
    {
      setState(() {
        storeFtrGetWeight = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Container(
        width: widget.size.width,
        child: Column(
          children: [
            const SizedBox(height: 80),
            SizedBox(
              width: widget.size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Choose Date",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 50),
                        Text(
                          "${formate.format(selectedDate)}",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      final DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(1980),
                          lastDate: DateTime(3000));
                      if (dateTime != null) {
                        setState(() {
                          selectedDate = dateTime;
                        });
                        print(selectedDate);
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: widget.size.width,
              height: ((widget.size.height / 2) / 2) / 2 - 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Choose Time     ",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 50),
                        Text(
                          // ignore: unnecessary_string_interpolations
                          "${DateFormat.jm().format(selectedTime)}",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      final TimeOfDay? timeOfDay = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(selectedTime),
                      );

                      if (timeOfDay != null) {
                        final DateTime selectedDateTime = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          timeOfDay.hour,
                          timeOfDay.minute,
                        );

                        setState(() {
                          selectedTime = selectedDateTime;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45, right: 45),
              child: SizedBox(
                height: 44,
                child: TextFormField(
                  controller: weightEditingController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Enter your Weight")),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Row(
            //       children: [
            //         BloodPressureScaleItem(
            //             label: 'h ',
            //             initialValue: 120,
            //             secondInitialValue: 80,
            //             scaleFactor: 1.2),
            //       ],
            //     ),
            //   ],
            // ),
            const SizedBox(height: 40),
            SizedBox(
                width: widget.size.width - 30,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                      Color(0xff7a73e7),
                    )),
                    onPressed: () async {
                      final weight = WeightClassModel(
                          date: selectedDate,
                          time: selectedTime,
                          controller:
                              double.parse(weightEditingController.text),
                          email: email!);
                      for (var i in storeFtrGetWeight) {
                        if (DateFormat.jm().format(i.time) ==
                                DateFormat.jm().format(weight.time) &&
                            formate.format(i.date) ==
                                formate.format(weight.date)) {
                          showSnackBarImage(
                              context, "Already Exit", Colors.red);
                          Navigator.pop(context);
                          return;
                        }
                      }
                      await addWeightDetails(weight, context);
                      //new7
                      _futureBuilderKeyWeight.currentState!.refresh();
                      final futureBuilderState =
                          _futureBuilderKeyWeight.currentState;
                      if (futureBuilderState != null) {
                        futureBuilderState.refresh();
                      }
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Save",
                    )))
          ],
        ),
      ),
    );
  }
}
