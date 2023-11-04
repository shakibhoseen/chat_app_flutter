import 'package:chat_app_flutter/utils/constants.dart';
import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:chat_app_flutter/utils/utils.dart';
import 'package:chat_app_flutter/view/page/chat_page.dart';
import 'package:chat_app_flutter/view/page/profile_page.dart';
import 'package:chat_app_flutter/view/page/user_page.dart';
import 'package:chat_app_flutter/view_model/home/chat_user_view_model.dart';
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
    Future.delayed(const Duration(microseconds: 10), () {
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
      initialIndex: 1,
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
                  child:
                      Utils.profileImage(viewModel.currentUserModel?.imageUrl),
                ),
              );
            },
          ),
          title: Consumer<HomeViewModel>(
            builder:
                (BuildContext context, HomeViewModel value, Widget? child) {
              return Row(
                children: [
                  Text(
                    value.currentUserModel?.username ??'',
                    style: Constants.customTextStyle(
                        textSize: TextSize.xl,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  addHoriztalSpace(6),
                  const Icon(FontAwesomeIcons.whatsapp),
                ],
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
                        home.logOut(context);
                      },
                      child: const Text('Logout'),
                    ),
                    const PopupMenuItem(child: Text('Setting')),
                    const PopupMenuItem(child: Text('Privacy')),
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
              const SizedBox(
                width: 25,
                child: Tab(icon: Icon(Icons.camera_alt_outlined)),
              ),
              SizedBox(
                width: 80,
                child: Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Chat', style: GoogleFonts.firaSans(fontSize: 16)),
                      Consumer<ChatUserViewModel>(
                        builder: (BuildContext context, ChatUserViewModel value,
                            Widget? child) {
                          final int count = value.actualNotificationCount();
                          if (count == 0) return Container();
                          return Row(
                            children: [
                              addHoriztalSpace(7),
                              Container(
                                padding: const EdgeInsets.all(7),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green),
                                child: Text(
                                  '$count',
                                  style: GoogleFonts.poppins(fontSize: 12),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 85,
                child: Tab(
                  text: 'Users',
                ),
              ),
              const SizedBox(
                width: 85,
                child: Tab(
                  text: 'Profile',
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          page(),
          const ChatPage(),
          const UserPage(),
          const ProfilePage(),
        ]),
      ),
    );
  }
}

Widget page() {
  return const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: Icon(
            Icons.camera_alt_outlined,
            color: Colors.grey,
            size: 100,
          ),
        ),
      )
    ],
  );
}
