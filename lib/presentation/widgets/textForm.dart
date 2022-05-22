// ignore: file_names
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
