import 'package:amsafe/main.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hello! I'm AmSafe AI. How can I help you today?",
      isMe: false,
    ),
  ];

  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _handleSubmitted(String text) async {
    _textController.clear();
    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isMe: true,
        ),
      );
    });

    //! Scroll to the bottom after adding a new message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    //! Simulated Gemini response
    String response = await _getGeminiResponse(text);

    setState(() {
      _messages.add(
        ChatMessage(
          text: response,
          isMe: false,
        ),
      );
    });

    //! Scroll to the bottom after adding the response
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Future<String> _getGeminiResponse(String input) async {
    //! This is a simulated response. In a real implementation, you'd call the Gemini API here.
    await Future.delayed(Duration(seconds: 1)); //! Simulate network delay

    if (input.toLowerCase().contains('emergency')) {
      return "I've detected an emergency situation. I'm initiating the emergency protocol now. Stay calm, help is on the way. Would you like me to contact your emergency contacts?";
    } else if (input.toLowerCase().contains('scared') ||
        input.toLowerCase().contains('unsafe')) {
      return "I'm sorry you're feeling scared or unsafe. Remember, your safety is the top priority. Can you get to a safe location? Do you need me to provide information on nearby safe spaces or contact someone for you?";
    } else if (input.toLowerCase().contains('advice') ||
        input.toLowerCase().contains('tip')) {
      return "Here's a safety tip: Always trust your instincts. If a situation feels wrong, it probably is. Don't be afraid to leave or ask for help. Would you like more specific safety advice?";
    } else {
      return "I'm here to assist with any safety concerns. Can you tell me more about your situation or what kind of help you need?";
    }
  }

  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(hintText: "Send a message"),
            ),
          ),
          IconButton(
            color: Theme.of(context).mainColor,
            icon: Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(8.0),
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({required this.text, required this.isMe});

  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              child: Text(isMe ? "Me" : "AI"),
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isMe ? Colors.blue[100] : Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}
