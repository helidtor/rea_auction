import 'package:equatable/equatable.dart';

abstract class PropertyListEvent extends Equatable {
  const PropertyListEvent();

  @override
  List<Object> get props => [];
}

class GetAllListProperty extends PropertyListEvent {}
