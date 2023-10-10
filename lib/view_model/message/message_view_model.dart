import 'package:chat_app_flutter/model/chat_model.dart';
import 'package:chat_app_flutter/respository/message_repository.dart';
import 'package:chat_app_flutter/utils/date_custom.dart';
import 'package:chat_app_flutter/view_model/home/chat_user_view_model.dart';
import 'package:firebase_database/firebase_database.dart';

class MessageViewModel{
  void operation(String id, ChatUserViewModel chatUserProvider, ChatModel chatModel){
    chatUserProvider.addOfflineMessage(id, chatModel);
  }



  void setMessageToFirebase (
      {String? chatid,
      required String message,
      required String receiver,
      required String sender,
      required ChatUserViewModel chatUserProvider}) async{
    final repository = MessageRepository();
    print('chat id --- $chatid');
     if(chatid==null)
       chatid = repository.setKey();

    final chatModel = ChatModel(id: chatid, isseen: false, message: message, receiver: receiver, sender: sender, isSender: true, publish: DateCustom().currentTime);
    operation(receiver, chatUserProvider, chatModel);
    print('chat id --- ${chatModel.id}');

    try{
       await repository.setMessage(chatModel);
         print('click');
    }catch(e){
      chatModel.isFailed = true;
      operation(receiver, chatUserProvider, chatModel);
      // print('.......................where');
      // print('.......................where');
      // print('.......................where');
      print("resent ${e.toString()}");
    }

  }
}