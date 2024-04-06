import 'package:equatable/equatable.dart';

abstract class MyFormCompleteEvent extends Equatable {
  const MyFormCompleteEvent();

  @override
  List<Object> get props => [];
}

class GetAllListCompletePost extends MyFormCompleteEvent {}

class ApproveMyFormComplete extends MyFormCompleteEvent {
  final int id;
  const ApproveMyFormComplete({required this.id});
}

class DeclinedMyFormComplete extends MyFormCompleteEvent {
  final String reason;
  final int id;
  const DeclinedMyFormComplete({required this.id, required this.reason});
}
