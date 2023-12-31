import 'dart:io';

import 'package:chat_app_flutter/model/chat_model.dart';
import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/res/app_url.dart';
import 'package:chat_app_flutter/res/assets_name.dart';
import 'package:chat_app_flutter/res/design/message/message_design.dart';
import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:chat_app_flutter/view_model/home/chat_user_view_model.dart';
import 'package:chat_app_flutter/view_model/message/image_controler.dart';
import 'package:chat_app_flutter/view_model/message/message_view_model.dart';
import 'package:flutter/material.dart';
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

  late TextEditingController messageController;
  String? selectedImagePath;
  late ChatUserViewModel chatUserprovider;

  late ScrollController _scrollController;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _imageController = ImageController();
    messageController = TextEditingController();
    chatUserprovider = Provider.of<ChatUserViewModel>(context, listen: false);
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Scroll to the end of the list after the frame is built
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  void _seenMessage(ChatModel model) {
    if (model.isSender) return;
    MessageViewModel().setSeenMessage(model);
  }

  void _sendMessage() async {
    final messageText = messageController.text;
    if (messageText.isEmpty && selectedImagePath == null) {
      // Don't send empty messages
      return;
    }

    String url = _imageController.getImageUrl;
    String? imageUrl;
    if (url != '') {
      imageUrl = url;
    }

    MessageViewModel().setMessageToFirebase(
        message: messageText,
        receiver: widget.otherId,
        sender: widget.myId,
        imageUrl: imageUrl,
        chatUserProvider: chatUserprovider);

    // Send the message with the text and selected image path
    // You can use the messageText and selectedImagePath variables here

    // Clear the message text field and selected image path
    messageController.clear();
    _imageController.removePic();
    // setState(() {
    //   selectedImagePath = null;
    // });
  }

  Future<void> _resendMessage(ChatModel chatModel) async {
    if (chatModel.message.isEmpty) {
      // Don't send empty messages
      return;
    }

    // String url = _imageController.getImageUrl;
    // String? imageUrl;
    // if (url != '') {
    //   print('path $url');
    //   imageUrl = await UploadViewModel().uploadImage(url);
    // }

    MessageViewModel().setMessageToFirebase(
        chatid: chatModel.id,
        message: chatModel.message,
        receiver: chatModel.receiver,
        sender: chatModel.sender,
        chatUserProvider: chatUserprovider);
  }

  Future<void> addChatMessage() async {
    Future.delayed(const Duration(milliseconds: 200), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    // Scroll to the newly added message
  }

  @override
  void dispose() {
    _controller.dispose();
    _imageController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: FutureBuilder<UserModel>(
          builder: (context, snapshot) {
            return Row(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: snapshot.data?.imageUrl != 'default'
                      ? Image.network(
                          snapshot.data?.imageUrl ??
                              AppUrl.defaultProfileImageUrl,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          AssetsName.profileBg,
                          fit: BoxFit.cover,
                        ),
                ),
                addHoriztalSpace(10),
                Text(
                  snapshot.data?.username ?? '',
                  style: Constants.customTextStyle(
                      color: Colors.white,
                      textSize: TextSize.xl,
                      fontWeight: FontWeight.bold),
                )
              ],
            );
          },
          future: Provider.of<ChatUserViewModel>(context, listen: false)
              .getUniqueUserData(widget.otherId),
        ),
      ),
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
                addChatMessage();
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 8),
                    controller: _scrollController,
                    itemCount: userChats?.length ?? 0,
                    itemBuilder: (context, index) {
                      _seenMessage(userChats!.elementAt(index));
                      if (index == 0) {
                        return designMessage(userChats.elementAt(index),
                            _resendMessage, false, 0, true);
                      }
                      final oldModel = userChats.elementAt(index - 1);
                      final newModel = userChats.elementAt(index);
                      bool todayIndicator = false;
                      if (oldModel.timeStamp?.dateCompare == null ||
                          newModel.timeStamp?.dateCompare == null) {
                        todayIndicator = false;
                      } else if (oldModel.timeStamp?.dateCompare !=
                          newModel.timeStamp?.dateCompare) {
                        todayIndicator = true;
                      }
                      return designMessage(newModel, _resendMessage, true,
                          oldModel.publish, todayIndicator);
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
                      bottomDesign(
                          value: snapshot.data ?? '',
                          messageController: messageController,
                          pickImageFromGallery: _imageController.pickImageFromGallery,
                          removePic: _imageController.removePic,
                          sendMessage: _sendMessage),
                      snapshot.data != '' && snapshot.data != null
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
