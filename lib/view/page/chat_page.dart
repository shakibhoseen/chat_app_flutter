import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/res/app_url.dart';
import 'package:chat_app_flutter/res/components/active_user_design.dart';
import 'package:chat_app_flutter/res/components/my_shadow.dart';
import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(child: Text('Chat page')),
        addVerticalSpace(20),
        itemChat(UserModel(
            search: '',
            imageUrl: AppUrl.defaultProfileImageUrl,
            id: '',
            status: '',
            username: 'Maliha',
            lastMessage:
                LastMessage(lastMessage: "tme kokn asbe?", isUserSender: true),
            isActive: true)),
        itemChat(UserModel(
            search: '',
            imageUrl: AppUrl.defaultProfileImageUrl,
            id: '',
            status: '',
            username: 'Ruhan',
            lastMessage:
                LastMessage(lastMessage: 'I am here', isUserSender: false),
            isActive: true)),
        itemChat(
          UserModel(
              search: '',
              imageUrl: AppUrl.defaultProfileImageUrl,
              id: '',
              status: '',
              username: 'Baba',
              lastMessage: LastMessage(
                  lastMessage:
                      'baba i love you so much, Allah tmk jannat basi korun Ameen ',
                  isUserSender: true),
              isActive: false),
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
                  model.lastMessage!.isUserSender
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
                      model.lastMessage!.lastMessage,
                      style: Constants.customTextStyle(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  addHoriztalSpace(20),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                      border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 2),
                      boxShadow: MyShadow.boxShadow5(),
                    ),
                    child: Text(
                      '8',
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
