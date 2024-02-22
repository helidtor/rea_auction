import 'package:swp_project_web/models/response/user_login_model.dart';
import 'package:swp_project_web/models/response/user_profile_model.dart';

class AuthenticationRepository {
  AuthenticationRepository();
  UserProfileModel user = UserProfileModel();
  String? tokenFirebase;

  UserProfileModel? get currentUser {
    return user;
  }

  UserProfileModel updateUser(UserProfileModel userProfileModel) {
    user = userProfileModel;
    return user;
  }
}
