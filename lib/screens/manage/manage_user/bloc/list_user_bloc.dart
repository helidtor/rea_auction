import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/screens/manage/manage_user/bloc/list_user_event.dart';
import 'package:swp_project_web/screens/manage/manage_user/bloc/list_user_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(UserListInitial()) {
    // event handler was added
    on<UserListEvent>((event, emit) async {
      await post(emit, event);
    });
  }

  post(Emitter<UserListState> emit, UserListEvent event) async {
    emit(UserListLoading());
    try {
      if (event is GetAllListUser) {
        var listUser = await ApiProvider.getAllUsers();
        emit(UserListSuccess(list: listUser!));
      } else {
        emit(const UserListError(error: "Lỗi danh sách user"));
      }
    } catch (e) {
      print("Loi: $e");
      emit(const UserListError(error: "Lỗi tải danh sách user"));
    }
  }
}
