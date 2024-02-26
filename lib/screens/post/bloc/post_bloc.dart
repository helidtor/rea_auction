import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/screens/post/bloc/post_event.dart';
import 'package:swp_project_web/screens/post/bloc/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    // event handler was added
    on<PostEvent>((event, emit) async {
      await post(emit, event);
    });
  }

  post(Emitter<PostState> emit, PostEvent event) async {
    emit(PostLoading());
    try {
      if (event is GetAllListPost) {
        var listPost = await ApiProvider.getAllPosts();
        emit(PostSuccess(list: listPost!));
      } else {
        emit(const PostError(error: "Lỗi bài đấu giá"));
      }
    } catch (e) {
      print("Loi: $e");
      emit(const PostError(error: "Lỗi tải bài"));
    }
  }
}
