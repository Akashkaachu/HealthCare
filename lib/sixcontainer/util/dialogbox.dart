import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final controller;
  void Function()? onSave;
  void Function()? onCancel;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue.shade100,
      content: Container(
        height: 150,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Add a new diary"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyBotton(text: "Save", onPressed: onSave),
              MyBotton(text: "Cancel ", onPressed: onCancel)
            ],
          )
        ]),
      ),
    );
  }
}

class MyBotton extends StatelessWidget {
  final String text;
  void Function()? onPressed;
  MyBotton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
