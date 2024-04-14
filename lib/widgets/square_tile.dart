import 'package:flutter/material.dart';

class SquareContainer extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const SquareContainer({super.key, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey.shade400
        ),
        child: Image.asset(imagePath, height: 40,),
      ),
    );
  }
}