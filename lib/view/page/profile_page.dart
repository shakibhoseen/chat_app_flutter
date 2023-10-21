import 'dart:async';

import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/res/app_url.dart';
import 'package:chat_app_flutter/res/assets_name.dart';
import 'package:chat_app_flutter/res/components/blur.dart';
import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:chat_app_flutter/utils/routes/color_contant.dart';
import 'package:chat_app_flutter/utils/utils.dart';
import 'package:chat_app_flutter/view_model/home_view_model.dart';
import 'package:chat_app_flutter/view_model/message/image_controler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child:
                    Utils.profileImage(value.currentUserModel?.imageUrl ?? ''),
              ),
              addVerticalSpace(20),
              Text(
                value.currentUserModel?.username ?? '',
                style: Constants.customTextStyle(
                    fontWeight: FontWeight.w600, textSize: TextSize.xl),
              ),
              Text(
                AppUrl.policyText,
                style: Constants.customTextStyle(
                    fontWeight: FontWeight.w300, textSize: TextSize.sm),
                textAlign: TextAlign.center,
              ),
              addVerticalSpace(20),
              ElevatedButton(
                  onPressed: () {
                    openDialogBox(context, value.currentUserModel);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple
                        .shade50, // Change the background color to your preferred color
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        FontAwesomeIcons.arrowsRotate,
                        color: primaryColor,
                      ),
                      addHoriztalSpace(8),
                      Text(
                        'update information',
                        style: Constants.customTextStyle(),
                      ),
                    ],
                  ))
            ],
          ),
        );
      },
    );
  }
}

Object openDialogBox(BuildContext context, UserModel? model) {
  if (model == null) {
    Utils.showToastMessage('user not found');
    return 0;
  }

  String urlFromOnline = model.imageUrl;
  if (model.imageUrl == 'default' || model.imageUrl == '') {
    urlFromOnline = '';
  }
  TextEditingController nameController = TextEditingController();
  ImageController imageController = ImageController();
  nameController.text = model.username;

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                addVerticalSpace(40),
                Text(
                  'Update your Bio',
                  style: Constants.customTextStyle(
                      fontWeight: FontWeight.bold, textSize: TextSize.lg),
                ),
                addVerticalSpace(12),
                getTextInput(nameController, 'Your Name'),
                addVerticalSpace(20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.deepPurple.shade50,
                      shadowColor: Colors.deepPurple,
                      elevation: 3,
                    ),
                    onPressed: () {},
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Text(
                        'Save',
                        style: Constants.customTextStyle(
                            color: Colors.deepPurple.shade50,
                            textSize: TextSize.lg,
                            fontWeight: FontWeight.bold),
                      ),
                      //addHoriztalSpace(6),
                      // SizedBox(
                      //   height: 20,
                      //   width: 20,
                      //   child: CircularProgressIndicator(
                      //     color: Colors.deepPurple.shade50,
                      //     strokeCap: StrokeCap.round ,
                      //     strokeWidth: 2,
                      //   ),
                      // ),
                    ])),
              ],
            ),
            Positioned(
              top: -65,
              child: StreamBuilder<String>(
                  initialData: '',
                  stream: imageController.getImageState(),
                  builder: (context, snapshot) {
                    bool isFile = false;
                    String url = urlFromOnline;
                    if (snapshot.data != '') {
                      isFile = true;
                      url = snapshot.data ?? '';
                    }
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.green, width: 2),
                          ),
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors
                                  .white, // Background color for the circular border
                            ),
                            child: Utils.profileImage(url, isFile: isFile),
                          ),
                        ),
                        Positioned(
                          child: Blur(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Icon(
                                FontAwesomeIcons.penToSquare,
                                size: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            )
          ],
        ),
      );
    },
  ).then((value) {
    nameController.dispose();
    imageController.dispose();
  });
}

Widget getTextInput(TextEditingController controller, String hintText) {
  return TextField(
    controller: controller,
    style: Constants.customTextStyle(),
    decoration: InputDecoration(
      hintText: hintText,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            strokeAlign: BorderSide.strokeAlignInside, color: Colors.grey),
        borderRadius: BorderRadius.circular(18),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            strokeAlign: BorderSide.strokeAlignInside, color: Colors.green),
        borderRadius: BorderRadius.circular(18),
      ),
    ),
  );
}
