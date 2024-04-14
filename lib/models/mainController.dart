import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:new_app/Pages/saved_page.dart';
import '../Pages/discover.dart';
import '../Pages/home_page.dart';
import '../Pages/profile_page.dart';
import 'colors.dart';

class MainControllerPage extends StatefulWidget {
  const MainControllerPage({Key? key}) : super(key: key);

  @override
  State<MainControllerPage> createState() => _MainControllerPageState();
}

class _MainControllerPageState extends State<MainControllerPage> {

  int _selectedIndex = 0;

  List<Widget> pages = [
    const HomePage(),
    const DiscoverPage(),
    const SavedPage(),
     ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    print(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: IndexedStack(
      //   index: _selectedIndex,
      //   children: pages,
      // ),
      body: pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
          onTabChange: _onItemTapped,
          padding: const EdgeInsets.all(16),
          style: GnavStyle.google,
          haptic: true,
          // haptic feedback
          tabBorderRadius: 20,
          curve: Curves.easeOutExpo,
          // tab animation curves
          duration: const Duration(milliseconds: 900),
          // tab animation duration
          activeColor: Colors.white,
          tabBackgroundColor: myColor,
          gap: 8,
          tabs: const [
            GButton(
              text: 'Home',
              textColor: Colors.white,
              icon: Icons.home,
              iconColor: myColor,
            ),
            GButton(
              text: 'Discover',
              textColor: Colors.white,
              icon: Icons.egg_alt_rounded,
              iconColor: myColor,
            ),
            GButton(
              text: 'Saved',
              textColor: Colors.white,
              icon: Icons.bookmark,
              iconColor: myColor,
            ),
            GButton(
              text: 'Profile',
              textColor: Colors.white,
              icon: Icons.person,
              iconColor: myColor,
            ),
          ],
        ),
      ),
    );
  }
}
