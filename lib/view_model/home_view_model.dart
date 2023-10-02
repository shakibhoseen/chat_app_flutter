import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/respository/home_repository.dart';
import 'package:chat_app_flutter/utils/routes/routes_name.dart';
import 'package:chat_app_flutter/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  UserModel ? currentUserModel ;

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

  Future<UserModel> getUserDetails(BuildContext context) async {
    if(currentUserModel!=null) return currentUserModel!;
    setLoading(true);
    
    try {
      final value = await _myRepo.getUserData();
      setLoading(false);

      // Check if data is a Map and convert it to DataSnapshot if needed

     // Utils.showFlashBarMessage(
       //   'User details fetch successfully ', FlasType.success, context);
      // Navigator.pushNamed(context, RoutesName.home);
      currentUserModel = UserModel.fromSnapshot(value);
      //notifyListeners();
      Utils.showFlashBarMessage(
          'User  ${currentUserModel} ', FlasType.success, context);

      return currentUserModel!;
    } on Exception catch (e) {
      setLoading(false);
      Utils.showFlashBarMessage(e.toString(), FlasType.error, context);
      if (kDebugMode) {
        print(e.toString());
      }
      return UserModel(
          search: '', imageUrl: '', id: '', status: '', username: '');
    }
  }
}
