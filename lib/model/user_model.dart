import 'dart:math';

import 'package:chat_app_flutter/res/app_url.dart';
import 'package:firebase_database/firebase_database.dart';

class LastMessage {
  String lastMessage;
  int countMessage;
  bool isUserSender;

  LastMessage(
      {required this.lastMessage,
      required this.isUserSender,
      required this.countMessage});
} // or import the appropriate Firebase package

class UserModel {
  final String search;
  final String imageUrl;
  final String id;
  final String status;
  final String username;
  final bool isActive;
  LastMessage? lastMessage;

  UserModel({
    required this.search,
    required this.imageUrl,
    required this.id,
    required this.status,
    required this.username,
    required this.isActive,
    this.lastMessage,
  });

  factory UserModel.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;

    if (data == null) {
      return UserModel(
        search: 'ok',
        imageUrl: AppUrl.defaultProfileImageUrl,
        id: '',
        status: '',
        username: '',
        isActive: false,
      );
    }

    return UserModel(
      search: data['search'] as String? ?? 'p',
      imageUrl: data['imageUrl'] as String? ?? AppUrl.defaultProfileImageUrl,
      id: data['id'] as String? ?? '',
      status: data['status'] as String? ?? '',
      username: data['username'] as String? ?? '',
      isActive: Random().nextBool(),
    );
  }
}
