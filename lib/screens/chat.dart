import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //   backgroundColor: Color.fromARGB(187, 22, 21, 21),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              size: 30,
              Icons.arrow_back_ios,
              color: kourcolor1,
            ),
          ),
          title: Text('Chat With IRIS',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: kourcolor1,
              )),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              iconSize: 30,
              icon: const Icon(
                Icons.more_vert_outlined,
                color: kourcolor1,
              ),
            ),
          ]),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ChatMessage(
                    message: 'Hello, what can we help you with?',
                    senderName: 'Owner'),
                ChatMessage(message: 'Hi there!', senderName: 'Me'),
                // Add more ChatMessage widgets for additional messages
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: IconButton(
                          iconSize: 30,
                          icon: Icon(Icons.attachment),
                          color: kourcolor1,
                          onPressed: () {
                            // Implement attachment functionality
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.send),
                  color: kourcolor1,
                  onPressed: () {
                    // Implement sending message functionality
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatefulWidget {
  final String message;
  final String senderName;

  const ChatMessage({
    required this.message,
    required this.senderName,
  });

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Text(widget.senderName[0]), // Display sender's initials
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.senderName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(widget.message),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}