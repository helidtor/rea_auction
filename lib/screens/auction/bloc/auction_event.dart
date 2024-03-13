import 'package:equatable/equatable.dart';

abstract class AuctionEvent extends Equatable {
  const AuctionEvent();

  @override
  List<Object> get props => [];
}

class GetAllListAuction extends AuctionEvent {}

class CheckIsJoin extends AuctionEvent {
  final int idAuction;
  final int statusAuction;

  const CheckIsJoin({required this.idAuction, required this.statusAuction});
}

class JoinAuction extends AuctionEvent {
  final int idAuction;

  const JoinAuction({required this.idAuction});
}
