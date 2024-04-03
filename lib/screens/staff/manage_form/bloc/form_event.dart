import 'package:equatable/equatable.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

class GetAllListPost extends FormEvent {}

class ApproveForm extends FormEvent {
  final int id;
  const ApproveForm({required this.id});
}

class DeclinedForm extends FormEvent {
  final String reason;
  final int id;
  const DeclinedForm({required this.id, required this.reason});
}
