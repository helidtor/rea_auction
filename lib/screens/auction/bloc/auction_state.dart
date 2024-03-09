import 'package:equatable/equatable.dart';
import 'package:swp_project_web/models/response/auction_model.dart';

abstract class AuctionState extends Equatable {
  const AuctionState();

  @override
  List<Object> get props => [];
}

class AuctionInitial extends AuctionState {}

class AuctionLoading extends AuctionState {}

class AuctionSuccess extends AuctionState {
  final List<AuctionModel> list;
  const AuctionSuccess({required this.list});
  @override
  List<Object> get props => [list];
}

class AuctionError extends AuctionState {
  final String error;

  const AuctionError({required this.error});

  @override
  List<Object> get props => [error];
}
