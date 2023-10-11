import 'package:chat_app_flutter/model/chat_model.dart';
import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/utils/utils.dart';
import 'package:chat_app_flutter/view_model/services/splash_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatUserViewModel extends ChangeNotifier {

  User? user;
  String uId = '';

  ChatUserViewModel() {
    // Initialize the 'user' instance variable in the constructor
    user = FirebaseAuth.instance.currentUser;
    uId = user?.uid ?? '';
  }


  List<UserModel> userList = [];
  Map<String, UserModel> mapUserMsg =
      {}; // i have put last message inside UserModel.LastMessage
  Map<String, List<ChatModel>> mapUserCombMsgList =
  {};  // par user hold all message list

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
        userList.clear();
        event.snapshot.children.forEach((element) {
          UserModel userModel = UserModel.fromSnapshot(element);
          mapUserMsg[userModel.id] = userModel;
          userList.add(userModel);

        });
          print('get chat map ${mapUserMsg.length}');
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

        mapUserCombMsgList.clear();
        mapUserMsg.forEach((userId, userModel) {
          userModel.lastMessage = null;
        });  // clear last message and its counter reset

        event.snapshot.children.forEach((element) {
          ChatModel chatModel = ChatModel.fromSnapshot(element);
          if (chatModel.receiver == uId) {
            chatModel.isSender = false;
            LastMessage? lastMessage =
                mapUserMsg[chatModel.sender]?.lastMessage;
            if (lastMessage != null) {
              // update message
              if (!chatModel.isseen) lastMessage.countMessage++;
              lastMessage.isUserSender = false;
              lastMessage.lastMessage = chatModel.message;

            } else {
              // create new
              mapUserMsg[chatModel.sender]?.lastMessage = LastMessage(
                  lastMessage: chatModel.message,
                  isUserSender: false,
                  countMessage: chatModel.isseen ? 0 : 1);
            }
            mapUserCombMsgList[chatModel.sender] ??= [];
            mapUserCombMsgList[chatModel.sender]?.add(chatModel);
          } else if (chatModel.sender == uId) {
            chatModel.isSender = true;
            if(mapUserMsg[chatModel.receiver] ==null){
              for (var element in userList) {
                if (element.id == chatModel.receiver) {
                  mapUserMsg[chatModel.receiver] = element;
                  break;  // Use the break statement to exit the loop
                }
              }
            }
            print('inside read chat ${mapUserMsg[chatModel.receiver]}');

            LastMessage? lastMessage =
                mapUserMsg[chatModel.receiver]?.lastMessage;
            if (lastMessage != null) {
              // update message
              if (!chatModel.isseen) lastMessage.countMessage++;
              lastMessage.isUserSender = true;
              lastMessage.lastMessage = chatModel.message;
              //mapUserMsgList[chatModel.receiver]!.lastMessage = lastMessage;
            } else {
              // create new
              mapUserMsg[chatModel.receiver]?.lastMessage = LastMessage(
                  lastMessage: chatModel.message,
                  isUserSender: true,
                  countMessage: chatModel.isseen ? 0 : 1);
            }
            mapUserCombMsgList[chatModel.receiver] ??= [];
            mapUserCombMsgList[chatModel.receiver]?.add(chatModel);
            //print("${mapUserMsg[chatModel.receiver]!.lastMessage?.lastMessage} - ${chatModel.message}");
          }

        });
        removeUsersWithoutLastMessage();  // delte other user who not conversation
      });
    } on Exception catch (e) {
      //setLoading(false);
      // Utils.showFlashBarMessage(e.toString(), FlasType.error, context);
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void removeUsersWithoutLastMessage() {
    mapUserMsg.removeWhere((userId, userModel) => userModel.lastMessage == null);
    notifyListeners();
  }

  addOfflineMessage(String id, ChatModel chatModel){
    if(mapUserCombMsgList[id]==null){
      print('null not found $id ${mapUserCombMsgList.length}');
    }else {
      print("${mapUserCombMsgList[id]?.length} ..... length");
    }
    if(mapUserCombMsgList[id]!=null){

      if(mapUserCombMsgList[id]!.isNotEmpty){
        ChatModel old = mapUserCombMsgList[id]!.last;
        if(old.id == chatModel.id){
          mapUserCombMsgList[id]!.removeLast();
        }
      }
    }
    mapUserCombMsgList[id] ??= [];
    mapUserCombMsgList[id]?.add(chatModel);
    notifyListeners();
  }
}
