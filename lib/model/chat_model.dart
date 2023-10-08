import 'package:chat_app_flutter/res/app_url.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatModel {
  final bool isseen;
  final String message;
  final String receiver;
  final String sender;
  String? imageUrl;
  bool isSender;

  ChatModel(
      {required this.isseen,
      required this.message,
      required this.receiver,
      required this.sender,
      required this.isSender,
      this.imageUrl});

  factory ChatModel.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;

    if (data == null) {
      return ChatModel(
          isseen: false, message: '', receiver: '', sender: '', isSender: true);
    }
    final senderId = data['sender'] as String? ?? '';
    return ChatModel(
      sender: senderId,
      receiver: data['receiver'] as String? ?? '',
      message: data['message'] as String? ?? "sent photo",
      isseen: data['isseen'] as bool? ?? false,
      imageUrl: data['imageUrl'] as String? ?? '',
      isSender: true,
    );
  }
}
