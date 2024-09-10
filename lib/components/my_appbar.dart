import 'package:amsafe/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

AppBar my_appbar(BuildContext context) {
  return AppBar(
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
    title: Text(
      "AmSafe",
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).mainColor,
      ),
    ),
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.menu_outlined),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          color: Colors.black,
          iconSize: 3.h,
        );
      },
    ),
  );
}
