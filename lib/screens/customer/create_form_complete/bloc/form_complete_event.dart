import 'package:equatable/equatable.dart';
import 'package:swp_project_web/models/response/form_done_model.dart';
import 'package:swp_project_web/models/response/form_model.dart';

abstract class FormCompleteEvent extends Equatable {
  const FormCompleteEvent();

  @override
  List<Object> get props => [];
}

class GetFormCompleteEvent extends FormCompleteEvent {}

class CreateFormCompleteEvent extends FormCompleteEvent {
  final FormDoneModel formDoneModel;
  const CreateFormCompleteEvent({required this.formDoneModel});
}

class GetListPropertyDone extends FormCompleteEvent {}