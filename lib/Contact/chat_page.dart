import 'package:flutter/material.dart';
import 'package:juridentt/chat_provider.dart';
import 'package:juridentt/constants.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  static const routename = 'chat-page';
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  // List<Message> _messages = [
  //   Message(isMe: false, text: 'Hello this is Jurischat how can i assist you!'),
  //   Message(text: 'Today'),
  // ];

  // void sendtoGpt(Message message) async {
  //   final url = Uri.parse('https://api.openai.com/v1/chat/completions');
  //   Map<String, dynamic> body = {
  //     "model": "gpt-3.5-turbo",
  //     "messages": [
  //       {"role": "user", "content": message.text}
  //     ],
  //     "max_tokens": 500
  //   };
  //   final response = await http
  //       .post(url,
  //           headers: {
  //             "Content-Type": "application/json",
  //             "Authorization":
  //                 "Bearer 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"
  //           },
  //           body: json.encode(body))
  //       .catchError((error) {
  //     print(error);
  //   });

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> responseBody = json.decode(response.body);
  //     if (responseBody.containsKey('choices') &&
  //         responseBody['choices'].isNotEmpty &&
  //         responseBody['choices'][0].containsKey('message') &&
  //         responseBody['choices'][0]['message'].containsKey('content') &&
  //         responseBody['choices'][0]['message']['role'] == 'assistant') {
  //       String assistantMessageContent =
  //           responseBody['choices'][0]['message']['content'];
  //       Message reply = Message(isMe: false, text: assistantMessageContent);
  //       print(assistantMessageContent);
  //       _messages.insert(0, reply);
  //       setState(() {});
  //     } else {
  //       print("Invalid response format or missing assistant's message content");
  //     }
  //   } else {
  //     print("Error: ${response.statusCode}");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<ChatProvider>(context);
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: Center(
            child: AppBar(
              automaticallyImplyLeading: true,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              elevation: 0,
              backgroundColor: Constants.lightblack,
              titleSpacing: 100,
              centerTitle: true,
              toolbarHeight: 160,
              title: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('JurisChat'),
                  SizedBox(
                    height: 10,
                  ),
                  Image(
                    image: AssetImage('assets/Group 33622.png'),
                    height: 90,
                  )
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                flex: 1,
                child: Consumer<ChatProvider>(
                  builder: (context, chatprovider, child) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Align(
                            alignment: chatprovider.messages[index].isMe == null
                                ? Alignment.center
                                : chatprovider.messages[index].isMe!
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: buildMessage(chatprovider.messages[index]));
                      },
                      reverse: true,
                      itemCount: chatprovider.messages.length,
                    );
                  },
                )),
            const Divider(
              height: 1.0,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Constants.yellow,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: TextField(
                          scrollPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type here....',
                              hintStyle: TextStyle(color: Colors.white)),
                          controller: _messageController,
                        ))),
                IconButton(
                    onPressed: () {
                      cp.sendMessage(_messageController);
                    },
                    icon: Icon(
                      Icons.send,
                      color: Constants.yellow,
                      size: 30,
                    )),
              ],
            ),
            Container(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget buildMessage(Message message) {
    return Container(
      decoration: BoxDecoration(
        color: message.isMe == null
            ? Colors.transparent
            : message.isMe == false
                ? const Color.fromARGB(255, 191, 182, 182)
                : const Color.fromARGB(255, 227, 219, 219),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: message.isMe == true
              ? CrossAxisAlignment.end
              : message.isMe == false
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: message.isMe == true ? Constants.yellow : Colors.black,
                fontSize: 15,
              ),
            ),
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
