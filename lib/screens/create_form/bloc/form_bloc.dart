import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/screens/create_form/bloc/form_event.dart';
import 'package:swp_project_web/screens/create_form/bloc/form_state.dart';

class FormBloc extends Bloc<FormEvent, FormStates> {
  FormBloc() : super(FormStateInitial()) {
    on<FormEvent>((event, emit) async {
      await formBloc(emit, event);
    });
  }

  formBloc(Emitter<FormStates> emit, FormEvent event) async {
    emit(FormStateLoading());
    try {
      if (event is CreateFormEvent) {
        bool check = await ApiProvider.createForm(event.formModel);
        if (check) {
          emit(const FormStateSuccess(success: "Tạo đơn thành công"));
        } else {
          emit(const FormStateFailure(error: "Lỗi tạo dơn"));
        }
      }
    } catch (e) {
      emit(const FormStateFailure(error: "Lỗi đơn"));
    }
  }
}
