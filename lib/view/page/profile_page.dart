import 'package:chat_app_flutter/res/app_url.dart';
import 'package:chat_app_flutter/res/assets_name.dart';
import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:chat_app_flutter/utils/routes/color_contant.dart';
import 'package:chat_app_flutter/view_model/home_view_model.dart';
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
              value.currentUserModel != null
                  ? Container(
                      clipBehavior: Clip.antiAlias,
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        value.currentUserModel!.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      clipBehavior: Clip.antiAlias,
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        AssetsName.profileBg,
                        fit: BoxFit.cover,
                      ),
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
                  onPressed: () {},
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
