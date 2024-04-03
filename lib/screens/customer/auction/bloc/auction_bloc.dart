import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/screens/customer/auction/bloc/auction_event.dart';
import 'package:swp_project_web/screens/customer/auction/bloc/auction_state.dart';

class AuctionPostBloc extends Bloc<AuctionEvent, AuctionState> {
  AuctionPostBloc() : super(AuctionInitial()) {
    // event handler was added
    on<AuctionEvent>((event, emit) async {
      await post(emit, event);
    });
  }

  post(Emitter<AuctionState> emit, AuctionEvent event) async {
    emit(AuctionLoading());
    try {
      if (event is GetAllListAuction) {
        var listAuction = await ApiProvider.getAllAuctions();
        if (listAuction!.isNotEmpty) {
          emit(AuctionSuccess(list: listAuction));
        } else {
          emit(const AuctionError(error: "Lỗi tải đấu giá"));
        }
      }
      if (event is GetWinner) {
        var listTop3 = await ApiProvider.getTop3(idAuction: event.idAuction);
        if (listTop3!.isNotEmpty) {
          var winner = await ApiProvider.getUserById(listTop3.first.userId!);
          emit(WinnerState(winner: winner!));
        } else {
          emit(const AuctionError(error: "Lỗi tải đấu giá"));
        }
      } else if (event is CheckIsJoin) {
        var isJoined = await ApiProvider.checkJoinAuction(event.idAuction);
        if (event.statusAuction == 2) {
          //đã kết thúc
          emit(
              const AuctionClosed(noti: 'Cuộc đấu giá đã kết thúc', joined: 3));
        }
        if (event.statusAuction == 3) {
          //đã kết thúc
          emit(AuctionJoinedState(joined: 6));
        }
        if (event.statusAuction == 4) {
          //đã kết thúc
          emit(AuctionJoinedState(joined: 7));
        } else if (event.statusAuction == 0) {
          //sắp diễn ra
          if (isJoined == true) {
            emit(AuctionJoinedState(joined: 1)); //đã joined
          } else {
            emit(AuctionJoinedState(joined: 2)); //chưa joined
          }
        } else if (event.statusAuction == 1) {
          //đang diễn ra
          if (isJoined == true) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            int? idAuction = prefs.getInt("idAuction");
            var historyAuction = await ApiProvider.getAuctionHistory(idAuction: idAuction!);
            emit(AuctionJoinedState(joined: 4, auctionHistory: historyAuction)); //đã joined
          } else {
            emit(AuctionJoinedState(joined: 5)); //chưa joined
          }
        }
      } else if (event is JoinAuction) {
        var isJoine = await ApiProvider.joinAuction(event.idAuction);
        if (isJoine == true) {
          emit(JoinAuctionSuccessState());
        } else {
          emit(const JoinAuctionErrorState(error: 'Lỗi đăng ký'));
        }
      } else if (event is BidAuction) {
        var resultBid =
            await ApiProvider.bidAuction(event.idAuction, event.bidAmount);
        if (resultBid) {
          emit(BidAuctionSuccessState(currentPrice: event.bidAmount));
        } else {
          emit(BidAuctionFailureState());
        }
      }
    } catch (e) {
      print("Loi bloc: $e");
      emit(const AuctionError(error: "Lỗi bài đấu giá"));
    }
  }
}
