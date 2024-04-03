import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/screens/customer/my_form/form_complete/bloc/my_form_event.dart';
import 'package:swp_project_web/screens/customer/my_form/form_complete/bloc/my_form_state.dart';

class MyFormCompleteBloc extends Bloc<MyFormCompleteEvent, MyFormCompleteStates> {
  MyFormCompleteBloc() : super(MyFormCompleteInitial()) {
    // event handler was added
    on<MyFormCompleteEvent>((event, emit) async {
      await post(emit, event);
    });
  }

  post(Emitter<MyFormCompleteStates> emit, MyFormCompleteEvent event) async {
    emit(MyFormCompleteLoading());
    try {
      if (event is GetAllListPost) {
        var listPost = await ApiProvider.getAllPosts();
        emit(MyFormCompleteSuccess(list: listPost!));
      } else if (event is ApproveMyFormComplete) {
        var check = await ApiProvider.approveForm(idForm: event.id);
        if (check == true) {
          emit(ApproveMyFormCompleteSuccess());
        } else {
          emit(const MyFormCompleteError(error: "Lỗi phê duyệt"));
        }
      } else if (event is DeclinedMyFormComplete) {
        var check = await ApiProvider.declineForm(
          idForm: event.id,
          reason: event.reason,
        );
        if (check == true) {
          emit(DeclineMyFormCompleteSuccess());
        } else {
          emit(const MyFormCompleteError(error: "Lỗi từ chối"));
        }
      } else {
        emit(const MyFormCompleteError(error: "Lỗi đơn tạo đấu giá"));
      }
    } catch (e) {
      print("Loi: $e");
      emit(const MyFormCompleteError(error: "Lỗi tải đơn"));
    }
  }
}
