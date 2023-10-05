import 'package:chat_app_flutter/model/chat_model.dart';
import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/utils/utils.dart';
import 'package:chat_app_flutter/view_model/services/splash_services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatUserViewModel extends ChangeNotifier {
  final uId = SplashServices.user!.uid;
  List<UserModel> userMessageList = [];
  List<ChatModel> messageList = [];
  List<UserModel> userList = [];
  Map<String, UserModel> mapUserMsgList =
      {}; // i have put last message inside UserModel.LastMessage

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void getChatUser(BuildContext context) async {
    setLoading(true);
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('Users');
    try {
      reference.onValue.listen((event) {
        if (!event.snapshot.exists) return;
        userMessageList.clear();
        event.snapshot.children.forEach((element) {
          UserModel userModel = UserModel.fromSnapshot(event.snapshot);
          mapUserMsgList[userModel.id] = userModel;
          userList.add(userModel);
        });

        _readChat();
      });
    } on Exception catch (e) {
      setLoading(false);
      Utils.showFlashBarMessage(e.toString(), FlasType.error, context);
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void _readChat() {
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('Chats');
    try {
      reference.onValue.listen((event) {
        if (!event.snapshot.exists) return;
        messageList.clear();
        event.snapshot.children.forEach((element) {
          ChatModel chatModel = ChatModel.fromSnapshot(event.snapshot);
          if (chatModel.receiver == uId) {
            LastMessage? lastMessage =
                mapUserMsgList[chatModel.sender]!.lastMessage;
            if (lastMessage != null) {
              // update message
              if (!chatModel.isseen) lastMessage.countMessage++;
              lastMessage.isUserSender = false;
              lastMessage.lastMessage = chatModel.message;
            } else {
              // create new
              mapUserMsgList[chatModel.sender]!.lastMessage = LastMessage(
                  lastMessage: chatModel.message,
                  isUserSender: false,
                  countMessage: chatModel.isseen ? 0 : 1);
            }
          } else if (chatModel.sender == uId) {
            LastMessage? lastMessage =
                mapUserMsgList[chatModel.receiver]!.lastMessage;
            if (lastMessage != null) {
              // update message
              if (!chatModel.isseen) lastMessage.countMessage++;
              lastMessage.isUserSender = true;
              lastMessage.lastMessage = chatModel.message;
            } else {
              // create new
              mapUserMsgList[chatModel.receiver]!.lastMessage = LastMessage(
                  lastMessage: chatModel.message,
                  isUserSender: true,
                  countMessage: chatModel.isseen ? 0 : 1);
            }
          }
          messageList.add(chatModel);
          notifyListeners();
        });
      });
    } on Exception catch (e) {
      //setLoading(false);
      // Utils.showFlashBarMessage(e.toString(), FlasType.error, context);
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void sortOperation() {}
}
