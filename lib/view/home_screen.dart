import 'package:chat_app_flutter/res/components/customTabBar.dart';
import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:chat_app_flutter/utils/routes/color_contant.dart';
import 'package:chat_app_flutter/view_model/home/home_tab_index_holder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeTabIndexHolder indexHolder = HomeTabIndexHolder();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final userPrefernece = Provider.of<UserViewModel>(context);
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              InkWell(
                  onTap: () {
                    // userPrefernece.remove().then((value){
                    //   Navigator.pushNamed(context, RoutesName.login);
                    // });
                  },
                  child: const Center(child: Text('Logout'))),
              const SizedBox(
                width: 20,
              )
            ],
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 4,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: Constants.customTextStyle(),
              tabs: [
                Container(
                  width: 25,
                  child: Tab(icon: Icon(Icons.camera)),
                ),
                Container(
                  width: 80,
                  child: Tab(
                    child: Row(
                      children: [
                        Text(
                          'Chat',
                          style: Constants.customTextStyle(),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 85,
                  child: Tab(
                    text: 'Chat',
                  ),
                ),
                Container(
                  width: 85,
                  child: Tab(
                    text: 'Chat',
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [],
          )),
    );
  }
}

Widget page() {
  return Column(
    children: [
      Container(
        child: const Text('Welcome to homeScreen'),
      ),
      addVerticalSpace(20),
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Color(0xFFEBDDFF),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, offset: Offset(2, 2), blurRadius: 10)
            ]),
        child: const Text('cardColor'),
      ),
      addVerticalSpace(20),
      FloatingActionButton(
        onPressed: () {},
        hoverColor: Colors.transparent,
        child: const Icon(Icons.self_improvement_sharp),
      ),
    ],
  );
}
