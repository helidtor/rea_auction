import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/screens/customer/my_form/form_complete/bloc/my_form_complete_event.dart';
import 'package:swp_project_web/screens/customer/my_form/form_complete/bloc/my_form_complete_state.dart';

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
      if (event is GetAllListCompletePost) {
        var listPost = await ApiProvider.getAllMyCompletePosts();
        emit(MyFormCompleteSuccess(list: listPost!));
      } else {
        emit(const MyFormCompleteError(error: "Lỗi đơn giải ngân"));
      }
    } catch (e) {
      print("Loi: $e");
      emit(const MyFormCompleteError(error: "Lỗi tải đơn giải ngân"));
    }
  }
}
