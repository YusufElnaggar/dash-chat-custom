import 'package:dash_chat_custom/dash_chat_custom.dart';
import 'package:examples/data.dart';
import 'package:flutter/material.dart';

class Media extends StatefulWidget {
  @override
  State<Media> createState() => MediaState();
}

class MediaState extends State<Media> {
  List<ChatMessage> messages = media;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media example'),
      ),
      body: DashChat(
        messageOptions: MessageOptions(
          showTime: true,
        ),
        currentUser: user,
        onSend: (ChatMessage m) {
          setState(() {
            messages.insert(0, m);
          });
        },
        messages: messages,
      ),
    );
  }
}
