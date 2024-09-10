import 'package:amsafe/components/my_appbar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: my_appbar(context),
      body: Center(
        child: Column(
          children: [
            Text('This is the Settings Page.'),
          ],
        ),
      ),
    );
  }
}
