import 'package:equatable/equatable.dart';
import 'package:swp_project_web/models/response/post_model.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostSuccess extends PostState {
  final List<PostModel> list;
  const PostSuccess({required this.list});
  @override
  List<Object> get props => [list];
}

class PostError extends PostState {
  final String error;

  const PostError({required this.error});

  @override
  List<Object> get props => [error];
}
