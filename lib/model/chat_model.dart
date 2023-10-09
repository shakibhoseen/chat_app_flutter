import 'package:chat_app_flutter/res/app_url.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatModel {
  final String id;
  final bool isseen;
  final String message;
  final String receiver;
  final String sender;
  String? imageUrl;
  bool isSender;
  bool? isSend;
  bool? isFailed;// that indicate that from collect the online not only offline

  ChatModel(
      {required this.id,
      required this.isseen,
      required this.message,
      required this.receiver,
      required this.sender,
      required this.isSender,
      this.imageUrl,
      this.isSend, this.isFailed});

  factory ChatModel.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;

    if (data == null) {
      return ChatModel(id: "",
          isseen: false, message: '', receiver: '', sender: '', isSender: true);
    }
    final senderId = data['sender'] as String? ?? '';
    return ChatModel(
      id: snapshot.key.toString(),
      sender: senderId,
      receiver: data['receiver'] as String? ?? '',
      message: data['message'] as String? ?? "sent photo",
      isseen: data['isseen'] as bool? ?? false,
      imageUrl: data['imageUrl'] as String? ?? '',
      isSender: true,
      isSend: true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isseen': isseen,
      'message': message,
      'receiver': receiver,
      'sender': sender,
      if(imageUrl!=null) 'imageUrl': imageUrl,
      //'isSender': isSender,
      //'isSend': isSend,
    };
  }
}
