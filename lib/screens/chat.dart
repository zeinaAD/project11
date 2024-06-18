import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/UserPreferences.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _messageController = TextEditingController();
  final String chatId = "your_chat_id"; // Replace with actual chat ID

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('chats/$chatId/messages')
          .add({
        'text': _messageController.text,
        'date': FieldValue.serverTimestamp(),
        'isSentByMe': true, // Assuming this message is sent by the current user
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: kourcolor1, size: 30),
        ),
        title: Text('Chat With IRIS',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: kourcolor1)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            iconSize: 30,
            icon: Icon(Icons.more_vert_outlined, color: kourcolor1),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: getMessages(chatId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var messages = snapshot.data!;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return ChatMessage(
                      message: messages[index].text,
                      isSentByMe: messages[index].isSentByMe,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                      prefixIcon: IconButton(
                        iconSize: 30,
                        icon: Icon(Icons.attachment, color: kourcolor1),
                        onPressed: () {
                          // Implement attachment functionality
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.send, color: kourcolor1),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Stream<List<Message>> getMessages(String chatId) {
    return FirebaseFirestore.instance
        .collection('chats/$chatId/messages')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromSnapshot(doc)).toList());
  }
}

class Message {
  final String id;
  final String text;
  final DateTime date;
  final bool isSentByMe;

  Message(
      {required this.id,
      required this.text,
      required this.date,
      required this.isSentByMe});

  factory Message.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    var json = snapshot.data();
    return Message(
      id: snapshot.id,
      text: json['text'] as String,
      date: (json['date'] as Timestamp).toDate(),
      isSentByMe: json['isSentByMe'] as bool,
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  const ChatMessage({required this.message, required this.isSentByMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment:
            isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          isSentByMe
              ? Container()
              : CircleAvatar(
                  child: Text('User')), // Placeholder for the user initial
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: isSentByMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: isSentByMe ? Colors.blue[100] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(message),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
