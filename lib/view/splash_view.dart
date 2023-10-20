import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app_flutter/res/assets_name.dart';
import 'package:chat_app_flutter/res/components/my_shadow.dart';
import 'package:chat_app_flutter/res/components/neu_box.dart';
import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:chat_app_flutter/utils/utils.dart';
import 'package:chat_app_flutter/view_model/services/splash_services.dart';
import 'package:chat_app_flutter/view_model/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashServices _splashServices = SplashServices();
  SplashViewModel? _splashViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _splashViewModel = Provider.of<SplashViewModel>(context, listen: false);
    if (_splashViewModel != null) {
      _splashServices.start(context, _splashViewModel!);
    } else {
      Utils.showFlashBarMessage('Initialize problem', FlasType.error, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<SplashViewModel>(builder: (context, value, _) {
      return Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AssetsName.darkBg), fit: BoxFit.cover),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome',
                  style: Constants.customTextStyle(
                      textSize: TextSize.xl, fontWeight: FontWeight.bold),
                ),
                addVerticalSpace(10),
                Icon(
                  FontAwesomeIcons.whatsapp,
                  //color: Colors.green.shade600,
                  size: 55,
                ),
                addVerticalSpace(30),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.rectangle,
                    boxShadow: MyShadow.boxShadow5(),
                  ),
                  child: LinearPercentIndicator(
                    lineHeight: 10,
                    percent: value.progress,
                    linearGradient: const LinearGradient(colors: [
                      Colors.green,
                      Colors.orange,
                      Colors.pink,
                    ]),
                  ),
                ),

                addVerticalSpace(20),

                // Add any additional text or animation
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText('Loading...',
                        textStyle: Constants.customTextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            textSize: TextSize.lg)),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}
