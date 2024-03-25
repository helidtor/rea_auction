import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swp_project_web/constant/myToken.dart';
import 'package:swp_project_web/screens/login/bloc/login_event.dart';
import 'package:equatable/equatable.dart';
import 'package:swp_project_web/screens/login/bloc/login_state.dart';
import 'package:swp_project_web/models/response/user_login_model.dart';
import 'package:swp_project_web/models/response/user_profile_model.dart';
import 'package:swp_project_web/provider/api_provider.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      await loginUser(emit, event);
    });
  }
  loginUser(Emitter<LoginState> emit, LoginEvent event) async {
    emit(LoginLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (event is CheckLoginEvent) {
        var userModel = await ApiProvider.getProfile();
        if (userModel != null) {
          // var password = prefs.getString("password");
          // await AuthService().signInWithEmailAndPassword(
          //     userModel.email ?? "", password ?? "");
          emit(LoginSecondState(userProfileModel: userModel));
        } else {
          emit(LoginFirstState());
        }
      } else if (event is StartLoginEvent) {
        if (event.username == "" || event.password == "") {
          emit(const LoginFailure(
              error: "Tài khoản & mật khẩu không được để trống!"));
        } else {
          var user = await ApiProvider.logins(
              username: event.username, password: event.password);
          if (user != null) {
            prefs.setString(myToken, user.accessToken ?? "");
            prefs.setString("userLogin", event.username);

            var userLogin = await ApiProvider.getProfile();
            // await AuthService()
            //     .signInWithEmailAndPassword(user.email ?? "", event.password);
            // await ApiProvider.postToken();
            emit(LoginSuccessState(userProfileModel: userLogin!));
          } else {
            emit(const LoginFailure(
                error: "Tài khoản hoặc mật khẩu không chính xác!"));
          }
        }
      }
    } catch (e) {
      print("Loi bloc: $e");
      emit(const LoginFailure(error: "Error!"));
    }
  }
}
