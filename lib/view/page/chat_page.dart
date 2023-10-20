import 'package:chat_app_flutter/res/custom_design/user_item_design.dart';
import 'package:chat_app_flutter/utils/routes/routes_name.dart';
import 'package:chat_app_flutter/utils/utils.dart';
import 'package:chat_app_flutter/view_model/home/chat_user_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<ChatUserViewModel>(
          builder:
              (BuildContext context, ChatUserViewModel value, Widget? child) {
            final list = value.mapUserMsg;
            return Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      splashColor: Colors.green.shade200,
                      onTap: () {
                        final id = FirebaseAuth.instance.currentUser?.uid;
                        if (id == null) {
                          Utils.showToastMessage('Authentication problem');
                          return;
                        }
                        Navigator.pushNamed(context, RoutesName.messageScreen,
                            arguments: {
                              'myId': id,
                              'otherId': list.values.elementAt(index).id
                            });
                      },
                      child: UserItemDesign(
                          userModel: list.values.elementAt(index),
                          isLastMessage: true));
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
