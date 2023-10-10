import 'package:chat_app_flutter/res/app_url.dart';
import 'package:chat_app_flutter/utils/date_custom.dart';
import 'package:firebase_database/firebase_database.dart';

class TimeStamp{
  final String dateCompare;
  final String hourMinute;

  TimeStamp({required this.dateCompare, required this.hourMinute});
  
  factory TimeStamp.fromDatePublish(int time){
    final data = DateCustom().formatTimestampWithTime(time);
    return TimeStamp(dateCompare: data['dateCompare']?? 'today', hourMinute: data['hourMinute']?? '09:09');
  }
  
}
class ChatModel {
  final String id;
  final bool isseen;
  final String message;
  final String receiver;
  final String sender;
  int publish;
  String? imageUrl;
  bool isSender;
  bool? isSend;
  bool? isFailed; // that indicate that from collect the online not only offline
  TimeStamp? timeStamp;
  
  ChatModel(
      {required this.id,
      required this.isseen,
      required this.message,
      required this.receiver,
      required this.sender,
      required this.isSender,
      required this.publish,
      this.imageUrl,
      this.isSend,
      this.isFailed, this.timeStamp});

  factory ChatModel.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;
    final time = DateCustom().currentTime;
    if (data == null) {
      return ChatModel(
          id: "",
          isseen: false,
          message: '',
          receiver: '',
          sender: '',
          isSender: true,
          publish: time,
      );
    }
    final senderId = data['sender'] as String? ?? '';
    return ChatModel(
      id: snapshot.key.toString(),
      sender: senderId,
      receiver: data['receiver'] as String? ?? '',
      message: data['message'] as String? ?? "sent photo",
      isseen: data['isseen'] as bool? ?? false,
      imageUrl: data['imageUrl'] as String? ?? '',
      publish: data['publish'] as int? ?? time,
      timeStamp: TimeStamp.fromDatePublish(data['publish'] as int? ?? time),
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
      if (imageUrl != null) 'imageUrl': imageUrl,
      'publish': publish,
      //'isSender': isSender,
      //'isSend': isSend,
    };
  }
}
