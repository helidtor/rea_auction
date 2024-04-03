import 'package:equatable/equatable.dart';
import 'package:swp_project_web/models/response/user_profile_model.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileEvent {}

class UpdateAvatarEvent extends ProfileEvent {
  final String url;
  const UpdateAvatarEvent({required this.url});
}

class UpdateProfileEvent extends ProfileEvent {
  final UserProfileModel userProfileModel;
  const UpdateProfileEvent({required this.userProfileModel});
}

class ChangePassEvent extends ProfileEvent {
  final String currentPass;
  final String newPass;
  final String confirmPass;
  const ChangePassEvent(
      {required this.currentPass,
      required this.newPass,
      required this.confirmPass});
}
