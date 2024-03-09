import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/screens/auction/bloc/auction_state.dart';
import 'package:swp_project_web/screens/manage/manage_auction/bloc/auction_event.dart';

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
        emit(AuctionSuccess(list: listAuction!));
      } else {
        emit(const AuctionError(error: "Lỗi tải đấu giá"));
      }
    } catch (e) {
      print("Loi: $e");
      emit(const AuctionError(error: "Lỗi bài đấu giá"));
    }
  }
}
