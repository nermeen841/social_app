part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class GetUserSuccessState extends UserState {}

class GetUserLoadingState extends UserState {}

class GetUserErrorState extends UserState {
  final String error;

  GetUserErrorState(this.error);
}

class UpdateUserLoadingState extends UserState {}

class UpdateUserErrorState extends UserState {
  final String error;

  UpdateUserErrorState(this.error);
}

class UpdateProfileImageSuccessState extends UserState {}

class UpdateProfileImageErrorState extends UserState {
  final String error;

  UpdateProfileImageErrorState(this.error);
}

class UpdateCoverImageSuccessState extends UserState {}

class UpdateCoverImageErrorState extends UserState {
  final String error;

  UpdateCoverImageErrorState(this.error);
}

class UploadProfileImageErrorState extends UserState {}

class UploadProfileImageSuccessState extends UserState {}

class UploadCoverImageSuccessState extends UserState {}

class UploadCoverImageErrorState extends UserState {}
