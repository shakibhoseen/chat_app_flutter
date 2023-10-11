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
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  FocusNode userFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    userFocusNode.dispose();

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
              focusNode: userFocusNode,
              decoration: const InputDecoration(
                  hintText: 'User Name',
                  labelText: 'User Name',
                  prefixIcon: Icon(FontAwesomeIcons.user)),
              onFieldSubmitted: (value) {
                Utils.fieldFocusChanged(context, userFocusNode, emailFocusNode);
              },
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: const InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.alternate_email)),
              onFieldSubmitted: (valu) {
                Utils.fieldFocusChanged(
                    context, emailFocusNode, passwordFocusNode);
              },
            ),
            ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    obscureText: _obsecurePassword.value,
                    focusNode: passwordFocusNode,
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
