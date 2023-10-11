import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/res/assets_name.dart';
import 'package:chat_app_flutter/res/components/active_user_design.dart';
import 'package:chat_app_flutter/res/components/my_shadow.dart';
import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget UserItemDesign({required UserModel userModel, isLastMessage = false}) {
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
              child: userModel.imageUrl=='default' ? Image.asset(AssetsName.profileBg, fit: BoxFit.cover,) : Image.network(
                userModel.imageUrl,
                fit: BoxFit.cover,
              ),
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
                    'yesterday',
                    style: Constants.customTextStyle(
                        fontWeight: FontWeight.w400, textSize: TextSize.sm),
                  ),
                ],
              ),
              if (isLastMessage)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    userModel.lastMessage == null ||
                            userModel.lastMessage!.isUserSender
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
                        userModel.lastMessage != null
                            ? userModel.lastMessage!.lastMessage
                            : '',
                        style: Constants.customTextStyle(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    addHoriztalSpace(20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 1),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.green,
                        borderRadius: userModel.lastMessage != null
                            ? BorderRadius.circular(28)
                            : null,
                        border: Border.all(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 2),
                        boxShadow: MyShadow.boxShadow5(),
                      ),
                      child: Text(
                        "${userModel.lastMessage?.countMessage}",
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
