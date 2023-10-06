import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/res/app_url.dart';
import 'package:chat_app_flutter/res/components/active_user_design.dart';
import 'package:chat_app_flutter/res/components/customTabBar.dart';
import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:chat_app_flutter/utils/routes/color_contant.dart';
import 'package:chat_app_flutter/utils/utils.dart';
import 'package:chat_app_flutter/view/page/chat_page.dart';
import 'package:chat_app_flutter/view_model/home/chat_user_view_model.dart';
import 'package:chat_app_flutter/view_model/home/home_tab_index_holder.dart';
import 'package:chat_app_flutter/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    call();
    super.initState();
  }

  void call() {
    Future.delayed(Duration(microseconds: 10), () {
      final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
      homeViewModel.getUserDetails(context);
      final chatViewModel =
      Provider.of<ChatUserViewModel>(context, listen: false);
      chatViewModel.getChatUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Consumer<HomeViewModel>(
            builder:
                (BuildContext context, HomeViewModel viewModel, Widget? child) {
              return Center(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    viewModel.currentUserModel?.imageUrl ??
                        AppUrl.defaultProfileImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          title: Consumer<HomeViewModel>(
            builder:
                (BuildContext context, HomeViewModel value, Widget? child) {
              print('flutter .... whats app build');
              return Text(
                "Whats up ${value.currentUserModel?.username}",
                style: Constants.customTextStyle(
                    textSize: TextSize.xl, color: Colors.white),
              );
            },
          ),
          actions: [
            PopupMenuButton(
                color: Colors.amber,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        Utils.showToastMessage('log out');
                        final home =
                            Provider.of<HomeViewModel>(context, listen: false);
                        home.setLoading(false);
                      },
                      child: const Text('Logout'),
                    ),
                    PopupMenuItem(child: Text('Setting')),
                    PopupMenuItem(child: Text('Privacy')),
                  ];
                }),
          ],
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 4,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.tealAccent,
            labelStyle: Constants.customTextStyle(
                textSize: TextSize.lg, color: Colors.white),
            tabs: [
              Container(
                width: 25,
                child: Tab(icon: Icon(Icons.camera_alt_outlined)),
              ),
              Container(
                width: 80,
                child: Tab(
                  child: Row(
                    children: [
                      Text('Chat', style: GoogleFonts.firaSans(fontSize: 16)),
                      addHoriztalSpace(7),
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                        child: Text(
                          '3',
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
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
        body: TabBarView(children: [
          page(),
          const ChatPage(),
          page(),
          page(),
        ]),
      ),
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
