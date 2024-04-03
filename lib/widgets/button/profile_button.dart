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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = await getNameUser();
    setState(() {
      userName = name;
      prefs.setString("fullNameUserLogin", name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Row(
        children: [
          TextContent(
            contentText: userName ?? "Đang tải...",
            color: Pallete.pinkBold,
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
              // child: Container(
              //   width: 30,
              //   height: 30,
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: const Color.fromARGB(253, 255, 255, 255),
              //     ),
              //     color: const Color.fromARGB(253, 255, 255, 255),
              //     borderRadius: const BorderRadius.all(Radius.circular(5)),
              //     image: DecorationImage(
              //       fit: BoxFit.fill,
              //       image: (avatarUrl == null)
              //           ? const AssetImage("assets/images/error_load_image.jpg")
              //           : Image.network(avatarUrl!).image,
              //     ),
              //   ),
              // ),
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
                  leading: const Icon(Icons.home),
                  title: const Text('Trang chủ'),
                  onTap: () {
                    router.go(RouteName.home);
                  },
                ),
              ),
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
                  leading: const Icon(Icons.attach_money_outlined),
                  title: const Text('Tạo đơn giải ngân cọc'),
                  onTap: () {
                    router.go(RouteName.formComplete);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.email_outlined),
                  title: const Text('Đơn của tôi'),
                  onTap: () {
                    router.go(RouteName.myForm);
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
                        autoCloseDuration: const Duration(milliseconds: 1500),
                        animationDuration: const Duration(milliseconds: 500),
                        alignment: Alignment.topRight);
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
