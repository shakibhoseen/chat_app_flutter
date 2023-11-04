import 'package:chat_app_flutter/data/network/base_api_services.dart';
import 'package:chat_app_flutter/data/network/network_api_services.dart';
import 'package:chat_app_flutter/model/chat_model.dart';
import 'package:firebase_database/firebase_database.dart';

class MessageRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Chats');

  Future<dynamic> setMessage(ChatModel chatModel) async {
    try {
      dynamic response = await _apiServices.setDataResponse(
          chatModel.toMap(), reference.child(chatModel.id));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateMessage(ChatModel chatModel) async {
    try {
      dynamic response = await _apiServices.setDataResponse(
          chatModel.toSeenMap(), reference.child(chatModel.id));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  String setKey() {
    String chatId = reference.push().key.toString();
    return chatId;
  }
}
