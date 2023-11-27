import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/model/pulsemodel.dart';
import 'package:healthcare/profilepge.dart';
import 'package:healthcare/sixcontainer/addremainder.dart';
import 'package:intl/intl.dart';

class PulsePage extends StatefulWidget {
  const PulsePage({super.key});

  @override
  State<PulsePage> createState() => _PulsePageState();
}

//new5
final GlobalKey<FutureBuilderclassState> _futureBuilderKey =
    GlobalKey<FutureBuilderclassState>();

class _PulsePageState extends State<PulsePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff7a73e7),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          "PULSE",
          style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    'assets/images/DocPulChk.png',
                    fit: BoxFit.fill,
                  )),
            ),
            const SizedBox(height: 40),
            Center(
              child: SizedBox(
                  height: 400,
                  child: FutureBuilderclass(
                    //new2
                    //new6
                    key: _futureBuilderKey,
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
                  // ShowBottumSheet.show(context, size);
                  ShowBottumSheetTwo.show(context, size);
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
class FutureBuilderclass extends StatefulWidget {
  const FutureBuilderclass({Key? key}) : super(key: key);

  @override
  FutureBuilderclassState createState() => FutureBuilderclassState();
}

class FutureBuilderclassState extends State<FutureBuilderclass> {
  late Future<List<Map<String, dynamic>>> future;

  @override
  void initState() {
    super.initState();
//new4
    future = graphPulseFunc();
  }

//new3
  // Method to trigger a rebuild of the FutureBuilder
  void refresh() {
    setState(() {
      future = graphPulseFunc();
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
          return BarChartSample3(passingPulseVal: value);
        }
      },
    );
  }
}

class BarChartSample3 extends StatefulWidget {
  final List<Map<String, dynamic>> passingPulseVal;
  BarChartSample3({super.key, required this.passingPulseVal});
  Color leftBarColor = Colors.red;
  final Color rightBarColor = Colors.green;
  final Color avgColor = Colors.blue;

  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;
  final Pulsetitles = <String>[];

  @override
  void initState() {
    super.initState();
    List<BarChartGroupData> pulseItems = [];
    for (var i = 0; i < widget.passingPulseVal.length; i++) {
      double value = (widget.passingPulseVal[i]['count']).toDouble() / 10;
      print(value);
      if (value > 8) {
        widget.leftBarColor = Colors.red;
      } else if (value == 7.2) {
        widget.leftBarColor = Colors.green;
      } else if (value < 8) {
        widget.leftBarColor = Colors.yellow;
      }
      setState(() {
        pulseItems.add(makeGroupData(i, value));
      });
    }
    rawBarGroups = pulseItems;
    showingBarGroups = rawBarGroups;
    for (var i in widget.passingPulseVal) {
      setState(() {
        Pulsetitles.add(i['date']);
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
    } else if (value == 7) {
      text = 'Nm';
    } else if (value == 14) {
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
      Pulsetitles[value.toInt()],
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

Future<List<Map<String, dynamic>>> graphPulseFunc() async {
  List<Map<String, dynamic>> getedPulseGraphVal = [];
  final values = await getPulseDetails(email!);
  for (var i in values) {
    getedPulseGraphVal
        .add({'date': '${i.date.day}/${i.date.month}', 'count': i.rateOfpulse});
  }
  return getedPulseGraphVal;
}

class ShowBottumSheetTwo extends StatefulWidget {
  ShowBottumSheetTwo({
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
          return ShowBottumSheetTwo(
            size: size,
          );
        });
  }

  @override
  State<ShowBottumSheetTwo> createState() => _ShowBottumSheetTwoState();
}

var formate = DateFormat('dd MMM yyyy');
DateTime selectedDate = DateTime.now();
DateTime selectedTime = DateTime.now();
List<PulseClassModel> storeFtrGetPulse = [];

final TextEditingController pulseEditingController = TextEditingController();
final formkey = GlobalKey<FormState>();

class _ShowBottumSheetTwoState extends State<ShowBottumSheetTwo> {
  @override
  void initState() {
    displayStoredPulseDtls();
    super.initState();
  }

  void displayStoredPulseDtls() async {
    final value = await getPulseDetails(email!);
    setState(() {
      storeFtrGetPulse = value;
    });
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
            // const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 45, right: 45),
              child: SizedBox(
                height: 44,
                child: Form(
                  key: formkey,
                  child: TextFormField(
                    controller: pulseEditingController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Pulse rate";
                      } else if (value.length >= 50 && value.length <= 150) {
                        return "you enterd the pulse rate";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "Enter Pulse Rate",
                          style: GoogleFonts.poppins(),
                        )),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
                width: widget.size.width - 30,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                      Color(0xff7a73e7),
                    )),
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        final pulse = PulseClassModel(
                            date: selectedDate,
                            time: selectedTime,
                            rateOfpulse: int.parse(pulseEditingController.text),
                            email: email!);
                        for (var i in storeFtrGetPulse) {
                          if (DateFormat.jm().format(i.time) ==
                                  DateFormat.jm().format(pulse.time) &&
                              formate.format(i.date) ==
                                  formate.format(i.date)) {
                            showSnackBarImage(
                                context, "Already Exit", Colors.red);
                            Navigator.pop(context);
                            return;
                          }
                        }
                        await addPulseModelDetails(pulse, context);
                        //new7
                        final futureBuilderState =
                            _futureBuilderKey.currentState;
                        if (futureBuilderState != null) {
                          futureBuilderState.refresh();
                        }
                        Navigator.pop(context);
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
