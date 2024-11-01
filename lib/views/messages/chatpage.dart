import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../service/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  const ChatPage({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FocusNode _focusNode = FocusNode();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ScrollController _scrollController = ScrollController();
  String? _editingMessageId;

  void sendMessages() async {
    if (_messageController.text.isNotEmpty) {
      if (_editingMessageId != null) {
        // Jika mengedit, perbarui pesan
        await _chatService.editMessage(
            _getChatRoomId(), _editingMessageId!, _messageController.text);
        _editingMessageId = null;
      } else {
        // Jika mengirim pesan baru
        await _chatService.sendMessage(
            widget.receiverUserID, _messageController.text);
      }
      _messageController.clear();
      _focusNode.requestFocus(); // Fokus kembali ke text field
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _deleteMessage(String chatRoomId, String messageId) async {
    await _chatService.deleteMessage(chatRoomId, messageId);
  }

  void _editMessage(String chatRoomId, String messageId, String currentMessage) {
    _editingMessageId = messageId;
    _messageController.text = currentMessage;
  }

  void _showMessageOptions(String chatRoomId, String messageId, String currentMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Choose an option"),
          actions: [
            TextButton(
              onPressed: () {
                _editMessage(chatRoomId, messageId, currentMessage);
                Navigator.pop(context);
              },
              child: const Text("Edit"),
            ),
            TextButton(
              onPressed: () async {
                await _deleteMessage(chatRoomId, messageId);
                Navigator.pop(context);
              },
              child: const Text("Delete"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  String _getChatRoomId() {
    List<String> ids = [widget.receiverUserID, _firebaseAuth.currentUser!.uid];
    ids.sort();
    return ids.join("_");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Text(
                widget.receiverUserEmail[0].toUpperCase(),
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.receiverUserEmail,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Online',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.black),
            onPressed: () {
              // Video call functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Colors.black),
            onPressed: () {
              // Phone call functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Additional features
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.black),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }

        return ListView(
          controller: _scrollController,
          padding: const EdgeInsets.all(12),
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == _firebaseAuth.currentUser!.uid;
    String messageId = document.id;
    String chatRoomId = _getChatRoomId();

    // Format the timestamp
    Timestamp timestamp = data['timestamp'];
    String formattedTime = DateFormat.jm().format(timestamp.toDate());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onLongPress: () {
          if (isCurrentUser) {
            _showMessageOptions(chatRoomId, messageId, data['message']);
          }
        },
        child: Align(
          alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: isCurrentUser
                  ? Colors.blue[100]
                  : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isCurrentUser ? 16 : 4),
                bottomRight: Radius.circular(isCurrentUser ? 4 : 16),
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['message'] ?? "Pesan telah dihapus",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formattedTime,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.black),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              focusNode: _focusNode,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Message',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (value) {
                sendMessages();
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: sendMessages,
          ),
        ],
      ),
    );
  }
}
