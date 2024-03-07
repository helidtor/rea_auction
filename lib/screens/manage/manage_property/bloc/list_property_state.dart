import 'package:equatable/equatable.dart';
import 'package:swp_project_web/models/response/property_model.dart';

abstract class PropertyListState extends Equatable {
  const PropertyListState();

  @override
  List<Object> get props => [];
}

class PropertyListInitial extends PropertyListState {}

class PropertyListLoading extends PropertyListState {}

class PropertyListSuccess extends PropertyListState {
  final List<PropertyModel> list;
  const PropertyListSuccess({required this.list});
  @override
  List<Object> get props => [list];
}

class PropertyListError extends PropertyListState {
  final String error;

  const PropertyListError({required this.error});

  @override
  List<Object> get props => [error];
}
