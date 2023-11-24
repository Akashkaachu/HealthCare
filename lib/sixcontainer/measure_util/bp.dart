import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/model/bpmodel.dart';
import 'package:healthcare/profilepge.dart';
import 'package:intl/intl.dart';

class BloodPressurePage extends StatefulWidget {
  BloodPressurePage({Key? key}) : super(key: key);

  @override
  State<BloodPressurePage> createState() => _BloodPressurePageState();
} //new5

final GlobalKey<FutureBuilderclass2State> _futureBuilderKey2 =
    GlobalKey<FutureBuilderclass2State>();

class _BloodPressurePageState extends State<BloodPressurePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("BLOOD PRESSURE"),
        centerTitle: true,
        backgroundColor: const Color(0xff7a73e7),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    'assets/images/DocCheckBp.png',
                    fit: BoxFit.fill,
                    height: size.height - 550,
                    width: size.width - 450,
                  )),
            ),
            const SizedBox(height: 40),
            Center(
              child: SizedBox(
                  height: 400,
                  child: FutureBuilderclass2(
                    //new2
                    //new6
                    key: _futureBuilderKey2,
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
                  ShowBottumSheet.show(context, size);
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
}

//new1
class FutureBuilderclass2 extends StatefulWidget {
  const FutureBuilderclass2({Key? key}) : super(key: key);

  @override
  FutureBuilderclass2State createState() => FutureBuilderclass2State();
}

class FutureBuilderclass2State extends State<FutureBuilderclass2> {
  late Future<List<Map<String, dynamic>>> future;

  @override
  void initState() {
    super.initState();
//new4
    future = graphFutureFun();
  }

//new3
  // Method to trigger a rebuild of the FutureBuilder
  void refresh() {
    setState(() {
      future = graphFutureFun();
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
          return BarChartSample2(passingGraphVal: value);
        }
      },
    );
  }
}

class BarChartSample2 extends StatefulWidget {
  final List<Map<String, dynamic>> passingGraphVal;
  BarChartSample2({super.key, required this.passingGraphVal});
  Color leftBarColor = Colors.red;

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final double width = 9;
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;
  final titles = <String>[];
  @override
  void initState() {
    super.initState();
    List<BarChartGroupData> items = [];

    for (var i = 0; i < widget.passingGraphVal.length; i++) {
      double value = (widget.passingGraphVal[i]['mm']).toDouble() / 15;
      if (value > 12) {
        widget.leftBarColor = Colors.red;
      } else if (value == 12) {
        widget.leftBarColor = Colors.yellow;
      } else if (value < 12) {
        widget.leftBarColor = Colors.green;
      }
      setState(() {
        items.add(makeGroupData(i, value));
      });
    }
    rawBarGroups = items;
    showingBarGroups = rawBarGroups;

    for (var i in widget.passingGraphVal) {
      setState(() {
        titles.add(i['date']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: BarChart(
              BarChartData(
                maxY: 20,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.grey,
                    getTooltipItem: (a, b, c, d) => null,
                  ),
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
                      reservedSize: 45,
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
      text = 'Nm';
    } else if (value == 15) {
      text = 'Hg';
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
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 2,
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
}

late int mm;
late int Hg;

class BloodPressureScaleItem extends StatefulWidget {
  final String label;
  final int initialValue;
  final double scaleFactor;
  final int secondInitialValue;

  BloodPressureScaleItem({
    required this.label,
    required this.initialValue,
    required this.scaleFactor,
    required this.secondInitialValue,
  });

  @override
  _BloodPressureScaleItemState createState() => _BloodPressureScaleItemState();
}

class _BloodPressureScaleItemState extends State<BloodPressureScaleItem> {
  @override
  void initState() {
    super.initState();
    mm = widget.initialValue;
    Hg = widget.secondInitialValue;
  }

  void _incrementmmValue() {
    setState(() {
      mm++;
    });
  }

  void _decrementmmValue() {
    setState(() {
      mm--;
    });
  }

  void _incrementHgValue() {
    setState(() {
      Hg++;
    });
  }

  void _decrementHgValue() {
    setState(() {
      Hg--;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    var sizedBox = Column(
      children: [
        Text(
          widget.label,
          style: TextStyle(fontSize: 16.0 * widget.scaleFactor),
        ),
        Row(
          children: [
            GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! > 0) {
                  // Swiping to the right, decrement value
                  _decrementmmValue();
                } else if (details.primaryDelta! < 0) {
                  // Swiping to the left, increment value
                  _incrementmmValue();
                }
              },
              child: Text(
                mm.toString(),
                style: TextStyle(
                  fontSize: 24.0 * widget.scaleFactor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '/',
              style: TextStyle(
                fontSize: 24.0 * widget.scaleFactor,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (details.primaryDelta! > 0) {
                  // Swiping to the right, decrement value
                  _decrementHgValue();
                } else if (details.primaryDelta! < 0) {
                  // Swiping to the left, increment value
                  _incrementHgValue();
                }
              },
              child: Text(
                Hg.toString(),
                style: TextStyle(
                  fontSize: 24.0 * widget.scaleFactor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
    return sizedBox;
  }
}

Future<List<Map<String, dynamic>>> graphFutureFun() async {
  List<Map<String, dynamic>> getedGraphVal = [];
  final values = await getBloodPressureDetails(email!);
  for (var i in values) {
    getedGraphVal.add({
      'date': '${i.date.day}/${i.date.month}',
      'mm': i.bloodmmcount,
      'hg': i.bloodHgCount
    });
  }
  return getedGraphVal;
}

class ShowBottumSheet extends StatefulWidget {
  ShowBottumSheet({
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
          return ShowBottumSheet(
            size: size,
          );
        });
  }

  @override
  State<ShowBottumSheet> createState() => _ShowBottumSheetState();
}

var formate = DateFormat('dd MMM yyyy');

DateTime selectedDate = DateTime.now();
DateTime selectedTime = DateTime.now();
List<BloodPressureModel> previousRecord = [];

class _ShowBottumSheetState extends State<ShowBottumSheet> {
  @override
  void initState() {
    getBloodPressureDtls();
    super.initState();
  }

  void getBloodPressureDtls() async {
    final value = await getBloodPressureDetails(email!);
    {
      setState(() {
        previousRecord = value;
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    BloodPressureScaleItem(
                        label: 'Blood Pressure in mmHg ',
                        initialValue: 120,
                        secondInitialValue: 80,
                        scaleFactor: 1.2),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
                width: widget.size.width - 30,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                      Color(0xff7a73e7),
                    )),
                    onPressed: () async {
                      // print(email);
                      if (mm >= 90 && Hg >= 60 && mm <= 180 && Hg <= 120) {
                        final blood = BloodPressureModel(
                            date: selectedDate,
                            time: selectedTime,
                            bloodHgCount: Hg,
                            bloodmmcount: mm,
                            email: email!);
                        for (var i in previousRecord) {
                          if (DateFormat.jm().format(i.time) ==
                                  DateFormat.jm().format(blood.time) &&
                              formate.format(i.date) ==
                                  formate.format(blood.date)) {
                            showSnackBarImage(
                                context, "Already Exit", Colors.red);
                            Navigator.pop(context);
                            return;
                          }
                        }
                        await addBloodPressureDetails(blood, context);
                        //new7
                        final futureBuilderState =
                            _futureBuilderKey2.currentState;
                        if (futureBuilderState != null) {
                          futureBuilderState.refresh();
                        }
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                        showSnackBarImage(
                            context, "Invalid Blood Pressure", Colors.red);
                      }
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
