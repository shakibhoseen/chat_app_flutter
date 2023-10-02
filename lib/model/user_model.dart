import 'package:chat_app_flutter/res/app_url.dart';
import 'package:firebase_database/firebase_database.dart'; // or import the appropriate Firebase package

class UserModel {
  final String search;
  final String imageUrl;
  final String id;
  final String status;
  final String username;

  UserModel({
    required this.search,
    required this.imageUrl,
    required this.id,
    required this.status,
    required this.username,
  });

  factory UserModel.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;

    if (data == null) {
      return UserModel(
        search: '',
        imageUrl: AppUrl.defaultProfileImageUrl,
        id: '',
        status: '',
        username: '',
      );
    }

    return UserModel(
      search: data['search'] as String ?? '',
      imageUrl: data['imageUrl'] as String? ?? AppUrl.defaultProfileImageUrl,
      id: data['id'] as String? ?? '',
      status: data['status'] as String? ?? '',
      username: data['username'] as String? ?? '',
    );
  }


}