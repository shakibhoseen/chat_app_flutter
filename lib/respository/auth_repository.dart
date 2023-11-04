import 'package:chat_app_flutter/data/network/base_api_services.dart';
import 'package:chat_app_flutter/data/network/network_api_services.dart';
import 'package:chat_app_flutter/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiServices();
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Users');

  Future<dynamic> loginApi(String email, String password) async {
    try {
      dynamic response = await _apiServices.logInResponse(email, password);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signUpApi(
      String email, String password, UserModel userModel) async {
    try {
      User response = await _apiServices.signUpResponse(email, password);

      final modelUser = userModel.cloneWithNewId(response.uid);

      final modelMap = modelUser.toMap();

      await _apiServices.setDataResponse(
          modelMap, reference.child(modelUser.id));
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
