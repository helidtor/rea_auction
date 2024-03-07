import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/screens/manage/manage_auction/bloc/auction_event.dart';
import 'package:swp_project_web/screens/manage/manage_auction/bloc/auction_state.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState> {
  AuctionBloc() : super(AuctionInitial()) {
    // event handler was added
    on<AuctionEvent>((event, emit) async {
      await post(emit, event);
    });
  }

  post(Emitter<AuctionState> emit, AuctionEvent event) async {
    emit(AuctionLoading());
    try {
      if (event is GetAllListAuction) {
        var listAuction = await ApiProvider.getAllPostAuction();
        emit(AuctionSuccess(list: listAuction!));
      } else {
        emit(const AuctionError(error: "Lỗi bài đấu giá"));
      }
    } catch (e) {
      print("Loi: $e");
      emit(const AuctionError(error: "Lỗi tải bài đấu giá"));
    }
  }
}
