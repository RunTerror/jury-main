import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:juridentt/Contact/chat_page.dart';
import 'package:http/http.dart' as http;

class ChatProvider extends ChangeNotifier {
  final List<Message> _messages = [
    Message(isMe: false, text: 'Hello this is Jurischat how can i assist you!'),
    Message(text: 'Today'),
  ];

  List<Message> get messages => _messages;

  void addMessage(Message newMessage) {
    _messages.insert(0, newMessage);
    notifyListeners();
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
        addMessage(reply);
      } else {
        print("Invalid response format or missing assistant's message content");
      }
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  sendMessage(TextEditingController messageController) {
    if (messageController.text.trim().isNotEmpty) {
      final message = Message(isMe: true, text: messageController.text);
      messageController.clear();
      addMessage(message);
      try {
        sendtoGpt(message);
      } catch (e) {
        print(e);
      }
    }
  }
}
