import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/presentation/screens/addpost/add_post.dart';
import 'package:social_app/presentation/screens/home/homescreen.dart';
import 'package:social_app/presentation/screens/user/user.dart';

import '../widgets/home.dart';
import 'chat/chat.dart';
import 'setting/setting.dart';

class SocialLayout extends StatefulWidget {
  final int? index;
  const SocialLayout({Key? key, this.index}) : super(key: key);

  @override
  State<SocialLayout> createState() => _SocialLayoutState();
}

class _SocialLayoutState extends State<SocialLayout> {
  List<Widget> screens = [
    const HomeScreen(),
    const ChatScreen(),
    const UserScreen(),
    const SettingScreen(),
  ];

  List<String> title = [
    'News Feed',
    'Chats',
    'Users',
    'Setting',
  ];

  int currentIndex = 0;
  getScreen() {
    if (widget.index != null) {
      setState(() {
        currentIndex = widget.index!;
      });
    } else {
      setState(() {
        currentIndex = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getScreen();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: homeAppbar(w: w, title: title[currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 4) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AddPostScreen()),
                (route) => false);
          } else {
            setState(() {
              currentIndex = index;
            });
          }
        },
        backgroundColor: Colors.white,
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black54,
        selectedLabelStyle: const TextStyle(
          color: Colors.green,
        ),
        unselectedLabelStyle: const TextStyle(
          color: Colors.black,
        ),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 35,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.commentDots), label: 'chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined), label: 'users'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: 'setting'),
          BottomNavigationBarItem(
              icon: Icon(Icons.file_upload_outlined), label: 'post'),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
