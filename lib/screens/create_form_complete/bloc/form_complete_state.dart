import 'package:equatable/equatable.dart';
import 'package:swp_project_web/models/response/property_model.dart';

abstract class FormCompleteState extends Equatable {
  const FormCompleteState();

  @override
  List<Object> get props => [];
}

class FormCompleteInitial extends FormCompleteState {}

class FormCompleteLoading extends FormCompleteState {}

class FormCompleteFailure extends FormCompleteState {
  final String error;

  const FormCompleteFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class FormCompleteSuccess extends FormCompleteState {
  final String success;

  const FormCompleteSuccess({required this.success});

  @override
  List<Object> get props => [success];
}

class CreateFormSuccess extends FormCompleteState {}

class SuccessGetListPropertyDone extends FormCompleteState {
  final List<PropertyModel> list;
  final List<String> listName;
  const SuccessGetListPropertyDone({required this.list, required this.listName});
  @override
  List<Object> get props => [list];
}