import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/screens/auction/bloc/auction_event.dart';
import 'package:swp_project_web/screens/auction/bloc/auction_state.dart';

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
      } else if (event is CheckIsJoin) {
        var isJoined = await ApiProvider.checkJoinAuction(event.idAuction);
        if (event.statusAuction == 2) {
          //đã kết thúc
          emit(
              const AuctionClosed(noti: 'Cuộc đấu giá đã kết thúc', joined: 3));
        } else if (event.statusAuction == 0) {
          //chưa diễn ra
          if (isJoined == true) {
            emit(const AuctionJoinedState(joined: 1)); //đã joined
          } else {
            emit(const AuctionJoinedState(joined: 2)); //chưa joined
          }
        } else if (event.statusAuction == 1) {
          //đang diễn ra
          if (isJoined == true) {
            emit(const AuctionJoinedState(joined: 4)); //đã joined
          } else {
            emit(const AuctionJoinedState(joined: 5)); //chưa joined
          }
        }
      } else if (event is JoinAuction) {
        var isJoine = await ApiProvider.joinAuction(event.idAuction);
        if (isJoine == true) {
          emit(JoinAuctionSuccessState());
        } else {
          emit(const JoinAuctionErrorState(error: 'Lỗi đăng ký'));
        }
      }
    } catch (e) {
      print("Loi bloc: $e");
      emit(const AuctionError(error: "Lỗi bài đấu giá"));
    }
  }
}
