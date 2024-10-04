import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  ChatScreen({required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat: ${widget.user['title']}'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/chat.jpeg'), // Arka plan resminin yolu
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return _buildMessageBubble(message);
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, String> message) {
    final isSentByCurrentUser = message['sender'] == 'user';

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Align(
        alignment:
            isSentByCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(20.0), // Padding değerini artırdık
          decoration: BoxDecoration(
            color: isSentByCurrentUser ? Colors.blue : Colors.green,
            borderRadius:
                BorderRadius.circular(20.0), // BorderRadius değerini artırdık
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            message['text']!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal:
                      16.0), // Mesaj kutucuğu içindeki yatay boşluğu artırır
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Mesajınızı yazın...',
                  border: InputBorder.none, // Dış sınırı kaldırır
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          IconButton(
            onPressed: () {
              _sendMessage();
            },
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        _messages.add({'text': messageText, 'sender': 'user'});
        _messageController.clear();
      });
    }
  }
}
