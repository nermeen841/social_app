// ignore_for_file: avoid_print, deprecated_member_use, library_prefixes
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/data/models/user_model.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() async {
    emit(GetUserLoadingState());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String uId = preferences.getString('token')!;

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((e) {
      emit(GetUserErrorState(e.toString()));
      print("error while get user data : " + e.toString());
    });
  }

  //////////////////////////////////////////////////////////////////////////////
  File? profileImage;
  String? profileImagePath;

  getProfileImage() async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      profileImagePath = pickedFile.path;
      emit(UpdateProfileImageSuccessState());
    } else {
      print('No image selected.');
      emit(UpdateProfileImageErrorState('No image selected.'));
    }
  }

  ///////////////////////////////////////////////////////////////////////////

  File? coverImage;
  String? coverImagePath;

  getCoverImage() async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      coverImagePath = pickedFile.path;
      emit(UpdateCoverImageSuccessState());
    } else {
      print('No image selected.');
      emit(UpdateCoverImageErrorState('No image selected.'));
    }
  }

  ////////////////////////////////////////////////////////////////////
  String profileImageUrl = '';
  void uploadProfileImage({
    required String name,
    required String bio,
    required String cover,
    required String email,
    required String phone,
  }) async {
    firebaseStorage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        print(value);
        profileImageUrl = value;
        updateUser(
            name: name,
            bio: bio,
            email: email,
            phone: phone,
            profile: value,
            cover: cover);
        emit(UploadProfileImageSuccessState());
      }).catchError((e) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  ////////////////////////////////////////////////////////////////////////////
  String coverImageUrl = '';
  void uploadcoverImage(
      {required String name,
      required String bio,
      required String profile,
      required String email,
      required String phone}) async {
    firebaseStorage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        print(value);
        coverImageUrl = value;
        updateUser(
            name: name,
            bio: bio,
            email: email,
            phone: phone,
            profile: profile,
            cover: value);
        emit(UploadCoverImageSuccessState());
      }).catchError((e) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  ////////////////////////////////////////////////////////////////////

  void updateUserData(
      {required String name,
      required String bio,
      required String profile,
      required String cover,
      required String email,
      required String phone}) async {
    emit(UpdateUserLoadingState());
    if (coverImage != null) {
      uploadcoverImage(
        name: name,
        phone: phone,
        bio: bio,
        email: email,
        profile: profile,
      );
    } else if (profileImage != null) {
      uploadProfileImage(
        name: name,
        phone: phone,
        bio: bio,
        email: email,
        cover: cover,
      );
    } else if (coverImage != null && profileImage != null) {
    } else {
      updateUser(
          name: name,
          bio: bio,
          email: email,
          phone: phone,
          profile: profile,
          cover: cover);
    }
  }

  ////////////////////////////////////////////////////////////////

  void updateUser(
      {required String name,
      required String bio,
      required String email,
      required String profile,
      required String cover,
      required String phone}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String uId = preferences.getString('token')!;
    UserModel userModel = UserModel(
        name: name,
        phone: phone,
        cover: cover,
        bio: bio,
        uid: uId,
        email: email,
        isEmailVerified: true,
        image: profile);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpdateUserErrorState(error.toString()));
      print("update user data error --------- : " + error.toString());
    });
  }
}
