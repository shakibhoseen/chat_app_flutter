import 'dart:io';
import 'package:chat_app_flutter/utils/date_custom.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

enum UploadStatus { running, paused, success, canceled, error }

class UploadViewModel extends ChangeNotifier {
  UploadStatus status = UploadStatus.running;
  double progress = 0.0;

  Future<String?> uploadImage(String filePath) async {
    final path = DateCustom().currentTime;
    final ref = FirebaseStorage.instance.ref().child("chatimages/$path.jpg");

    try {
       final task =  ref.putFile(File(filePath));

       task.snapshotEvents.listen((event) {
        progress = event.bytesTransferred / event.totalBytes;
        print('progress---- $progress');
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

      // Wait for the task to complete
      await task;

      if (status == UploadStatus.success) {
        // File uploaded successfully
        final url = await ref.getDownloadURL();
        return url;
      } else if (status == UploadStatus.error) {
        // Error occurred during upload
        return '';
      }else{
        return '';
      }
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions
      return '';
    } on SocketException {
      // Handle no internet connection
      return '';
    }

    // Return null if the upload was canceled or in any other case

    return null;
  }
}
