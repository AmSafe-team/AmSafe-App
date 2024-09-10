import 'package:amsafe/model/live_safe_model.dart';
import 'package:amsafe/utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget liveSafeChips(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(1.h),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LiveSafeChip(
            label: 'Police Stations',
            icon: Icons.local_police,
            query: 'police stations near me',
          ),
          sizedBoxWidth30,
          LiveSafeChip(
            label: 'Hospitals',
            icon: Icons.local_hospital,
            query: 'hospitals near me',
          ),
          sizedBoxWidth30,
          LiveSafeChip(
            label: 'Pharmacies',
            icon: Icons.local_pharmacy,
            query: 'pharmacies near me',
          ),
          sizedBoxWidth30,
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
