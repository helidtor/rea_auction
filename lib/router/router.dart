import 'dart:js';

import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swp_project_web/constant/myToken.dart';
import 'package:swp_project_web/screens/create_form/create_form.dart';
import 'package:swp_project_web/screens/home/home_page.dart';
import 'package:swp_project_web/screens/login/login_screen.dart';
import 'package:swp_project_web/screens/manage/manage_screen.dart';
import 'package:swp_project_web/screens/profile/profile_screen.dart';
import 'package:swp_project_web/screens/signup/sign_up_screen.dart';

class RouteName {
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String profile = '/profile';
  static const String createForm = '/create_form';
  static const String manage = '/manage';

  static const publicRoutes = [
    login,
    signup,
  ];
}

Future<bool> isLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? checkData = prefs.getString(myToken);
  if (checkData != null && checkData != 'token') {
    return true;
  } else {
    return false;
  }
}

//nếu không có path cụ thể thì trả về trang login
final router = GoRouter(
  redirect: (context, state) async {
    if (RouteName.publicRoutes.contains(state.fullPath)) {
      return null;
    } else if (await isLoggedIn()) {
      return null;
    }
    return RouteName.login;
  },
  routes: [
    GoRoute(
      path: RouteName.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: RouteName.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteName.signup,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: RouteName.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: RouteName.createForm,
      builder: (context, state) => const CreateForm(),
    ),
    GoRoute(
      path: RouteName.manage,
      builder: (context, state) => const ManageScreen(),
    ),
  ],
);
