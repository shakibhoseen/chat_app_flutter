import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/res/app_url.dart';
import 'package:chat_app_flutter/res/components/active_user_design.dart';
import 'package:chat_app_flutter/res/components/my_shadow.dart';
import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:chat_app_flutter/utils/routes/routes_name.dart';
import 'package:chat_app_flutter/view_model/home/chat_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            final list = value.mapUserMsgList;
            return Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.green.shade200,
                      onTap: (){
                        Navigator.pushNamed(context, RoutesName.messageScreen, arguments: {'myId': '', 'otherId': ''});
                      },
                      child: itemChat(list.values.elementAt(index)));
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

Widget itemChat(UserModel model) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                model.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: -1,
              bottom: -3,
              child: ActiveUserDesign.activeUserContainer(
                model.isActive,
              ),
            ),
          ],
        ),
        addHoriztalSpace(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      model.username,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Constants.customTextStyle(
                          fontWeight: FontWeight.w600, textSize: TextSize.xl),
                    ),
                  ),
                  addHoriztalSpace(20),
                  Text(
                    'yesterday',
                    style: Constants.customTextStyle(
                        fontWeight: FontWeight.w400, textSize: TextSize.sm),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  model.lastMessage==null || model.lastMessage!.isUserSender
                      ? const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            FontAwesomeIcons.check,
                            color: Colors.grey,
                            size: 16,
                          ),
                        )
                      : Container(),
                  Expanded(
                    child: Text(
                      model.lastMessage!= null ? model.lastMessage!.lastMessage :  '',
                      style: Constants.customTextStyle(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  addHoriztalSpace(20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.green,
                      borderRadius: model.lastMessage != null
                          ? BorderRadius.circular(28)
                          : null,
                      border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 2),
                      boxShadow: MyShadow.boxShadow5(),
                    ),
                    child: Text(
                      "${model.lastMessage?.countMessage}",
                      style: Constants.customTextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
