import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/res/components/round_button.dart';
import 'package:chat_app_flutter/utils/routes/routes_name.dart';
import 'package:chat_app_flutter/utils/utils.dart';
import 'package:chat_app_flutter/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final  _obsecurePassword = ValueNotifier<bool>(true);

  final  _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  final _userFocusNode = FocusNode();
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
    _userFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SingUp'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usernameController,
              keyboardType: TextInputType.name,
              focusNode: _userFocusNode,
              decoration: const InputDecoration(
                  hintText: 'User Name',
                  labelText: 'User Name',
                  prefixIcon: Icon(FontAwesomeIcons.user)),
              onFieldSubmitted: (value) {
                Utils.fieldFocusChanged(context, _userFocusNode, _emailFocusNode);
              },
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: _emailFocusNode,
              decoration: const InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.alternate_email)),
              onFieldSubmitted: (valu) {
                Utils.fieldFocusChanged(
                    context, _emailFocusNode, _passwordFocusNode);
              },
            ),
            ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context, value, child) {
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
                          onTap: () {
                            _obsecurePassword.value = !_obsecurePassword.value;
                          },
                          child: Icon(_obsecurePassword.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility)),
                    ),
                  );
                }),
            SizedBox(
              height: height * .085,
            ),
            RoundButton(
              title: 'Sign Up',
              loading: authViewMode.signUpLoading,
              onPress: () {
                if (_usernameController.text.isEmpty) {
                  Utils.showFlashBarMessage(
                      'Please enter User name', FlasType.error, context);
                } else if (_emailController.text.isEmpty) {
                  Utils.showFlashBarMessage(
                      'Please enter email', FlasType.error, context);
                } else if (_passwordController.text.isEmpty) {
                  Utils.showFlashBarMessage(
                      'Please enter password', FlasType.error, context);
                } else if (_passwordController.text.length < 6) {
                  Utils.showFlashBarMessage(
                      'Please enter 6 digit password', FlasType.error, context);
                } else {
                  final userName = _usernameController.text;
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  final userModel = UserModel(
                      search: userName.toLowerCase(),
                      imageUrl: 'default',
                      id: 'id',
                      status: 'offline',
                      username: userName,
                      isActive: false);
                  authViewMode.signUpApi(email, password, userModel, context);
                  print('api hit');
                }
              },
            ),
            SizedBox(
              height: height * .02,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.login);
                },
                child: const Text("Already  have an account? Login"))
          ],
        ),
      ),
    );
  }
}
