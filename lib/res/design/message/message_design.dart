import 'package:chat_app_flutter/model/chat_model.dart';
import 'package:chat_app_flutter/res/app_url.dart';
import 'package:chat_app_flutter/res/assets_name.dart';
import 'package:chat_app_flutter/res/components/my_shadow.dart';
import 'package:chat_app_flutter/res/image_network.dart';
import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:chat_app_flutter/utils/routes/color_contant.dart';
import 'package:chat_app_flutter/view_model/message/image_controler.dart';
import 'package:chat_app_flutter/view_model/upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

Widget bottomDesign(ImageController imageController, String value, UploadViewModel uploadProvider) {
  final TextEditingController messageController = TextEditingController();
  String? selectedImagePath;

  void _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImagePath = pickedFile.path;
      imageController.setImageState(selectedImagePath ?? '');
    }
    print('pic');
  }

  void _removePic() {
    print('remove');
    imageController.setImageState('');
  }

  void _sendMessage() async{
    final messageText = messageController.text;
    if (messageText.isEmpty && selectedImagePath == null) {
      // Don't send empty messages
      return;
    }

    String url = imageController.getImageUrl;
    String? imageUrl;
    if(url!='' ){
      print('path $url');
     imageUrl = await UploadViewModel().uploadImage(url);
    }
    print('flutter');
    print('image url ..........  $imageUrl');
    print('flutter');
    // Send the message with the text and selected image path
    // You can use the messageText and selectedImagePath variables here

    // Clear the message text field and selected image path
    messageController.clear();
    // setState(() {
    //   selectedImagePath = null;
    // });
  }

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
                        _pickImageFromGallery();
                      } else {
                        _removePic();
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
            onPressed: _sendMessage,
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
                ? ImageNetwork().networkImage(
                    model.imageUrl ?? AppUrl.defaultProfileImageUrl)
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
