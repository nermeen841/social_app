// ignore_for_file: avoid_print

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'sociallogin_state.dart';

class SocialloginCubit extends Cubit<SocialloginState> {
  SocialloginCubit() : super(SocialloginInitial());

  static SocialloginCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {required String email,
      required String name,
      required String phone,
      required String password,
      required context}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    emit(SocialRegisertLoadingState());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        userCreate(
            email: email,
            name: name,
            phone: phone,
            uid: value.user!.uid.toString());
        preferences.setString('token', value.user!.uid.toString());
        emit(SocialRegisertSuccessState());
      });

      emit(SocialRegisertSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              'The password provided is too weak.',
              style: TextStyle(color: Colors.white),
            )));
        emit(SocialRegisertErrorState(e.toString()));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              'The account already exists for that email.',
              style: TextStyle(color: Colors.white),
            )));

        emit(SocialRegisertErrorState(e.toString()));
      }
    } catch (e) {
      emit(SocialRegisertErrorState(e.toString()));
      print(e);
    }
  }

  ////////////////////////////////////////////////////////

  void userCreate(
      {required String email,
      required String name,
      required String phone,
      required String uid}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .doc(uid)
        .set({'uid': uid, 'name': name, 'email': email, 'phone': phone}).then(
            (value) {
      print("User Added");
      emit(CreateUserSuccessState());
    }).catchError((error) {
      print("Failed to add user: $error");
      emit(CreateUserErrorState(error.toString()));
    });
  }

//////////////////////////////////////////////////////////
  void login(
      {required String email,
      required String password,
      required context}) async {
    emit(SocialloginLoadingState());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(SocialloginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              'No user found for that email.',
              style: TextStyle(color: Colors.white),
            )));
        emit(SocialloginErrorState(e.toString()));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              'Wrong password provided for that user.',
              style: TextStyle(color: Colors.white),
            )));
        emit(SocialloginErrorState(e.toString()));
      }
    }
  }
}
