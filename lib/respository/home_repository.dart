import 'package:chat_app_flutter/data/network/base_api_services.dart';
import 'package:chat_app_flutter/data/network/network_api_services.dart';
import 'package:chat_app_flutter/view_model/services/splash_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> getUserData() async {
    var user = SplashServices.user;

    print('user repository ..... $user');
    user ??= FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    DatabaseReference reference =
        FirebaseDatabase.instance.ref('Users').child(user.uid);
    try {
      final value = await _apiServices.getDataResponse(reference);
      return value;
    } on Exception catch (e) {
      rethrow;
    }
  }
}
