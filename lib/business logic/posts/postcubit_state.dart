part of 'postcubit_cubit.dart';

@immutable
abstract class PostcubitState {}

class PostcubitInitial extends PostcubitState {}

class AddPostLoadingState extends PostcubitState {}

class AddPostSuccessState extends PostcubitState {}

class GetPostImageErrorState extends PostcubitState {}

class GetPostImageSuccessState extends PostcubitState {}

class UploadPostImageErrorState extends PostcubitState {}

class PostImageRemoveState extends PostcubitState {}

class UploadPostImageSuccessState extends PostcubitState {}

class AddPostErrorState extends PostcubitState {
  final String error;

  AddPostErrorState(this.error);
}

class GetAllPostErrorState extends PostcubitState {
  final String error;

  GetAllPostErrorState(this.error);
}

class GetAllPostLoadingState extends PostcubitState {}

class GetAllPostSuccessState extends PostcubitState {}
