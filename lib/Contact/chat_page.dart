import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  List<Message> _messages = [
    Message(isMe: false, text: 'Hello this is Jurischat how can i assist you!'),
    Message(text: 'Today'),
  ];
  sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      final message = Message(isMe: true, text: _messageController.text);
      _messageController.clear();
      setState(() {
        _messages.insert(0, message);
      });
      try {
        sendtoGpt(message);
      } catch (e) {
        print(e);
      }
    }
  }

  void sendtoGpt(Message message) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": message.text}
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

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody.containsKey('choices') &&
          responseBody['choices'].isNotEmpty &&
          responseBody['choices'][0].containsKey('message') &&
          responseBody['choices'][0]['message'].containsKey('content') &&
          responseBody['choices'][0]['message']['role'] == 'assistant') {
        String assistantMessageContent =
            responseBody['choices'][0]['message']['content'];
        Message reply = Message(isMe: false, text: assistantMessageContent);
        print(assistantMessageContent);
        _messages.insert(0, reply);
        setState(() {});
      } else {
        print("Invalid response format or missing assistant's message content");
      }
    } else {
      print("Error: ${response?.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Center(
            child: AppBar(
              titleSpacing: 100,
              centerTitle: true,
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
              reverse: true,
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
          crossAxisAlignment: message.isMe == true
              ? CrossAxisAlignment.end
              : message.isMe == false
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
          children: [
            message.isMe == true
                ? Text('You')
                : message.isMe == false
                    ? Text('JurisChat')
                    : Container(),
            Text(message.text),
          ],
        ),
      ),
    );
  }
}

class Message {
  String text;
  bool? isMe;
  Message({this.isMe, required this.text});
}
