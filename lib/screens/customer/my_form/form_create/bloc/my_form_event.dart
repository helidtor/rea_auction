import 'package:equatable/equatable.dart';

abstract class MyFormEvent extends Equatable {
  const MyFormEvent();

  @override
  List<Object> get props => [];
}

class GetAllListPost extends MyFormEvent {}

class ApproveMyForm extends MyFormEvent {
  final int id;
  const ApproveMyForm({required this.id});
}

class DeclinedMyForm extends MyFormEvent {
  final String reason;
  final int id;
  const DeclinedMyForm({required this.id, required this.reason});
}
