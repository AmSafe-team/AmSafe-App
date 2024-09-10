import 'package:amsafe/model/live_safe_model.dart';
import 'package:flutter/material.dart';

Widget liveSafeChips(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          LiveSafeChip(
            label: 'Police Stations',
            icon: Icons.local_police,
            query: 'police stations near me',
          ),
          SizedBox(width: 14),
          LiveSafeChip(
            label: 'Hospitals',
            icon: Icons.local_hospital,
            query: 'hospitals near me',
          ),
          SizedBox(width: 14),
          LiveSafeChip(
            label: 'Pharmacies',
            icon: Icons.local_pharmacy,
            query: 'pharmacies near me',
          ),
          SizedBox(width: 14),
          LiveSafeChip(
            label: 'Bus Stations',
            icon: Icons.directions_bus,
            query: 'bus stations near me',
          ),
        ],
      ),
    ),
  );
}
