import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  const AppTextfield({
    super.key,
    required this.label,
    required this.controller,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "Sofia",
            ),
          ),
        ),
        SizedBox(height: 5),
        TextField(
          keyboardType: label == "phone"
              ? TextInputType.numberWithOptions()
              : TextInputType.text,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
        ),
      ],
    );
  }
}
