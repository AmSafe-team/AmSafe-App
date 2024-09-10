import 'package:amsafe/main.dart';
import 'package:amsafe/utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyCard extends StatelessWidget {
  final String title;
  final int num1;
  final int num2;
  final int num3;

  EmergencyCard({
    required this.title,
    required this.num1,
    required this.num2,
    required this.num3,
  });

  //! Method to make a phone call
  void _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _makePhoneCall('$num1$num2$num3');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).mainColor,
        ),
        width: 50.w,
        height: 15.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
            sizedBoxHeight20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8.w,
                  height: 3.6.h,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffa3001a),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          )
                        ]),
                    child: Center(
                      child: Text(
                        num1.toString(),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).whiteText,
                        ),
                      ),
                    ),
                  ),
                ),
                sizedBoxWidth30,
                Container(
                  width: 8.w,
                  height: 3.6.h,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffa3001a),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.25),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        num2.toString(),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).whiteText,
                        ),
                      ),
                    ),
                  ),
                ),
                sizedBoxWidth30,
                Container(
                  width: 8.w,
                  height: 3.6.h,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffa3001a),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.25),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        num3.toString(),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).whiteText,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
