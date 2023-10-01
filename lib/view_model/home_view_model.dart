import 'package:chat_app_flutter/respository/home_repository.dart';
import 'package:chat_app_flutter/utils/routes/routes_name.dart';
import 'package:chat_app_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> getUserDetails(BuildContext context) async {
    setLoading(true);

    _myRepo.getUserData().then((value) {
      setLoading(false);

      Utils.showFlashBarMessage(
          'Login Successfully', FlasType.success, context);
      // Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print("k  mood " + value.toString());
      }
      print("k  mood  $value");
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.showFlashBarMessage(error.toString(), FlasType.error, context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
