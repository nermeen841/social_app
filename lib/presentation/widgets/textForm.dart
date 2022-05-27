// ignore_for_file: file_names

import 'package:flutter/material.dart';

buildTextForm(
    {required String hint,
    required Widget prefix,
    required bool obsecure,
    String? Function(String?)? validate,
    required TextInputAction textInputAction,
    required FocusNode focusNode,
    Function()? onEditingComplete,
    required TextEditingController controller}) {
  return TextFormField(
    obscureText: obsecure,
    focusNode: focusNode,
    textInputAction: textInputAction,
    keyboardType: TextInputType.text,
    onEditingComplete: onEditingComplete,
    controller: controller,
    validator: validate,
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: prefix,
      hintStyle: const TextStyle(
          color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.green),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
  );
}

//////////////////////////////////////////////////////////////////////

cutomeAppBar(
    {required VoidCallback press,
    required String title,
    required double w,
    List<Widget>? actions}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0.0,
    automaticallyImplyLeading: false,
    actions: actions,
    title: Text(
      title,
      style: TextStyle(
          fontSize: w * 0.05, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    leading: InkWell(
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onTap: press),
  );
}
//////////////////////////////////////////////////////////////////

addPostTextForm(
    {required String hint, required TextEditingController controller}) {
  return TextFormField(
    minLines: 1,
    maxLines: 10,
    keyboardType: TextInputType.text,
    controller: controller,
    decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
            color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16),
        border: InputBorder.none,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none),
  );
}
