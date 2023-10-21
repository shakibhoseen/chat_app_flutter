import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/res/assets_name.dart';
import 'package:chat_app_flutter/res/components/active_user_design.dart';
import 'package:chat_app_flutter/res/components/my_shadow.dart';
import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/date_custom.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:chat_app_flutter/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget UserItemDesign({required UserModel userModel, isLastMessage = false}) {
  final time = DateCustom().formatTimestampWithTime(
      userModel.lastMessage?.publish ?? DateTime.now().microsecondsSinceEpoch);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
              child: Utils.profileImage(userModel.imageUrl),
            ),
            if (isLastMessage)
              Positioned(
                right: -1,
                bottom: -3,
                child: ActiveUserDesign.activeUserContainer(
                  userModel.isActive,
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
                      userModel.username,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Constants.customTextStyle(
                          fontWeight: FontWeight.w600, textSize: TextSize.xl),
                    ),
                  ),
                  addHoriztalSpace(20),
                  if (isLastMessage)
                    Text(
                      time.dateCompare != 'Today'
                          ? time.dateCompare
                          : time.hourMinute,
                      style: Constants.customTextStyle(
                          fontWeight: FontWeight.w400, textSize: TextSize.sm),
                    ),
                ],
              ),
              if (isLastMessage)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    userModel.lastMessage != null
                        ? msgUserIndentIcon(userModel.lastMessage!)
                        : Container(),
                    Expanded(
                      child: Text(
                        userModel.lastMessage != null
                            ? userModel.lastMessage!.lastMessage
                            : '',
                        style: Constants.customTextStyle(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    addHoriztalSpace(20),
                    if (isLastMessage)
                      msgUserCountNumber(userModel.lastMessage!),
                  ],
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget msgUserCountNumber(LastMessage lastMessage) {
  if (lastMessage.isUserSender || lastMessage.countMessage == 0) {
    return Container();
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.green,
      borderRadius: lastMessage != null ? BorderRadius.circular(28) : null,
      border:
          Border.all(color: Colors.white, style: BorderStyle.solid, width: 2),
      boxShadow: MyShadow.boxShadow5(),
    ),
    child: Text(
      "${lastMessage.countMessage}",
      style: Constants.customTextStyle(color: Colors.white),
    ),
  );
}

Widget msgUserIndentIcon(LastMessage lastMessage) {
  if (lastMessage.isUserSender) {
    // thats  means i sent last message and have many count or not
    if (lastMessage.countMessage > 0) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Icon(
          FontAwesomeIcons.check,
          color: Colors.grey,
          size: 16,
        ),
      );
    }
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(
        FontAwesomeIcons.checkDouble,
        color: Colors.green,
        size: 16,
      ),
    );
  }
  return Container();
}
