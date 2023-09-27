import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

abstract class BaseApiServices {
  Future<dynamic> logInResponse(String email, String password);
  Future<dynamic> signUpResponse(String email, String password);
  Future<dynamic> setDataResponse(
      dynamic model, DatabaseReference databaseReference);
  Future<dynamic> getDataResponse(
       DatabaseReference databaseReference);

     // Future<Map<StreamSubscription<DatabaseEvent>  ,dynamic>> getRealTimeResponse(DatabaseReference reference);
}
