import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/screens/staff/manage_property/bloc/list_property_event.dart';
import 'package:swp_project_web/screens/staff/manage_property/bloc/list_property_state.dart';


class PropertyListBloc extends Bloc<PropertyListEvent, PropertyListState> {
  PropertyListBloc() : super(PropertyListInitial()) {
    // event handler was added
    on<PropertyListEvent>((event, emit) async {
      await post(emit, event);
    });
  }

  post(Emitter<PropertyListState> emit, PropertyListEvent event) async {
    emit(PropertyListLoading());
    try {
      if (event is GetAllListProperty) {
        var listProperty = await ApiProvider.getAllProperties();
        emit(PropertyListSuccess(list: listProperty!));
      } else {
        emit(const PropertyListError(error: "Lỗi danh sách tài sản"));
      }
    } catch (e) {
      print("Loi: $e");
      emit(const PropertyListError(error: "Lỗi tải danh sách tài sản"));
    }
  }
}
