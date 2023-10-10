import 'dart:io';

import 'package:chat_app_flutter/model/chat_model.dart';
import 'package:chat_app_flutter/res/assets_name.dart';
import 'package:chat_app_flutter/res/components/my_shadow.dart';
import 'package:chat_app_flutter/res/design/message/message_design.dart';
import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:chat_app_flutter/view_model/home/chat_user_view_model.dart';
import 'package:chat_app_flutter/view_model/message/image_controler.dart';
import 'package:chat_app_flutter/view_model/message/message_view_model.dart';
import 'package:chat_app_flutter/view_model/upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
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

  late TextEditingController messageController;
  String? selectedImagePath;
  late ChatUserViewModel chatUserprovider;

  late ScrollController _scrollController;

  void _removePic() {
    print('remove');
    _imageController.setImageState('');
  }

  void _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImagePath = pickedFile.path;
      _imageController.setImageState(selectedImagePath ?? '');
    }
    print('pic');
  }

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

  void _sendMessage() async {
    final messageText = messageController.text;
    if (messageText.isEmpty && selectedImagePath == null) {
      // Don't send empty messages
      return;
    }

    String url = _imageController.getImageUrl;
    String? imageUrl;
    if (url != '') {
      print('path $url');
      imageUrl = await UploadViewModel().uploadImage(url);
    }

    MessageViewModel().setMessageToFirebase(
        message: messageText,
        receiver: widget.otherId,
        sender: widget.myId,
        chatUserProvider: chatUserprovider);

    // Send the message with the text and selected image path
    // You can use the messageText and selectedImagePath variables here

    // Clear the message text field and selected image path
    messageController.clear();
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
    Future.delayed(Duration(milliseconds: 200), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
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
                addChatMessage();
                return Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: userChats?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return designMessage(userChats!.elementAt(index),
                            _resendMessage, false, 0, true);
                      }
                      final oldModel = userChats!.elementAt(index - 1);
                      final newModel = userChats!.elementAt(index);
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
                          pickImageFromGallery: _pickImageFromGallery,
                          removePic: _removePic,
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
