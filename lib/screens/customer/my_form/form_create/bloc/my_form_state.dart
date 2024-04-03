import 'package:equatable/equatable.dart';
import 'package:swp_project_web/models/response/form_model.dart';
import 'package:swp_project_web/screens/staff/manage_form/detail_form.dart';

abstract class MyFormStates extends Equatable {
  const MyFormStates();

  @override
  List<Object> get props => [];
}

class MyFormInitial extends MyFormStates {}

class MyFormLoading extends MyFormStates {}

class MyFormSuccess extends MyFormStates {
  final List<FormsModel> list;
  const MyFormSuccess({required this.list});
  @override
  List<Object> get props => [list];
}

class MyFormError extends MyFormStates {
  final String error;

  const MyFormError({required this.error});

  @override
  List<Object> get props => [error];
}

class ApproveMyFormSuccess extends MyFormStates {}

class DeclineMyFormSuccess extends MyFormStates {}
