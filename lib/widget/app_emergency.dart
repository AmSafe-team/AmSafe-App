import 'package:amsafe/model/emergency_card_model.dart';
import 'package:amsafe/utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget emergencyCardList(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(0.5.h),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          EmergencyCard(
            title: 'Police Contact',
            num1: 1,
            num2: 0,
            num3: 0,
          ),
          sizedBoxWidth20,
          EmergencyCard(
            title: 'Fire Brigade',
            num1: 1,
            num2: 0,
            num3: 1,
          ),
          sizedBoxWidth20,
          EmergencyCard(
            title: 'Ambulance',
            num1: 1,
            num2: 0,
            num3: 2,
          ),
          sizedBoxWidth20,
          EmergencyCard(
            title: 'Women Helpline',
            num1: 1,
            num2: 8,
            num3: 1,
          ),
        ],
      ),
    ),
  );
}
