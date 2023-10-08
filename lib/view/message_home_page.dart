import 'package:chat_app_flutter/model/chat_model.dart';
import 'package:chat_app_flutter/res/app_url.dart';
import 'package:chat_app_flutter/res/assets_name.dart';
import 'package:chat_app_flutter/res/components/my_shadow.dart';
import 'package:chat_app_flutter/res/custom_design/message_shape.dart';
import 'package:chat_app_flutter/res/custom_design/whats_app_message_item.dart';
import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:chat_app_flutter/utils/routes/color_contant.dart';
import 'package:chat_app_flutter/view_model/home/chat_user_view_model.dart';
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                print("ok print ${userChats?.elementAt(0).message} ");
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
            bottomDesign(),
          ],
        ),
      ),
    );
  }
}

Widget bottomDesign() {
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.emoji_emotions,
                      color: Colors.red,
                    ),
                  ),
                  addHoriztalSpace(6),
                  Expanded(
                      child: TextField(
                    style: Constants.customTextStyle(),
                    decoration: InputDecoration(
                      hintText: 'message',
                      hintStyle: Constants.customTextStyle(),
                      border: InputBorder.none,
                    ),
                  )),
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
            onPressed: () {},
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

Widget rightMessage(ChatModel model) {
  return Align(
    alignment: model.isSender ? Alignment.centerRight : Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 240),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: model.isSender ? Colors.red.shade400 : Colors.grey.shade100,
          image: const DecorationImage(
              image: AssetImage(
                AssetsName.darktBg,
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
                ? Image.network(model.imageUrl ?? AppUrl.defaultProfileImageUrl)
                : Container(
                    width: 10,
                  ),
            Flex(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              direction:
                  model.message.length > 18 ? Axis.vertical : Axis.horizontal,
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
                    const Icon(
                      FontAwesomeIcons.check,
                      size: 12,
                      color: Colors.grey,
                    ),
                    Text(
                      '12:04 AM',
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
    ),
  );
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
