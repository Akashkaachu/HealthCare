// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// class AddBpPage extends StatefulWidget {
//   const AddBpPage({super.key});

//   @override
//   State<AddBpPage> createState() => _AddBpPageState();
// }

// class _AddBpPageState extends State<AddBpPage> {
//   DateTime selectedDate = DateTime.now();
//   DateTime selectedTime = DateTime.now();
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       appBar: AppBar(
//         title: const Text(
//           "New Record",
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.grey.shade200,
//         elevation: 0,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.black,
//             )),
//       ),
//       body: Container(
//         width: size.width,
//         child: Column(
//           children: [
//             SizedBox(
//               width: size.width,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.white,
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           "Choose Date",
//                           style: GoogleFonts.poppins(
//                               color: Colors.black,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         const SizedBox(width: 50),
//                         Text(
//                           "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
//                           style: GoogleFonts.poppins(
//                               color: Colors.black,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                     onPressed: () async {
//                       final DateTime? dateTime = await showDatePicker(
//                           context: context,
//                           initialDate: selectedDate,
//                           firstDate: DateTime(1980),
//                           lastDate: DateTime(3000));
//                       if (dateTime != null) {
//                         setState(() {
//                           selectedDate = dateTime;
//                         });
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: size.width,
//               height: ((size.height / 2) / 2) / 2 - 30,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.white,
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           "Choose Time     ",
//                           style: GoogleFonts.poppins(
//                               color: Colors.black,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         const SizedBox(width: 50),
//                         Text(
//                           // ignore: unnecessary_string_interpolations
//                           "${DateFormat.jm().format(selectedTime)}",
//                           style: GoogleFonts.poppins(
//                               color: Colors.black,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                     onPressed: () async {
//                       final TimeOfDay? timeOfDay = await showTimePicker(
//                         context: context,
//                         initialTime: TimeOfDay.fromDateTime(selectedTime),
//                       );

//                       if (timeOfDay != null) {
//                         final DateTime selectedDateTime = DateTime(
//                           selectedDate.year,
//                           selectedDate.month,
//                           selectedDate.day,
//                           timeOfDay.hour,
//                           timeOfDay.minute,
//                         );

//                         setState(() {
//                           selectedTime = selectedDateTime;
//                         });
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
