import 'package:flutter/material.dart';

class pesan extends StatelessWidget {
  final List<ChatMessage> messages = [
    ChatMessage(text: "blabla", isUser: false),
    ChatMessage(text: "blabla", isUser: true),
    ChatMessage(text: "blabla", isUser: false),
    ChatMessage(text: "blabla", isUser: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Ubah ikon menjadi panah maju
          onPressed: () {
            // Handle forward button press
          },
        ),
        title: const Center(
          child: Text('Pesan', style: TextStyle(color: Colors.black)),
        ),
        actions: [
          Image.asset('assets/shoeslogo.jpg'), // Pindahkan logo sepatu ke actions
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: messages[index]);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Kurangi padding
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey[200]!, width: 1.0),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Image.asset('assets/plus.jpg', width: 24, height: 24), // Sesuaikan ukuran
                  onPressed: () {
                    // Handle plus button press
                  },
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Warna latar belakang
                      borderRadius: BorderRadius.circular(40), // Radius tabung
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10), // Padding teks
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Image.asset('assets/send.jpg', width: 24, height: 24), // Sesuaikan ukuran
                  onPressed: () {
                    // Handle send button press
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

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blue[100] : Colors.grey[300],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          message.text,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
