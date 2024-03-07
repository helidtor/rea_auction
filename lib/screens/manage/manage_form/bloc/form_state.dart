import 'package:equatable/equatable.dart';
import 'package:swp_project_web/models/response/form_model.dart';
import 'package:swp_project_web/screens/manage/manage_form/detail_form.dart';

abstract class FormStates extends Equatable {
  const FormStates();

  @override
  List<Object> get props => [];
}

class FormInitial extends FormStates {}

class FormLoading extends FormStates {}

class FormSuccess extends FormStates {
  final List<FormsModel> list;
  const FormSuccess({required this.list});
  @override
  List<Object> get props => [list];
}

class FormError extends FormStates {
  final String error;

  const FormError({required this.error});

  @override
  List<Object> get props => [error];
}

class ApproveFormSuccess extends FormStates {}
