import 'package:equatable/equatable.dart';
import 'package:swp_project_web/models/response/user_profile_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileStateInitial extends ProfileState {}

class ProfileStateLoading extends ProfileState {}

class ProfileStateFailure extends ProfileState {
  final String error;

  const ProfileStateFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class ProfileStateSuccess extends ProfileState {
  final UserProfileModel userProfileModel;

  const ProfileStateSuccess({required this.userProfileModel});

  @override
  List<Object> get props => [userProfileModel];
}

class ChangeAvatarSuccess extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {}

class ChangePasswordSuccess extends ProfileState {}
