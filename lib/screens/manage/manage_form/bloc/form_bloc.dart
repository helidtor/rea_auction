import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/screens/manage/manage_form/bloc/form_event.dart';
import 'package:swp_project_web/screens/manage/manage_form/bloc/form_state.dart';

class FormBloc extends Bloc<FormEvent, FormStates> {
  FormBloc() : super(FormInitial()) {
    // event handler was added
    on<FormEvent>((event, emit) async {
      await post(emit, event);
    });
  }

  post(Emitter<FormStates> emit, FormEvent event) async {
    emit(FormLoading());
    try {
      if (event is GetAllListPost) {
        var listPost = await ApiProvider.getAllPosts();
        emit(FormSuccess(list: listPost!));
      } else if (event is ApproveForm) {
        var check = await ApiProvider.approveForm(idForm: event.id);
        if (check == true) {
          emit(ApproveFormSuccess());
        } else {
          emit(const FormError(error: "Lỗi phê duyệt"));
        }
      } else {
        emit(const FormError(error: "Lỗi đơn tạo đấu giá"));
      }
    } catch (e) {
      print("Loi: $e");
      emit(const FormError(error: "Lỗi tải đơn"));
    }
  }
}
