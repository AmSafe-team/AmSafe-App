import 'package:amsafe/components/my_appbar.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: my_appbar(context),
      body: Center(
        child: Text('Welcome to the chat room!'),
      ),
    );
  }
}
