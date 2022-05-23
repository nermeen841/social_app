import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget homeBannar({required double w, required VoidCallback press}) {
  return Row(
    children: [
      Icon(
        Icons.info_outline,
        size: w * 0.05,
      ),
      SizedBox(
        width: w * 0.015,
      ),
      Text(
        "please verify your email",
        style: TextStyle(
            fontSize: w * 0.04,
            fontWeight: FontWeight.w600,
            color: Colors.black),
      ),
      const Spacer(),
      TextButton(
        onPressed: press,
        child: Text(
          "verfiy",
          style: TextStyle(
            fontSize: w * 0.04,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}
////////////////////////////////////////////////////////////////

homeAppbar({required double w, required String title}) {
  return AppBar(
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          FontAwesomeIcons.bell,
          color: Colors.black,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          FontAwesomeIcons.magnifyingGlass,
          color: Colors.black,
        ),
      ),
    ],
    title: Text(
      title,
      style: TextStyle(
          fontSize: w * 0.05, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    elevation: 0.0,
    backgroundColor: Colors.white,
  );
}
