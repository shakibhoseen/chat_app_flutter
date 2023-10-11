import 'dart:io';

import 'package:chat_app_flutter/model/chat_model.dart';
import 'package:chat_app_flutter/res/app_url.dart';
import 'package:chat_app_flutter/res/assets_name.dart';
import 'package:chat_app_flutter/res/components/my_shadow.dart';
import 'package:chat_app_flutter/res/image_network.dart';
import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:chat_app_flutter/utils/routes/color_contant.dart';
import 'package:chat_app_flutter/view_model/home/chat_user_view_model.dart';
import 'package:chat_app_flutter/view_model/message/image_controler.dart';
import 'package:chat_app_flutter/view_model/upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

Widget bottomDesign(
    {required String value,
    required Function pickImageFromGallery,
    required Function removePic,
    required Function sendMessage,
    required TextEditingController messageController}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: MyShadow.boxShadow4()),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  addHoriztalSpace(7),
                  IconButton(
                    onPressed: () {
                      if (value == '') {
                        pickImageFromGallery();
                      } else {
                        removePic();
                      }
                    },
                    icon: Icon(
                      value == '' ? Icons.image : Icons.cancel_outlined,
                      color: Colors.blue,
                    ),
                  ),
                  addHoriztalSpace(6),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      style: Constants.customTextStyle(),
                      decoration: InputDecoration(
                        hintText: 'Message',
                        hintStyle: Constants.customTextStyle(),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Consumer<UploadViewModel>(
                    builder: (context, value, child) {
                      String text = 'init ';
                      if (value.status == UploadStatus.running)
                        text = 'running';
                      else if (value.status == UploadStatus.success)
                        text = 'success';
                      return Text(
                        '${value.progress} $text',
                        style: Constants.customTextStyle(textSize: TextSize.sm),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: 50,
          child: FloatingActionButton(
            shape: const CircleBorder(side: BorderSide(color: Colors.white)),
            onPressed: () {
              sendMessage();
            },
            child: const Icon(
              Icons.send,
              color: primaryColor,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget designMessage(ChatModel model, Function resentMessage, bool isCompare, int before, bool todayIndicator) {
  return Column(
    children: [
      if(isCompare) showTimeOrNot(before, model.publish),
      if(todayIndicator) Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.green.shade400, Colors.green.shade700]
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: MyShadow.boxShadow5(),
          image: const DecorationImage(
            image: AssetImage(AssetsName.lightBg),
            fit: BoxFit.cover,
          )
        ),
        child: Text('${model.timeStamp?.dateCompare}', style: Constants.customTextStyle(textSize: TextSize.sm,  fontWeight: FontWeight.w600),),
      ),
      if(todayIndicator) addVerticalSpace(20),
      Align(
        alignment: model.isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
             if(model.isFailed?? false) IconButton(
                 iconSize: 24,
                 onPressed: () {
                   resentMessage(model);
                 },
                 icon: const Icon(
                   Icons.error,
                   color: Colors.red,
                 )),
              Container(
                constraints: const BoxConstraints(maxWidth: 240),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color:
                      model.isSender ? Colors.red.shade400 : Colors.grey.shade100,
                  image: const DecorationImage(
                      image: AssetImage(
                        AssetsName.darkBg,
                      ),
                      opacity: 0.7,
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      topLeft: model.isSender
                          ? const Radius.circular(20)
                          : const Radius.circular(0),
                      topRight: model.isSender
                          ? const Radius.circular(0)
                          : const Radius.circular(20),
                      bottomLeft: model.isSender
                          ? const Radius.circular(20)
                          : const Radius.circular(12),
                      bottomRight: model.isSender
                          ? const Radius.circular(12)
                          : const Radius.circular(20)),
                  boxShadow: MyShadow.boxShadow5(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    model.imageUrl != null && model.imageUrl != ''
                        ? model.isSend ?? false || model.imageUrl!.contains('http') ? ImageNetwork().networkImage(
                            model.imageUrl ?? AppUrl.defaultProfileImageUrl) :
                        Image.file(File(model.imageUrl ??''))
                        : Container(
                            width: 10,
                          ),
                    Flex(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      direction: model.message.length > 18
                          ? Axis.vertical
                          : Axis.horizontal,
                      children: [
                        Text(
                          model.message,
                          overflow: TextOverflow.clip,
                          style: Constants.customTextStyle(color: Colors.black),
                        ),
                        addHoriztalSpace(8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            model.isSend ?? false
                                ? const Icon(
                                    FontAwesomeIcons.check,
                                    size: 12,
                                    color: Colors.grey,
                                  )
                                : Container(),
                            Text(
                              '${model.timeStamp?.hourMinute}',
                              style: Constants.customTextStyle(
                                  textSize: TextSize.sm, color: Colors.blueGrey),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget showTimeOrNot(int before, int after) {

  int difference = (before - after).abs();

  if (difference < 3600000) { // Less than an hour
    if (difference < 600000) { // Less than 10 minutes
      return addVerticalSpace(3); // Tiny
    } else {
      return addVerticalSpace(24); // Mid-sized
    }
  } else {
    return addVerticalSpace(32); // Big
  }
}


