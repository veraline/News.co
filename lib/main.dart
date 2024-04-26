import 'package:flutter/material.dart';
import 'package:new_app/Pages/Authentication-Pages/auth_page.dart';
import 'package:new_app/Pages/Authentication-Pages/login_page.dart';
import 'package:new_app/Pages/discover.dart';
import 'package:new_app/Pages/home_page.dart';
import 'package:new_app/models/mainController.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
