import 'package:equatable/equatable.dart';
import 'package:swp_project_web/models/response/form_model.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

class GetFormEvent extends FormEvent {}

class CreateFormEvent extends FormEvent {
  final FormsModel formModel;
  const CreateFormEvent({required this.formModel});
}
