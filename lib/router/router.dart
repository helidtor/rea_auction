import 'dart:js';

import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swp_project_web/constant/myToken.dart';
import 'package:swp_project_web/screens/customer/create_form/create_form.dart';
import 'package:swp_project_web/screens/customer/create_form_complete/create_form_complete.dart';
import 'package:swp_project_web/screens/customer/home/home_page.dart';
import 'package:swp_project_web/screens/customer/my_form/form_create/my_form_screen.dart';
import 'package:swp_project_web/screens/login/login_screen.dart';
import 'package:swp_project_web/screens/staff/navigator_manage.dart';
import 'package:swp_project_web/screens/customer/payment/pay_fail.dart';
import 'package:swp_project_web/screens/customer/payment/pay_success.dart';
import 'package:swp_project_web/screens/customer/profile/profile_screen.dart';
import 'package:swp_project_web/screens/customer/signup/sign_up_screen.dart';

class RouteName {
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String profile = '/profile';
  static const String createForm = '/create_form';
  static const String manage = '/manage';
  static const String formComplete = '/form_complete';
  static const String paymentSuccess = '/payment_success';
  static const String paymentFail = '/payment_failed';
  static const String myForm = '/my_form';

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
      path: RouteName.myForm,
      builder: (context, state) => const MyCreateForm(),
    ),
    GoRoute(
      path: RouteName.paymentFail,
      builder: (context, state) => const PayFail(),
    ),
    GoRoute(
      path: RouteName.paymentSuccess,
      builder: (context, state) => const PaySuccess(),
    ),
    GoRoute(
      path: RouteName.formComplete,
      builder: (context, state) => const FormComplete(),
    ),
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
      builder: (context, state) => const NavigatorManage(),
    ),
  ],
);
