// ignore_for_file: avoid_print, library_prefixes, deprecated_member_use, avoid_function_literals_in_foreach_calls
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/data/models/post.dart';
part 'postcubit_state.dart';

class PostcubitCubit extends Cubit<PostcubitState> {
  PostcubitCubit() : super(PostcubitInitial());

  static PostcubitCubit get(context) => BlocProvider.of(context);

  File? postImage;
  String? postImagePath;

  getpostImage() async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      postImagePath = pickedFile.path;
      emit(GetPostImageSuccessState());
    } else {
      print('No image selected.');
      emit(GetPostImageErrorState());
    }
  }

////////////////////////////////////////////////////////////////////////////////

  String postImageUrl = '';
  void uploadPostImage({
    required String name,
    required String userImage,
    required String content,
    required String dateTime,
  }) async {
    firebaseStorage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        print(value);
        postImageUrl = value;
        createPost(
            name: name,
            userImage: userImage,
            content: content,
            dateTime: dateTime,
            postImage: value);
        emit(UploadPostImageSuccessState());
      }).catchError((e) {
        emit(UploadPostImageErrorState());
      });
    }).catchError((error) {
      emit(UploadPostImageErrorState());
    });
  }
///////////////////////////////////////////////////////////////////////////////

  void removePostImage() {
    postImage = null;
    emit(PostImageRemoveState());
  }

  ///////////////////////////////////////////////////////////////////////////////////

  void createPost({
    required String name,
    required String userImage,
    required String content,
    required String dateTime,
    required String postImage,
  }) async {
    emit(AddPostLoadingState());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String uId = preferences.getString('token')!;
    PostModel postModel = PostModel(
      name: name,
      uid: uId,
      image: userImage,
      text: content,
      dateTime: dateTime,
      postImage: postImage,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(AddPostSuccessState());
    }).catchError((error) {
      emit(AddPostErrorState(error.toString()));
      print("update user data error --------- : " + error.toString());
    });
  }

  /////////////////////////////////////////////////////////////////

  List<PostModel> posts = [];

  void getAllPosts() async {
    emit(GetAllPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        posts.add(PostModel.fromJson(element.data()));
      });
      emit(GetAllPostSuccessState());
    }).catchError((e) {
      emit(GetAllPostErrorState(e.toString()));
      print(e.toString());
    });
  }
}
