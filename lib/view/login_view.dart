import 'package:chat_app_flutter/res/components/round_button.dart';
import 'package:chat_app_flutter/utils/routes/routes_name.dart';
import 'package:chat_app_flutter/utils/utils.dart';
import 'package:chat_app_flutter/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _obsecurePassword = ValueNotifier<bool>(true);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    _obsecurePassword.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);

    final height  = MediaQuery.of(context).size.height * 1 ;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: _emailFocusNode,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.alternate_email)
                ),
                onFieldSubmitted: (valu){
                  Utils.fieldFocusChanged(context, _emailFocusNode, _passwordFocusNode);
                },
              ),
              ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (context , value, child){
                    return TextFormField(
                      controller: _passwordController,
                      obscureText: _obsecurePassword.value,
                      focusNode: _passwordFocusNode,
        
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_open_rounded),
                        suffixIcon: InkWell(
                            onTap: (){
                              _obsecurePassword.value = !_obsecurePassword.value ;
                            },
                            child: Icon(
                                _obsecurePassword.value ?  Icons.visibility_off_outlined :
                                Icons.visibility
                            )),
                      ),
                    );
        
                  }
              ),
              SizedBox(height: height * .085,),
              RoundButton(
                title: 'Login',
                loading: authViewMode.loading,
                onPress: (){
                  if(_emailController.text.isEmpty){
        
                    Utils.showFlashBarMessage('Please enter email',FlasType.error, context);
                  }else if(_passwordController.text.isEmpty){
                    Utils.showFlashBarMessage('Please enter password', FlasType.error,context);
        
                  }else if(_passwordController.text.length < 6){
                    Utils.showFlashBarMessage('Please enter 6 digit password',FlasType.error, context);
        
                  }else {
        
        
                    Map data = {
                      'email' : _emailController.text.toString(),
                      'password' : _passwordController.text.toString(),
                    };
        
                    // Map data = {
                    //   'email' : 'eve.holt@reqres.in',
                    //   'password' : 'cityslicka',
                    // };
        
                    authViewMode.loginApi(data['email'], data['password'] , context);
                  
                  }
                },
              ),
              SizedBox(height: height * .02,),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.signUp);
                },
                  child: const Text("Don't have an accont? Sign Up"))
        
            ],
          ),
        ),
      ),
    );
  }

}
