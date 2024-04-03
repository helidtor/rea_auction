import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/screens/customer/my_form/form_create/bloc/my_form_event.dart';
import 'package:swp_project_web/screens/customer/my_form/form_create/bloc/my_form_state.dart';

class MyFormBloc extends Bloc<MyFormEvent, MyFormStates> {
  MyFormBloc() : super(MyFormInitial()) {
    // event handler was added
    on<MyFormEvent>((event, emit) async {
      await post(emit, event);
    });
  }

  post(Emitter<MyFormStates> emit, MyFormEvent event) async {
    emit(MyFormLoading());
    try {
      if (event is GetAllListPost) {
        var listPost = await ApiProvider.getAllMyPosts();
        emit(MyFormSuccess(list: listPost!));
      } else if (event is ApproveMyForm) {
        var check = await ApiProvider.approveForm(idForm: event.id);
        if (check == true) {
          emit(ApproveMyFormSuccess());
        } else {
          emit(const MyFormError(error: "Lỗi phê duyệt"));
        }
      } else if (event is DeclinedMyForm) {
        var check = await ApiProvider.declineForm(
          idForm: event.id,
          reason: event.reason,
        );
        if (check == true) {
          emit(DeclineMyFormSuccess());
        } else {
          emit(const MyFormError(error: "Lỗi từ chối"));
        }
      } else {
        emit(const MyFormError(error: "Lỗi đơn tạo đấu giá"));
      }
    } catch (e) {
      print("Loi: $e");
      emit(const MyFormError(error: "Lỗi tải đơn"));
    }
  }
}
