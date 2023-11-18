import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:juridentt/addcase/provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  static const routename = 'chat-page';
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  List<Message> _messages = [];
  sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      final message = Message(isMe: true, text: _messageController.text);
      _messageController.clear();
      setState(() {
        _messages.insert(0, message);
      });
      try {
        sendtoGpt();
      } catch (e) {
        print(e);
      }
    }
  }

  void sendtoGpt() async {
    final url = Uri.parse('https://api.openai.com/v1/completions');
    Map<String, dynamic> body = {
      "model": "text-davinci-003",
      "messages": [
        {"role": "user", "content": "Hello!"}
      ],
      "max_tokens": 500
    };
    final response = await http
        .post(url,
            headers: {
              "Content-Type": "application/json",
              "Authorization":
                  "Bearer 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"
            },
            body: json.encode(body))
        .catchError((error) {
      print(error);
    });

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Center(
            child: AppBar(
              title: const Text('JurisChat'),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return buildMessage(_messages[index]);
              },
              itemCount: _messages.length,
            )),
            const Divider(
              height: 1.0,
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              border: Border.all(width: 1)),
                          child: TextField(
                            controller: _messageController,
                          ))),
                  IconButton(onPressed: sendMessage, icon: Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMessage(Message message) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment:
              message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            message.isMe ? Text('You') : Text('JurisChat'),
            Text(message.text),
          ],
        ),
      ),
    );
  }
}

class Message {
  String text;
  bool isMe;
  Message({required this.isMe, required this.text});
}
