import 'package:amsafe/components/my_appbar.dart';
import 'package:amsafe/widget/app_emergency.dart';
import 'package:amsafe/widget/app_live_safe.dart';
import 'package:amsafe/widget/app_sos_button.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  final List<Contact> selectedContacts;
  const HomePage({super.key, required this.selectedContacts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //! appbar
      appBar: my_appbar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! Centering the following part
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Need Help ?",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Press Button",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  //! SOS Button
                  AppSosButton(selectedContacts: selectedContacts),
                ],
              ),
            ),
            SizedBox(height: 20),
            //! Emergency Contact
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Emergency Contact",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 10),
            //! Emergency cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: emergencyCardList(context),
            ),
            SizedBox(height: 10),
            //! Live safe
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Explore LiveSafe",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 10),
            //! Emergency cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: liveSafeChips(context),
            ),
          ],
        ),
      ),
    );
  }
}
