import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swp_project_web/constant/myToken.dart';
import 'package:swp_project_web/firebase/auth.dart';
import 'package:swp_project_web/models/response/user_profile_model.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/router/router.dart';
import 'package:swp_project_web/theme/pallete.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';
import 'package:swp_project_web/widgets/others/toast.dart';

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
                    showToast(
                      context: context,
                      msg: "Logout successfully!",
                      color: Color.fromARGB(255, 233, 229, 229),
                      icon: const Icon(Icons.logout),
                      top: 650,
                      right: 650,
                    );
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
