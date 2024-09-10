import 'package:amsafe/model/emergency_card_model.dart';
import 'package:flutter/material.dart';

Widget emergencyCardList(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
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
          SizedBox(width: 16),
          EmergencyCard(
            title: 'Fire Brigade',
            num1: 1,
            num2: 0,
            num3: 1,
          ),
          SizedBox(width: 16),
          EmergencyCard(
            title: 'Ambulance',
            num1: 1,
            num2: 0,
            num3: 2,
          ),
          SizedBox(width: 16),
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
