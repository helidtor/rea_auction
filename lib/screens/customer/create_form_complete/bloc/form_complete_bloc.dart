import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/screens/customer/create_form/bloc/form_event.dart';
import 'package:swp_project_web/screens/customer/create_form/bloc/form_state.dart';
import 'package:swp_project_web/screens/customer/create_form_complete/bloc/form_complete_event.dart';
import 'package:swp_project_web/screens/customer/create_form_complete/bloc/form_complete_state.dart';

class FormCompleteBloc extends Bloc<FormCompleteEvent, FormCompleteState> {
  FormCompleteBloc() : super(FormCompleteInitial()) {
    on<FormCompleteEvent>((event, emit) async {
      await formBloc(emit, event);
    });
  }

  formBloc(Emitter<FormCompleteState> emit, FormCompleteEvent event) async {
    emit(FormCompleteLoading());
    try {
      if (event is CreateFormCompleteEvent) {
        bool check = await ApiProvider.createFormDone(event.formDoneModel);
        if (check) {
          emit(const FormCompleteSuccess(success: "Gửi đơn thành công"));
        } else {
          emit(const FormCompleteFailure(error: "Lỗi tạo dơn"));
        }
      } else if (event is GetListPropertyDone) {
        var listProperty = await ApiProvider.getAllPropertyAvailable();
        List<String> listNameProperty = [];
        if (listProperty!.isNotEmpty) {
          for (int i = 0; i < listProperty.length; i++) {
            if (listProperty[i].isAvailable == true) {
              listNameProperty.add(listProperty[i].post!.title!);
            }
          }
          emit(SuccessGetListPropertyDone(
              list: listProperty, listName: listNameProperty));
        } else {
          emit(const FormCompleteFailure(
              error: 'Chưa có tài sản đấu giá thành công'));
        }
      }
    } catch (e) {
      emit(const FormCompleteFailure(error: "Lỗi đơn"));
    }
  }
}
