import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/model/heightmodel.dart';
import 'package:healthcare/profilepge.dart';
import 'package:intl/intl.dart';

class SugarLevelMeasurement extends StatefulWidget {
  const SugarLevelMeasurement({super.key});

  @override
  State<SugarLevelMeasurement> createState() => _SugarLevelMeasurement();
}

final GlobalKey<FutureBuilderclass3State> _futureBuilderKeyHeight =
    GlobalKey<FutureBuilderclass3State>();

class _SugarLevelMeasurement extends State<SugarLevelMeasurement> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("SUGAR LEVEL"),
        centerTitle: true,
        backgroundColor: const Color(0xff7a73e7),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                "assets/images/sugarlevelimage.png",
                height: size.height / 2 - 40,
                width: size.width,
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: SizedBox(
                  height: 400,
                  child: FutureBuilderclass3(
                    key: _futureBuilderKeyHeight,
                  )),
            ),
            SizedBox(
              width: size.width - 50,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                  Color(0xff7a73e7),
                )),
                onPressed: () {
                  ShowBottumHeightSheet.show(context, size);
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
          ],
        ),
      ),
    );
  }
} //new1

class FutureBuilderclass3 extends StatefulWidget {
  const FutureBuilderclass3({Key? key}) : super(key: key);

  @override
  FutureBuilderclass3State createState() => FutureBuilderclass3State();
}

class FutureBuilderclass3State extends State<FutureBuilderclass3> {
  late Future<List<Map<String, dynamic>>> future;

  @override
  void initState() {
    super.initState();
//new4
    future = graphHeight();
  }

//new3
  // Method to trigger a rebuild of the FutureBuilder
  void refresh() {
    setState(() {
      future = graphHeight();
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
          return BarChartSample4(passingHeightVal: value);
        }
      },
    );
  }
}

class BarChartSample4 extends StatefulWidget {
  BarChartSample4({super.key, required this.passingHeightVal});
  final List<Map<String, dynamic>> passingHeightVal;
  Color leftBarColor = Colors.yellow;
  final Color rightBarColor = Colors.green;
  final Color avgColor = Colors.blue;

  @override
  State<StatefulWidget> createState() => BarChartSample4State();
}

class BarChartSample4State extends State<BarChartSample4> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;
  final HeighttTitles = <String>[];

  @override
  void initState() {
    super.initState();
    List<BarChartGroupData> heightItems = [];
    for (var i = 0; i < widget.passingHeightVal.length; i++) {
      double value = (widget.passingHeightVal[i]['items']).toDouble() / 15;
      if (value > 8) {
        widget.leftBarColor = Colors.green;
      } else if (value < 8) {
        widget.leftBarColor = Colors.red;
      }
      setState(() {
        heightItems.add(makeGroupData(i, value));
      });
    }
    rawBarGroups = heightItems;
    showingBarGroups = rawBarGroups;
    for (var i in widget.passingHeightVal) {
      setState(() {
        HeighttTitles.add(i['date']);
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
                    touchCallback: (FlTouchEvent event, response) {},
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
    } else if (value == 8) {
      text = '70 mm/Dl';
    } else if (value == 15) {
      text = '100 mm/Dl ';
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
      HeighttTitles[value.toInt()],
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

Future<List<Map<String, dynamic>>> graphHeight() async {
  List<Map<String, dynamic>> getedHeightVal = [];
  final values = await getHeightDeatails(email!);
  for (var i in values) {
    getedHeightVal.add(
        {'date': '${i.date.day}/${i.date.month}', 'items': i.textController});
  }
  return getedHeightVal;
}

class ShowBottumHeightSheet extends StatefulWidget {
  ShowBottumHeightSheet({
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
          return ShowBottumHeightSheet(
            size: size,
          );
        });
  }

  @override
  State<ShowBottumHeightSheet> createState() => _ShowBottumHeightSheetState();
}

var formate = DateFormat('dd MMM yyyy');

DateTime selectedDate = DateTime.now();
DateTime selectedTime = DateTime.now();
List<HeightModelClass> storeFtrGetHeight = [];

final TextEditingController heightEditingController = TextEditingController();

class _ShowBottumHeightSheetState extends State<ShowBottumHeightSheet> {
  @override
  void initState() {
    getHeightDtls();
    super.initState();
  }

  void getHeightDtls() async {
    final value = await getHeightDeatails(email!);
    {
      setState(() {
        storeFtrGetHeight = value;
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
                  controller: heightEditingController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Sugar level in   mg/Dl")),
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
                      final height = HeightModelClass(
                          date: selectedDate,
                          time: selectedTime,
                          email: email!,
                          textController:
                              double.parse(heightEditingController.text));

                      for (var i in storeFtrGetHeight) {
                        if (DateFormat.jm().format(i.time) ==
                                DateFormat.jm().format(height.time) &&
                            formate.format(i.date) ==
                                formate.format(height.date)) {
                          showSnackBarImage(
                              context, "Already Exit", Colors.red);
                          Navigator.pop(context);
                          return;
                        }
                      }
                      await addHeightDetails(height, context);
                      //new7
                      _futureBuilderKeyHeight.currentState!.refresh();
                      final futureBuilderState =
                          _futureBuilderKeyHeight.currentState;
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
