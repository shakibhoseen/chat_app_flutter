import 'package:firebase_database/firebase_database.dart';

class ChatModel {
  final bool isseen;
  final String message;
  final String receiver;
  final String sender;

  ChatModel(
      {required this.isseen,
      required this.message,
      required this.receiver,
      required this.sender});

  factory ChatModel.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;

    if (data == null) {
      return ChatModel(isseen: false, message: '', receiver: '', sender: '');
    }

    return ChatModel(
      sender: data['sender'] as String? ?? '',
      receiver: data['receiver'] as String? ?? '',
      message: data['message'] as String? ?? "sent photo",
      isseen: data['isseen'] as bool? ?? false,
    );
  }
}
