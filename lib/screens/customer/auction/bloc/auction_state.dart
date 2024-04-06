// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:swp_project_web/models/response/auction_history.dart';
import 'package:swp_project_web/models/response/auction_model.dart';
import 'package:swp_project_web/models/response/user_profile_model.dart';

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

class AuctionJoinedState extends AuctionState {
  final int joined;
  List<AuctionHistory>? auctionHistory;

  AuctionJoinedState({required this.joined, this.auctionHistory});
}

class JoinAuctionSuccessState extends AuctionState {
  String url;
  JoinAuctionSuccessState({
    required this.url,
  });
}

class JoinAuctionErrorState extends AuctionState {
  final String error;

  const JoinAuctionErrorState({required this.error});
}

class AuctionClosed extends AuctionState {
  final String noti;
  final int joined;

  const AuctionClosed({required this.noti, required this.joined});
}

class BidAuctionSuccessState extends AuctionState {
  final double currentPrice;

  const BidAuctionSuccessState({required this.currentPrice});
}

class BidAuctionFailureState extends AuctionState {}

class WinnerState extends AuctionState {
  final UserProfileModel winner;

  const WinnerState({required this.winner});
}
