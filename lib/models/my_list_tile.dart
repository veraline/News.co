import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  MyListTile({required this.icon, required this.text, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        leading:Icon(
          icon, color: Colors.white,
        ),
        title: Text(text, style: GoogleFonts.roboto(color:Colors.white),),
        onTap: onTap,

      ),
    );
  }
}
