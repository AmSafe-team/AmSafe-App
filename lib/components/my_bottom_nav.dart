import 'package:amsafe/main.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyBottomNav extends StatelessWidget {
  final void Function(int)? onTabChanges;
  MyBottomNav({super.key, required this.onTabChanges});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(0.8.h),
        child: GNav(
          color: Colors.grey[400],
          activeColor: Theme.of(context).whiteText,
          tabBackgroundColor: Theme.of(context).mainColor,
          gap: 6,
          mainAxisAlignment: MainAxisAlignment.center,
          onTabChange: (value) => onTabChanges!(value),
          padding: EdgeInsets.all(2.5.h),
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
