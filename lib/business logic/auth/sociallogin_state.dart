part of 'sociallogin_cubit.dart';

@immutable
abstract class SocialloginState {}

class SocialloginInitial extends SocialloginState {}

class SocialloginSuccessState extends SocialloginState {}

class SocialloginLoadingState extends SocialloginState {}

class SocialloginErrorState extends SocialloginState {
  final String error;

  SocialloginErrorState(this.error);
}

class SocialRegisertSuccessState extends SocialloginState {}

class CreateUserSuccessState extends SocialloginState {}

class CreateUserErrorState extends SocialloginState {
  final String error;

  CreateUserErrorState(this.error);
}

class SocialRegisertLoadingState extends SocialloginState {}

class SocialRegisertErrorState extends SocialloginState {
  final String error;

  SocialRegisertErrorState(this.error);
}
