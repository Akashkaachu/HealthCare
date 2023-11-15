// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:healthcare/sixcontainer/measure_util/bardata.dart';

// class MyBarGraph extends StatelessWidget {
//   final List weekilySummery;
//   const MyBarGraph({super.key, required this.weekilySummery});

//   @override
//   Widget build(BuildContext context) {
//     BarData myBarData = BarData(
//       sunAmount: weekilySummery[0],
//       monAmount: weekilySummery[1],
//       tueAmount: weekilySummery[2],
//       wedAmount: weekilySummery[3],
//       thurAmount: weekilySummery[4],
//       friAmount: weekilySummery[5],
//       satAmount: weekilySummery[6],
//     );
//     myBarData.initializaBarData();
//     return BarChart(BarChartData(
//         maxY: 200,
//         minY: 0,
//         // gridData: const FlGridData(show: false),
//         // borderData: FlBorderData(show: false),
//         // titlesData: const FlTitlesData(
//         //     show: true,
//         //     topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
//         barGroups: myBarData.barData
//             .map((data) => BarChartGroupData(x: 10, barRods: [
//                   BarChartRodData(
//                       toY: data.y,
//                       color: Colors.amber,
//                       borderRadius: BorderRadius.circular(3),
//                       backDrawRodData: BackgroundBarChartRodData(
//                           show: true, toY: 100, color: Colors.grey[200]))
//                 ]))
//             .toList()));
//   }
// }
