// ignore_for_file: deprecated_member_use

import 'package:amsafe/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:telephony/telephony.dart';

class AppSosButton extends StatefulWidget {
  final List<Contact> selectedContacts;

  AppSosButton({super.key, required this.selectedContacts});

  @override
  State<AppSosButton> createState() => _AppSosButtonState();
}

class _AppSosButtonState extends State<AppSosButton> {
  final Telephony telephony = Telephony.instance;
  bool isSending = false; // For loading spinner
  final box = GetStorage(); // For storing user settings
  bool isShakeEnabled = false;
  int shakeThreshold = 5;
  double lastX = 0, lastY = 0, lastZ = 0;
  int shakeCount = 0;
  List<Contact> selectedContacts = [];

  @override
  void initState() {
    super.initState();
    _loadSavedContacts();
    isShakeEnabled =
        box.read('shakeEnabled') ?? false; // Read the shake toggle setting

    accelerometerEvents.listen((AccelerometerEvent event) {
      // print('Accelerometer event: x=${event.x}, y=${event.y}, z=${event.z}');

      if (isShakeEnabled) {
        double diffX = (event.x - lastX).abs();
        double diffY = (event.y - lastY).abs();
        double diffZ = (event.z - lastZ).abs();

        // print('Shake differences: diffX=$diffX, diffY=$diffY, diffZ=$diffZ');

        if ((diffX > shakeThreshold ||
            diffY > shakeThreshold ||
            diffZ > shakeThreshold)) {
          shakeCount++;
          print('Shake count: $shakeCount');

          if (shakeCount > 2) {
            _sendSOS();
            print("Shake detected! Sending SOS...");
            shakeCount = 0;
          }
        }

        lastX = event.x;
        lastY = event.y;
        lastZ = event.z;
      }
    });
  }

  void _loadSavedContacts() {
    List<dynamic>? savedContactIds = box.read('selectedContacts');
    if (savedContactIds != null) {
      // Convert List<dynamic> to List<String>
      List<String> contactIds =
          savedContactIds.map((id) => id.toString()).toList();

      // Assuming you've loaded the contacts list elsewhere
      List<Contact> allContacts = []; // Replace with your full contact list
      setState(() {
        selectedContacts = allContacts.where((contact) {
          return contactIds.contains(contact.id);
        }).toList();
      });
    }
  }

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
      return 'Location permissions are permanently denied.';
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return "https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";
  }

  // Check SMS permission
  Future<bool> _checkSmsPermission() async {
    var status = await Permission.sms.status;
    if (!status.isGranted) {
      var result = await Permission.sms.request();
      return result.isGranted;
    }
    return true;
  }

  //! Function to send SOS message
  //! Function to send SOS message
  Future<void> _sendSOS() async {
    if (widget.selectedContacts.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select contacts to notify.')),
        );
      }
      return;
    }

    if (!await _checkSmsPermission()) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('SMS permission is required to send SOS.')),
        );
      }
      return;
    }

    setState(() {
      isSending = true; // Show loading
    });

    try {
      // Get current location
      String locationUrl = await _getLocation();
      String message = "I am not safe, track me here: $locationUrl";

      List<String> recipients = [];
      for (var contact in widget.selectedContacts) {
        if (contact.phones.isNotEmpty) {
          recipients.add(contact.phones.first.number);
        }
      }

      if (recipients.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No valid phone numbers found.')),
          );
        }
        return;
      }

      for (String recipient in recipients) {
        telephony.sendSms(
          to: recipient,
          message: message,
        );
      }

      print("Shake detected! Sending SOS...");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('SOS messages sent successfully')),
        );
      }
    } catch (e) {
      print('Error sending SOS: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send SOS messages.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isSending = false; // Hide loading
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: isSending ? null : _sendSOS,
      borderRadius: BorderRadius.circular(150),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(size.height * 0.03),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).mainColor.withOpacity(.3),
            ),
            child: Container(
              padding: EdgeInsets.all(size.height * 0.025),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).mainColor.withOpacity(.5),
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
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "SOS",
                      style: GoogleFonts.poppins(
                        fontSize: size.height * 0.038,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isSending)
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
        ],
      ),
    );
  }
}
