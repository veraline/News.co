import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/colors.dart';
import '../models/text_box.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<void> editField(String field) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Profile Page',
          style: GoogleFonts.roboto(
            color: myColor,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Icon(
            Icons.person,
            size: 72,
          ),
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700]),
          ),
          const SizedBox(
            height: 50,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'My Details',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),

          //profile
          MyTextBox(
            text: currentUser.email!
                .split('@')
                .first
                .replaceAll(RegExp(r'[0-9]'), ''),
            sectionName: 'username',
            onPressed: () => editField('username'),
          ),

          MyTextBox(
            text: 'empty bio',
            sectionName: 'bio',
            onPressed: () => editField('bio'),
          )
        ],
      ),
    );
  }
}
