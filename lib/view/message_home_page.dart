import 'package:chat_app_flutter/res/assets_name.dart';
import 'package:chat_app_flutter/res/components/my_shadow.dart';
import 'package:chat_app_flutter/res/custom_design/message_shape.dart';
import 'package:chat_app_flutter/res/custom_design/whats_app_message_item.dart';
import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          //color: Colors.green.shade200,
          image: const DecorationImage(
            image: AssetImage(
              AssetsName.lightBg,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            addVerticalSpace(20),
            addVerticalSpace(20),
            addVerticalSpace(20),
            Container(
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
                    'message page my Id ${widget.myId}',
                    style: Constants.customTextStyle(color: Colors.black),
                  ),
                  addHoriztalSpace(8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
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
            ),
            addVerticalSpace(40),
            MessageShape(
                shadowColor: const Color.fromRGBO(244, 67, 54, 1),
                backgroundColor: Colors.transparent,
                elevation: 10,
                child: Container(
                  //padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      image: DecorationImage(
                          image: AssetImage(AssetsName.lightBg),
                          fit: BoxFit.cover)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text('ok bro i am coming ok'),
                  ),
                )),
            addVerticalSpace(40),
            Container(
              width: 220,
              constraints: BoxConstraints(maxWidth: 220),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                image: DecorationImage(
                    image: AssetImage(
                      AssetsName.darktBg,
                    ),
                    opacity: 0.7,
                    fit: BoxFit.cover),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(12)),
                boxShadow: MyShadow.boxShadow5(),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'message page my Id ${widget.myId}message page my Id ${widget.myId} message page my Id ${widget.myId} message page my Id ${widget.myId}',
                    style: Constants.customTextStyle(color: Colors.black),
                  ),
                  addHoriztalSpace(8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
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
            ),
          ],
        ),
      ),
    );
  }
}
