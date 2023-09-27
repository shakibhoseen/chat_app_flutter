import 'dart:async';

import 'package:flutter/material.dart';

class SplashViewModel with ChangeNotifier {
  double _progress = 0.0;
   Timer? _progressTimer;

  double get progress => _progress;

  Future<void> loadMainScreen() async {
    print('start time init');
   _progressTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (_progress < 1.0) {
        print('ok----$_progress');
        _progress += 0.01;
        _progress = double.parse(_progress.toStringAsFixed(2)); // Update the progress
        notifyListeners();
      } else {
        // Loading is complete, cancel the timer
        _progressTimer?.cancel();
      }
    });
    await Future.delayed(const Duration(seconds: 10));
    _progressTimer?.cancel();
  }

  // Future<void> _updateProgress(int currentProgress) async {
  //   if (currentProgress <= 100) {
  //     _progress = currentProgress / 100.0;
  //     notifyListeners();
  //     print('progress-- $_progress');
  //     await Future.delayed(const Duration(milliseconds: 200)); // Delay for simulation

  //     await _updateProgress(currentProgress + 1); // Recursive call for next step
  //   }
  // }
  void callIncrement(){
    _progress += 0.01;
    print("call increment $_progress");
    notifyListeners();
  }
}

