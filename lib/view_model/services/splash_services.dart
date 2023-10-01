import 'package:chat_app_flutter/firebase_options.dart';
import 'package:chat_app_flutter/utils/routes/routes_name.dart';
import 'package:chat_app_flutter/view_model/splash_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SplashServices {
  static User? user;

  Future<void> checkAuthentication() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    user = FirebaseAuth.instance.currentUser;
  }

  Future<void> start(BuildContext context, SplashViewModel viewModel) async {
    final localContext = context;
    // Create a list of Futures for checkAuthentication() and loadMainScreen()
    final futures = <Future<void>>[
      checkAuthentication(),
      viewModel.loadMainScreen(),
    ];

    // Wait for both futures to complete
    await Future.wait(futures);

    // Both methods are finished, navigate to another page
    if (user == null) {
      Navigator.pushReplacementNamed(localContext, RoutesName.login);
      return;
    }

    Navigator.pushReplacementNamed(localContext, RoutesName.home);
  }
}
