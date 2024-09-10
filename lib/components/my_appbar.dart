import 'package:amsafe/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar my_appbar(BuildContext context) {
  return AppBar(
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
    title: Center(
      child: Text(
        "AmSafe",
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).mainColor,
        ),
      ),
    ),
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
      ),
    ],
  );
}
