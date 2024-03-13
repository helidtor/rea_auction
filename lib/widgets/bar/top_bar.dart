import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swp_project_web/constant/myToken.dart';
import 'package:swp_project_web/router/router.dart';
import 'package:swp_project_web/screens/contact/contact_infor.dart';
import 'package:swp_project_web/widgets/button/profile_button.dart';
import 'package:swp_project_web/widgets/selection_app_bar.dart';

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString(myToken);
  return token;
}

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final double screenWidth;
  final double screenHeight;
  const TopBar(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getToken(), //check user đã login hay chưa
      builder: (context, snapshot) {
        bool isLogin = snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data != "" &&
            snapshot.data != 'token';
        List<Widget> navItems = [
          SizedBox(
            width: screenWidth * 0.02,
          ),
          InkWell(
            onTap: () {
              context.go(RouteName.home);
            },
            child: Image.asset(
              'assets/images/logo_web_auction.jpg',
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(
            width: screenWidth * 0.02,
          ),
          SelectionAppBarButton(
              text: 'Tài sản đấu giá', navigatePage: ContactInfor()),
          SizedBox(
            width: screenWidth * 0.02,
          ),
          SelectionAppBarButton(
              text: 'Cuộc đấu giá', navigatePage: ContactInfor()),
          SizedBox(
            width: screenWidth * 0.02,
          ),
          SelectionAppBarButton(text: 'Tin tức', navigatePage: ContactInfor()),
          SizedBox(
            width: screenWidth * 0.02,
          ),
          SelectionAppBarButton(
              text: 'Giới thiệu', navigatePage: ContactInfor()),
          SizedBox(
            width: screenWidth * 0.02,
          ),
          SelectionAppBarButton(text: 'Liên hệ', navigatePage: ContactInfor()),
        ];
        return AppBar(
          toolbarHeight: screenHeight * 0.5,
          elevation: 5,
          backgroundColor: const Color.fromARGB(255, 254, 249, 243),
          shadowColor: const Color.fromARGB(255, 148, 146, 146),
          automaticallyImplyLeading: false,
          actions: [
            ...navItems,
            const Spacer(),
            isLogin ? const ProfileButton() : const SizedBox(),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(screenHeight * 0.1);
}
