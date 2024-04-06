import 'package:equatable/equatable.dart';
import 'package:swp_project_web/models/response/form_done_model.dart';
import 'package:swp_project_web/models/response/form_model.dart';
import 'package:swp_project_web/screens/staff/manage_form/detail_form.dart';

abstract class MyFormCompleteStates extends Equatable {
  const MyFormCompleteStates();

  @override
  List<Object> get props => [];
}

class MyFormCompleteInitial extends MyFormCompleteStates {}

class MyFormCompleteLoading extends MyFormCompleteStates {}

class MyFormCompleteSuccess extends MyFormCompleteStates {
  final List<FormDoneModel> list;
  const MyFormCompleteSuccess({required this.list});
  @override
  List<Object> get props => [list];
}

class MyFormCompleteError extends MyFormCompleteStates {
  final String error;

  const MyFormCompleteError({required this.error});

  @override
  List<Object> get props => [error];
}

class ApproveMyFormCompleteSuccess extends MyFormCompleteStates {}

class DeclineMyFormCompleteSuccess extends MyFormCompleteStates {}
