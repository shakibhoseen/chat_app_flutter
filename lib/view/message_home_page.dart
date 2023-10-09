import 'dart:io';

import 'package:chat_app_flutter/model/chat_model.dart';
import 'package:chat_app_flutter/res/assets_name.dart';
import 'package:chat_app_flutter/res/components/my_shadow.dart';
import 'package:chat_app_flutter/res/design/message/message_design.dart';
import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:chat_app_flutter/view_model/home/chat_user_view_model.dart';
import 'package:chat_app_flutter/view_model/message/image_controler.dart';
import 'package:chat_app_flutter/view_model/upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessageHomePage extends StatefulWidget {
  final String myId, otherId;

  const MessageHomePage({super.key, required this.myId, required this.otherId});

  @override
  State<MessageHomePage> createState() => _MessageHomePageState();
}

class _MessageHomePageState extends State<MessageHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ImageController _imageController;



  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _imageController = ImageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uploadProvider = Provider.of<UploadViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green.shade200,
          image: const DecorationImage(
            image: AssetImage(
              AssetsName.lightBg,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Consumer<ChatUserViewModel>(
              builder: (context, value, child) {
                final userChats = value.mapUserCombMsgList[widget.otherId];

                return Expanded(
                  child: ListView.builder(
                    itemCount: userChats?.length ?? 0,
                    itemBuilder: (context, index) {
                      return rightMessage(userChats!.elementAt(index));
                    },
                  ),
                );
              },
            ),
            StreamBuilder<String>(
                stream: _imageController.getImageState(),
                builder: (context, snapshot) {
                  return Stack(
                    alignment: Alignment.bottomLeft,
                    clipBehavior: Clip.none,
                    children: [
                      bottomDesign(_imageController, snapshot.data ?? '', uploadProvider),
                      snapshot.data != ''
                          ? Positioned(
                              bottom: 60,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.file(
                                    File(snapshot.data ?? ''),
                                    width: 150,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}

Widget leftMessage(ChatModel model) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12)),
      boxShadow: MyShadow.boxShadow5(),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          model.message,
          style: Constants.customTextStyle(color: Colors.black),
        ),
        addHoriztalSpace(8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FontAwesomeIcons.check,
              size: 12,
              color: Colors.grey,
            ),
            Text(
              '12:04 AM',
              style: Constants.customTextStyle(textSize: TextSize.sm),
            )
          ],
        )
      ],
    ),
  );
}

String formatTimestampWithTime(DateTime timestamp) {
  final now = DateTime.now();
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final oneWeekAgo = DateTime(now.year, now.month, now.day - 7);

  String formattedDate;
  String formattedTime;

  if (timestamp.isAfter(now.subtract(const Duration(days: 1)))) {
    // Less than one day ago
    formattedDate = 'Today';
  } else if (timestamp.isAfter(yesterday)) {
    // Yesterday
    formattedDate = 'Yesterday';
  } else if (timestamp.isAfter(oneWeekAgo)) {
    // Within one week, return the day of the week
    formattedDate = DateFormat('EEEE').format(timestamp);
  } else {
    // More than one week ago, return the date in the format 'dd-MM-yyyy'
    formattedDate = DateFormat('dd-MM-yyyy').format(timestamp);
  }

  // Format time as hours:minutes AM/PM
  formattedTime = DateFormat.jm().format(timestamp);

  return '$formattedDate $formattedTime';
}
