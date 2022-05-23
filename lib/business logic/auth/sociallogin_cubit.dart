// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/data/models/user_model.dart';
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
    UserModel userModel = UserModel(
        name: name,
        email: email,
        phone: phone,
        uid: uid,
        isEmailVerified: false,
        cover:
            "https://img.freepik.com/free-vector/realistic-chocolate-box-composition-with-images-flying-choco-candies-with-orange-bow-blurry-background-vector-illustration_1284-73064.jpg?t=st=1653335684~exp=1653336284~hmac=2ff0ad3ba8061352e615af9f771e506cd8e0b8bb80c52f644f88575eed53de1f&w=360",
        bio: 'write your bio ...',
        image:
            "https://img.freepik.com/free-photo/cheerful-curly-business-girl-wearing-glasses_176420-206.jpg?t=st=1653330904~exp=1653331504~hmac=4472298721fab8a55ea592144da3751470082a08e4b10e40adf1b0b9b8aef6c7&w=360");
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(uid).set(userModel.toMap()).then((value) {
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
    SharedPreferences preferences = await SharedPreferences.getInstance();
    emit(SocialloginLoadingState());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        preferences.setString('token', value.user!.uid.toString());
      });
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
