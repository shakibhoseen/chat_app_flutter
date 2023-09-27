

import 'package:chat_app_flutter/respository/auth_repository.dart';
import 'package:chat_app_flutter/utils/routes/routes_name.dart';
import 'package:chat_app_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


class AuthViewModel with ChangeNotifier {

  final _myRepo = AuthRepository();

  bool _loading = false ;
  bool get loading => _loading ;

  bool _signUpLoading = false ;
  bool get signUpLoading => _signUpLoading ;


  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value){
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(String email, String password , BuildContext context) async {

    setLoading(true);

    _myRepo.loginApi(email, password).then((value){
      setLoading(false);
      
      

      Utils.showFlashBarMessage('Login Successfully', FlasType.error, context);
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){
        print(value.toString());

      }
    }).onError((error, stackTrace){
      setLoading(false);
      Utils.showFlashBarMessage(error.toString(), FlasType.error, context);
      if(kDebugMode){
        print(error.toString());
      }

    });
  }


  Future<void> signUpApi(dynamic data , BuildContext context) async {

    setSignUpLoading(true);

    _myRepo.signUpApi(data['email'], data['password']).then((value){
      setSignUpLoading(false);
      Utils.showFlashBarMessage('SignUp Successfully', FlasType.success, context);
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){
        print(value.toString());

      }
    }).onError((error, stackTrace){
      setSignUpLoading(false);
      Utils.showFlashBarMessage(error.toString(),FlasType.error, context);
      if(kDebugMode){
        print(error.toString());
      }

    });
  }

}