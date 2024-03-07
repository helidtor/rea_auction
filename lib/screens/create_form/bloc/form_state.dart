import 'package:equatable/equatable.dart';

abstract class FormStatess extends Equatable {
  const FormStatess();

  @override
  List<Object> get props => [];
}

class FormStatesInitial extends FormStatess {}

class FormStatesLoading extends FormStatess {}

class FormStatesFailure extends FormStatess {
  final String error;

  const FormStatesFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class FormStatesSuccess extends FormStatess {
  final String success;

  const FormStatesSuccess({required this.success});

  @override
  List<Object> get props => [success];
}

class CreateFormSuccess extends FormStatess {}
