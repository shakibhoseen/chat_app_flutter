

import 'package:chat_app_flutter/data/network/base_api_services.dart';
import 'package:chat_app_flutter/data/network/network_api_services.dart';

class AuthRepository  {

  BaseApiServices _apiServices = NetworkApiServices() ;


  Future<dynamic> loginApi(String email, String password)async{

    try{

      dynamic response = await _apiServices.logInResponse(email, password);
      return response ;

    }catch(e){
      rethrow ;
    }
  }

  Future<dynamic> signUpApi(String email, String password)async{

    try{

      dynamic response = await _apiServices.signUpResponse(email, password);
      return response ;


    }catch(e){
      rethrow ;
    }
  }

}