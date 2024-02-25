import 'package:equatable/equatable.dart';
import 'package:swp_project_web/models/response/user_profile_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

//Chưa đăng nhập
class LoginFirstState extends LoginState {}

class LoginSecondState extends LoginState {
  final UserProfileModel userProfileModel;
  const LoginSecondState({required this.userProfileModel});
  @override
  List<Object> get props => [userProfileModel];
}

class LoginSuccessState extends LoginState {
  final UserProfileModel userProfileModel;
  const LoginSuccessState({required this.userProfileModel});
  @override
  List<Object> get props => [UserProfileModel];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}
