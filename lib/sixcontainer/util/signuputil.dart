import 'package:flutter/material.dart';

class TextFormfld extends StatelessWidget {
  const TextFormfld(
      {super.key,
      required this.icons1,
      required this.label,
      required this.controller,
      required this.validator,
      this.icons2,
      this.obscure = false,
      this.onpress,
      this.keybrd});
  final IconData icons1;
  final IconData? icons2;
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscure;
  final void Function()? onpress;
  final TextInputType? keybrd;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        cursorColor: Colors.black,
        obscureText: obscure,
        controller: controller,
        validator: validator,
        keyboardType: keybrd,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: onpress,
            icon: Icon(icons2),
          ),
          prefixIcon: Icon(
            icons1,
            color: const Color(0xff7a73e7),
          ),
          label: Text(label),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, Color Color, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: Color,
    duration: const Duration(seconds: 5),
  ));
}
