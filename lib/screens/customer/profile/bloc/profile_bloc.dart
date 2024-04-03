import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/screens/customer/profile/bloc/profile.event.dart';
import 'package:swp_project_web/screens/customer/profile/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileStateInitial()) {
    on<ProfileEvent>((event, emit) async {
      await profileBloc(emit, event);
    });
  }

  profileBloc(Emitter<ProfileState> emit, ProfileEvent event) async {
    emit(ProfileStateLoading());
    try {
      if (event is GetProfileEvent) {
        var user = await ApiProvider.getProfile();
        if (user != null) {
          emit(ProfileStateSuccess(userProfileModel: user));
        } else {
          emit(const ProfileStateFailure(error: "Lỗi thông tin"));
        }
      } else if (event is UpdateProfileEvent) {
        var check = await ApiProvider.updateProfile(event.userProfileModel);
        if (check == true) {
          emit(UpdateProfileSuccess());
        } else {
          emit(const ProfileStateFailure(error: "Lỗi"));
        }
      } else if (event is ChangePassEvent) {
        var check = await ApiProvider.changePassword(
            currentPass: event.currentPass,
            newPass: event.newPass,
            confirmPass: event.confirmPass);
        if (check == true) {
          emit(ChangePasswordSuccess());
        } else {
          emit(const ProfileStateFailure(error: "Lỗi"));
        }
      }
    } catch (e) {
      emit(const ProfileStateFailure(error: "Lỗi"));
    }
  }
}
