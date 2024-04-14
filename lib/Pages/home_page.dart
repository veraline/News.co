import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/Pages/profile_page.dart';
import 'package:new_app/Pages/saved_page.dart';
import 'package:new_app/models/colors.dart';
import 'package:new_app/widgets/home_details_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../widgets/home_details_page.dart';

import '../models/my_list_tile.dart';
import 'Authentication-Pages/login_page.dart';
import 'discover.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future<void> sighOut() async {
  //   try{
  //     Navigator.pop(context);
  //     showDialog(
  //         context: context,
  //         builder: (context) => const Center(
  //           child: CircularProgressIndicator(),
  //         ));
  //     await FirebaseAuth.instance.signOut();
  //     Navigator.pop(context);
  //
  //   } on FirebaseAuthException catch (e){
  //     print(e);
  //     showDialog(context: context, builder: (context) => AlertDialog(
  //       content: Text(e.message.toString().trim()),
  //     ));
  //   }
  // }

  Future<void> sighOut() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      await Future.delayed(const Duration(seconds: 2));

      await FirebaseAuth.instance.signOut();
      Navigator.pop(context);
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(e.message.toString().trim()),
        ),
      );
    }
  }

  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfilePage()));
  }

  void goToDiscoverPage() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DiscoverPage()));
  }

  Future<void> _refreshNews() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: myColor,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text(
                  'News.co',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 32),
                )),
            MyListTile(
              icon: Icons.home,
              text: 'H O M E',
              onTap: () => Navigator.pop(context),
            ),
            MyListTile(
              icon: Icons.egg_alt_rounded,
              text: 'D I S C O V E R',
              onTap: goToDiscoverPage,
            ),
            MyListTile(
              icon: Icons.person,
              text: 'P R O F I L E',
              onTap: goToProfilePage,
            ),
            Expanded(child: Container()),
            MyListTile(
              icon: Icons.logout,
              text: 'L O G O U T',
              onTap: sighOut,
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      appBar: AppBar(
        leading: null,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'News.co',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold, color: myColor),
            ),
            IconButton(
              onPressed: _refreshNews,
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
      ),
      body: HomePageDetails(
        onRefresh: _refreshNews,
      ),
    );
  }
}
