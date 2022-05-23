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
