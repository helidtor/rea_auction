import 'package:equatable/equatable.dart';

abstract class FormStates extends Equatable {
  const FormStates();

  @override
  List<Object> get props => [];
}

class FormStateInitial extends FormStates {}

class FormStateLoading extends FormStates {}

class FormStateFailure extends FormStates {
  final String error;

  const FormStateFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class FormStateSuccess extends FormStates {
  final String success;

  const FormStateSuccess({required this.success});

  @override
  List<Object> get props => [success];
}

class CreateFormSuccess extends FormStates {}
