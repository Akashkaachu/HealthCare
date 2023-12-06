// ignore_for_file: prefer_typing_uninitialized_variables, sized_box_for_whitespace, must_be_immutable

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
  final diaryKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue.shade100,
      content: Container(
        height: 150,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Form(
            key: diaryKey,
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter your Diary";
                } else if (value.length > 30) {
                  return "Enter only less than 40 words";
                } else {
                  return null;
                }
              },
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Add a new diary"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyBotton(text: "Cancel ", onPressed: onCancel),
              MyBotton(
                text: "Save",
                onPressed: () {
                  if (diaryKey.currentState!.validate()) {
                    onSave!();
                  }
                },
              ),
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
