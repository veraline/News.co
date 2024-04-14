import 'package:flutter/material.dart';
class MyTextField extends StatelessWidget {
  final controller;
  final hinttext;
  final icon;
  final obsecureText;
  const MyTextField({ required this.obsecureText, required this.controller, required this.icon, required this.hinttext, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
            prefixIcon: icon,
            prefixIconColor: Colors.grey.shade500,
            filled: true,
            fillColor: Colors.grey.shade200,
            hintText: hinttext,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)
            )

        ),
      ),
    );
  }
}
