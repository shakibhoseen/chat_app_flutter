import 'dart:async';
import 'dart:io';

import 'package:chat_app_flutter/data/app_excaptions.dart';
import 'package:chat_app_flutter/data/network/base_api_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getDataResponse(DatabaseReference databaseReference) async {
    try {
      final dataEvent = await databaseReference.once();
      if (dataEvent.snapshot.value != null) {
        return dataEvent.snapshot;
      } else {
        throw FetchDataException('No Data avilable');
      }
    } on FirebaseException catch (e) {
      getReadException(e);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  @override
  Future setDataResponse(model, DatabaseReference databaseReference) async {
    try {
      final dataEvent = await databaseReference.child('').once();
      if (dataEvent.snapshot.value != null) {
        return dataEvent.snapshot;
      } else {
        throw FetchDataException('No Data avilable');
      }
    } on FirebaseException catch (e) {
      getReadException(e);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  @override
  Future logInResponse(String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return result.user;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on FirebaseAuthException catch (code) {
      getExceptionResponse(code);
    }
  }

  @override
  Future signUpResponse(String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return result.user;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on FirebaseAuthException catch (e) {
      getExceptionResponse(e);
    }
  }

  void getExceptionResponse(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'user-not-found':
        throw ErrorException('User not found');

      case 'wrong-password':
        throw ErrorException('Wrong passowrd');

      case 'user-disabled':
        throw ErrorException('User disabled');
      case 'invalid-email':
        throw ErrorException('User email invalid');

      case 'email-already-in-use':
        throw ErrorException('Email are already used');

      case 'weak-password':
        throw ErrorException('weak password');
      default:
        throw FetchDataException(
            ' with server  with status code ${exception.code}');
    }
  }

  void getReadException(FirebaseException e) {
    if (e.code == 'PERMISSION_DENIED') {
      // Handle permission denied error
      throw BadRequestException('premission denied');
    } else {
      throw FetchDataException(' with serverwith status code${e.code}');
    }
  }
}
