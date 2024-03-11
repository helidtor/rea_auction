import 'package:equatable/equatable.dart';
import 'package:swp_project_web/models/response/auction_model.dart';

abstract class AuctionEvent extends Equatable {
  const AuctionEvent();

  @override
  List<Object> get props => [];
}

class GetAllListAuction extends AuctionEvent {}

class GetListProperty extends AuctionEvent {}

class GetPropertyById extends AuctionEvent {
  final int id;
  const GetPropertyById({required this.id});
}

class CreateAuctionPost extends AuctionEvent {
  final AuctionModel auctionModel;
  const CreateAuctionPost({required this.auctionModel});
}
