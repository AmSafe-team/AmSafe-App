// ignore_for_file: deprecated_member_use
import 'package:amsafe/main.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telephony/telephony.dart';

class AppSosButton extends StatefulWidget {
  final List<Contact> selectedContacts;

  AppSosButton({super.key, required this.selectedContacts});

  @override
  State<AppSosButton> createState() => _AppSosButtonState();
}

class _AppSosButtonState extends State<AppSosButton> {
  final Telephony telephony = Telephony.instance;
  final List<Contact> selectedContacts = [];
  // Get location
  Future<String> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Location permissions are denied.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return 'Location permissions are permanently denied, we cannot request permissions.';
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return "https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";
  }

  //! Function to send SOS message
  //! Function to send SOS message
  Future<void> _sendSOS() async {
    if (widget.selectedContacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select contacts to notify.')),
      );
      return;
    }

    try {
      // Get current location
      String locationUrl = await _getLocation();
      String message = "I am not safe, track me here: $locationUrl";

      List<String> recipients = [];
      for (var contact in widget.selectedContacts) {
        if (contact.phones != null && contact.phones!.isNotEmpty) {
          recipients.add(contact.phones!.first.value!);
        }
      }

      if (recipients.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('No valid phone numbers found in selected contacts.')),
        );
        return;
      }

      for (String recipient in recipients) {
        telephony.sendSms(
          to: recipient,
          message: message,
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('SOS messages sent successfully')),
      );
    } catch (e) {
      print('Error sending SOS: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to send SOS messages. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: _sendSOS,
      borderRadius: BorderRadius.circular(150),
      child: Container(
        padding: EdgeInsets.all(size.height * 0.03),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).mainColor.withOpacity(.1),
        ),
        child: Container(
          padding: EdgeInsets.all(size.height * 0.025),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).mainColor.withOpacity(.3),
          ),
          child: Container(
            width: size.height * .18,
            height: size.height * .18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).mainColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.touch_app,
                  size: size.height * 0.05,
                  color: Theme.of(context).whiteText,
                ),
                SizedBox(height: 10),
                Text(
                  "SOS",
                  style: GoogleFonts.poppins(
                    fontSize: size.height * 0.038,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).whiteText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
