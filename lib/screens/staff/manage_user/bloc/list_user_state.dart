import 'package:equatable/equatable.dart';
import 'package:swp_project_web/models/response/user_profile_model.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object> get props => [];
}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListSuccess extends UserListState {
  final List<UserProfileModel> list;
  const UserListSuccess({required this.list});
  @override
  List<Object> get props => [list];
}

class UserListError extends UserListState {
  final String error;

  const UserListError({required this.error});

  @override
  List<Object> get props => [error];
}
