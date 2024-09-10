import 'package:amsafe/main.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyDrawerTile extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function()? onTap;
  const MyDrawerTile({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).mainColor,
            fontFamily: "Sofia",
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(
          icon,
          color: Theme.of(context).mainColor,
          size: 3.h,
        ),
        onTap: onTap,
      ),
    );
  }
}
