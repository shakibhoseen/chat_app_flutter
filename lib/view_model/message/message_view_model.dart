import 'package:chat_app_flutter/model/chat_model.dart';
import 'package:chat_app_flutter/respository/message_repository.dart';
import 'package:chat_app_flutter/utils/date_custom.dart';
import 'package:chat_app_flutter/view_model/home/chat_user_view_model.dart';
import 'package:firebase_database/firebase_database.dart';

import '../upload_view_model.dart';

class MessageViewModel{
  void operation(String id, ChatUserViewModel chatUserProvider, ChatModel chatModel){
    final timeStamp = TimeStamp.fromDatePublish(chatModel.publish);
    chatModel.timeStamp = timeStamp;
    chatUserProvider.addOfflineMessage(id, chatModel);
  }



  void setMessageToFirebase (
      {String? chatid,
      required String message,
      required String receiver,
      required String sender,
        String? imageUrl,
      required ChatUserViewModel chatUserProvider}) async{
    final repository = MessageRepository();
    print('chat id --- $chatid');
     chatid ??= repository.setKey();

    final chatModel = ChatModel(id: chatid, isseen: false, message: message, receiver: receiver, sender: sender, isSender: true, publish: DateCustom().currentTime, imageUrl: imageUrl);
    operation(receiver, chatUserProvider, chatModel);
    print('chat id --- ${chatModel.id}');

    String? downloadUrl;
    try{
      if (imageUrl != ''  && imageUrl !=null) {
        if(!imageUrl.contains('http')) {
          downloadUrl = await UploadViewModel().uploadImage(imageUrl);
        } else {
          downloadUrl = imageUrl;
        }
      }
      chatModel.imageUrl = downloadUrl;
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