import 'package:flutter/material.dart';
import 'package:social_app/presentation/screens/layout.dart';
import 'package:social_app/presentation/widgets/textForm.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: cutomeAppBar(
          press: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const SocialLayout(
                        index: 0,
                      )),
              (route) => false),
          title: "Create post",
          w: w),
      body: SingleChildScrollView(),
    );
  }
}
