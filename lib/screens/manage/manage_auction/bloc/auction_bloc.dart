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
      } else if (event is CreateAuctionPost) {
        var inforAuction = event.formAuction;
        var isCreate = await ApiProvider.createAuction(inforAuction);
        if (isCreate == true) {
          emit(CreateAuctionSuccess());
        } else {
          const AuctionError(error: 'Tạo đấu giá thất bại');
        }
      } else if (event is GetListProperty) {
        var listProperty = await ApiProvider.getAllProperties();
        List<String> listNameProperty = [];
        if (listProperty!.isNotEmpty) {
          for (int i = 0; i < listProperty.length; i++) {
            if (listProperty[i].isAvailable == true) {
              listNameProperty.add(listProperty[i].post!.title!);
            }
          }
        } else {
          emit(AuctionError(
              error: 'Lỗi list khi lấy tài sản: ${listProperty.toString()}'));
        }
        emit(SuccessGetListProperty(
            list: listProperty, listName: listNameProperty));
      } else if (event is GetPropertyById) {
        var propertyModel = await ApiProvider.getPropertyById(event.id);
        if (propertyModel != null) {
          emit(PropertySuccess(propertyModel: propertyModel));
        }
      } else {
        emit(const AuctionError(error: "Lỗi bài đấu giá"));
      }
    } catch (e) {
      print("Loi: $e");
      emit(const AuctionError(error: "Lỗi tải bài đấu giá"));
    }
  }
}
