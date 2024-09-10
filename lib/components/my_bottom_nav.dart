import 'package:amsafe/main.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNav extends StatelessWidget {
  final void Function(int)? onTabChanges;
  MyBottomNav({super.key, required this.onTabChanges});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GNav(
          color: Colors.grey[400],
          activeColor: Theme.of(context).whiteText,
          tabBackgroundColor: Theme.of(context).mainColor,
          gap: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          onTabChange: (value) => onTabChanges!(value),
          padding: EdgeInsets.all(15),
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.chat,
              text: 'Chat',
            ),
            GButton(
              icon: Icons.call,
              text: 'Contact',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
