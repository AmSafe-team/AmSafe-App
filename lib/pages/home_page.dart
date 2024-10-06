import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:amsafe/widget/app_sos_button.dart';
import 'package:amsafe/utils/sized_box.dart';
import 'package:amsafe/widget/app_emergency.dart';
import 'package:amsafe/widget/app_live_safe.dart';

class HomePage extends StatelessWidget {
  final List<Contact> selectedContacts;
  const HomePage({super.key, required this.selectedContacts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  AppSosButton(selectedContacts: selectedContacts),
                ],
              ),
            ),
            sizedBoxHeight20,
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Text(
                "Emergency Contact",
                style: GoogleFonts.inter(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            sizedBoxHeight10,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: emergencyCardList(context),
            ),
            sizedBoxHeight10,
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Text(
                "Explore LiveSafe",
                style: GoogleFonts.inter(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            sizedBoxHeight10,
            Center(
              child: liveSafeChips(context),
            ),
          ],
        ),
      ),
    );
  }
}
