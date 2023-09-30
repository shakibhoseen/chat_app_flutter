import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app_flutter/res/components/neu_box.dart';
import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:chat_app_flutter/utils/utils.dart';
import 'package:chat_app_flutter/view_model/services/splash_services.dart';
import 'package:chat_app_flutter/view_model/splash_view_model.dart';
import 'package:flutter/material.dart';

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
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome',
                style: Constants.customTextStyle(textSize: TextSize.xl),
              ),
              addVerticalSpace(20),

              LinearPercentIndicator(
                lineHeight: 10,
                percent: value.progress,
                linearGradient: const LinearGradient(colors: [
                  Colors.green,
                  Colors.orange,
                  Colors.pink,
                ]),
              ).addNeumorphism(),

              addVerticalSpace(20),
              FloatingActionButton(onPressed: () {
                _splashViewModel?.callIncrement();
                print('press...');
              }),
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
      );
    }));
  }
}
