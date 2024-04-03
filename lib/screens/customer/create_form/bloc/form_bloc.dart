import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/screens/customer/create_form/bloc/form_event.dart';
import 'package:swp_project_web/screens/customer/create_form/bloc/form_state.dart';

class FormBloc extends Bloc<FormEvent, FormStatess> {
  FormBloc() : super(FormStatesInitial()) {
    on<FormEvent>((event, emit) async {
      await formBloc(emit, event);
    });
  }

  formBloc(Emitter<FormStatess> emit, FormEvent event) async {
    emit(FormStatesLoading());
    try {
      if (event is CreateFormEvent) {
        bool check = await ApiProvider.createForm(event.formModel);
        if (check) {
          emit(const FormStatesSuccess(success: "Tạo đơn thành công"));
        } else {
          emit(const FormStatesFailure(error: "Lỗi tạo dơn"));
        }
      }
    } catch (e) {
      emit(const FormStatesFailure(error: "Lỗi đơn"));
    }
  }
}
