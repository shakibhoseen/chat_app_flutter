import 'package:chat_app_flutter/utils/helper_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final userPrefernece = Provider.of<UserViewModel>(context);
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
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
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Home',
              icon: Icon(
                Icons.home,
                color: Colors.green,
              ),
            ),
            Tab(
              text: 'User',
              icon: Icon(
                Icons.home,
                color: Colors.green,
              ),
            ),
            Tab(
              text: 'Search',
              icon: Icon(
                Icons.home,
                color: Colors.green,
              ),
            ),
          ]),
        ),
        body: TabBarView(children: [page(), page(), page()])
      ),
    );
  }
}


Widget page() {
  return  Column(
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
                boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(2, 2), blurRadius: 10)]
              ),
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