import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

enum UploadStatus { running, paused, success, canceled, error }

class UploadViewModel extends ChangeNotifier {
  UploadStatus status = UploadStatus.running;
  double progress = 0.0;

  Future<String?> uploadImage(String filePath) async {
    final ref = FirebaseStorage.instance.ref().child("chatimages/image1.jpg");

    try {
      final task =
          await ref.putFile(File(filePath)).snapshotEvents.listen((event) {
        progress = event.bytesTransferred / event.totalBytes;
        status = event.state == TaskState.running
            ? UploadStatus.running
            : event.state == TaskState.paused
                ? UploadStatus.paused
                : event.state == TaskState.success
                    ? UploadStatus.success
                    : event.state == TaskState.canceled
                        ? UploadStatus.canceled
                        : UploadStatus.error;

        notifyListeners();
      });

      if (status == UploadStatus.success) {
        // File uploaded successfully
        final url = await ref.getDownloadURL();
        return url;
      } else if (status == UploadStatus.error) {
        // Error occurred during upload
        return '';
      }
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions
      return '';
    } on SocketException {
      // Handle no internet connection
      return '';
    }
  }
}
