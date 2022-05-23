// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
}
