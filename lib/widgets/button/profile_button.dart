import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swp_project_web/constant/myToken.dart';
import 'package:swp_project_web/firebase/auth.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/router/router.dart';
import 'package:swp_project_web/theme/pallete.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';
import 'package:toastification/toastification.dart';

Future<void> clearToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(myToken, "token");
}

Future<String> getNameUser() async {
  var userLogined = await ApiProvider.getProfile();
  String userName = "${userLogined!.firstName} ${userLogined.lastName}";
  return userName;
}

class ProfileButton extends StatefulWidget {
  const ProfileButton({super.key});

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  bool isHovered = false;
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final name = await getNameUser();
    setState(() {
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
      child: Row(
        children: [
          TextContent(
            contentText: userName ?? "Đang tải...",
            color: Pallete.gradient3,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          PopupMenuButton(
            offset: const Offset(-10, 40),
            icon: MouseRegion(
              onEnter: (_) {
                setState(() {
                  isHovered = true;
                });
              },
              onExit: (_) {
                setState(() {
                  isHovered = false;
                });
              },
              child: Icon(
                Icons.account_circle,
                color: isHovered
                    ? const Color.fromARGB(255, 228, 40, 68)
                    : Colors.black,
                size: 30,
              ),
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Tài khoản'),
                  onTap: () {
                    router.go(RouteName.profile);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.format_align_left_sharp),
                  title: const Text('Tạo đơn đấu giá'),
                  onTap: () {
                    router.go(RouteName.createForm);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Đăng xuất'),
                  onTap: () {
                    signOutGoogle();
                    clearToken();
                    router.go(RouteName.login);
                    toastification.show(
                        pauseOnHover: false,
                        progressBarTheme: const ProgressIndicatorThemeData(
                            color: Colors.green),
                        icon: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        foregroundColor: Colors.black,
                        context: context,
                        type: ToastificationType.success,
                        style: ToastificationStyle.minimal,
                        title: const TextContent(
                          contentText: "Đăng xuất thành công!",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        autoCloseDuration: const Duration(seconds: 3),
                        animationDuration: const Duration(milliseconds: 500),
                        alignment: Alignment.topRight);
                    // showToast(
                    //   context: context,
                    //   colorText: Colors.white,
                    //   msg: "Đăng xuất thành công!",
                    //   color: Pallete.successColor,
                    //   icon: const Icon(
                    //     Icons.logout,
                    //     color: Colors.white,
                    //   ),
                    //   top: 650,
                    //   right: 650,
                    // );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
