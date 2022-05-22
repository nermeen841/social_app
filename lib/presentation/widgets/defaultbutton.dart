import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback press;
  final String title;
  const DefaultButton({Key? key, required this.press, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: press,
      child: Container(
        width: double.infinity,
        height: h * 0.06,
        color: Colors.green,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
                color: Colors.white,
                fontSize: w * 0.04),
          ),
        ),
      ),
    );
  }
}
