import 'package:flutter/material.dart';
import 'package:social_app/presentation/screens/layout.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text(
          "Add post",
          style: TextStyle(
              fontSize: w * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const SocialLayout(
                        index: 0,
                      )),
              (route) => false),
        ),
      ),
    );
  }
}
