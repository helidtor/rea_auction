import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swp_project_web/constant/myToken.dart';
import 'package:swp_project_web/models/response/user_profile_model.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/router/router.dart';
import 'package:swp_project_web/widgets/button/gradient_button.dart';
import 'package:swp_project_web/widgets/input/field_profile.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';
import 'package:toastification/toastification.dart';

Future<void> clearToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(myToken, "token");
  prefs.setString("userLogin", "");
}

Future<UserProfileModel?> getUser() async {
  var userLogined = await ApiProvider.getProfile();
  return userLogined;
}

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  UserProfileModel? user;
  UserProfileModel inforUpdate = UserProfileModel();
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final profile = await getUser();
    if (mounted) {
      setState(() {
        user = profile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth * 0.2,
            height: screenHeight * 0.94,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    top: 10,
                  ),
                  child: Text(
                    "Hồ sơ",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        // ảnh ava
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: const Color.fromARGB(252, 0, 0, 0),
                          ),
                          color: const Color.fromARGB(253, 255, 255, 255),
                          borderRadius: BorderRadius.circular(500),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: (user?.avatarUrl != null)
                                ? Image.network(user!.avatarUrl!).image
                                : const AssetImage(
                                    "assets/images/ava_default.png"),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: (user?.firstName != null &&
                                      user?.lastName != null)
                                  ? ('${user!.firstName} ${user!.lastName}')
                                  : '...',
                              style: const TextStyle(
                                color: Color.fromARGB(205, 0, 0, 0),
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: (user?.email != null)
                                  ? '\n${user!.email}'
                                  : '\n...',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(132, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FieldProfile(
                      icon: Icons.person,
                      label: 'Họ',
                      controller: lastNameController,
                      widthInput: 0.38,
                      readOnly: false,
                      content: (user?.phoneNumber != null)
                          ? '${user!.phoneNumber}'
                          : 'staff',
                      onChangeText: (value) {
                        setState(() {
                          inforUpdate.lastName = value;
                        });
                      },
                    ),
                    FieldProfile(
                      icon: Icons.person,
                      label: 'Tên',
                      controller: lastNameController,
                      widthInput: 0.38,
                      readOnly: false,
                      content: (user?.phoneNumber != null)
                          ? '${user!.phoneNumber}'
                          : 'staff',
                      onChangeText: (value) {
                        setState(() {
                          inforUpdate.lastName = value;
                        });
                      },
                    ),
                    FieldProfile(
                      icon: Icons.person,
                      label: 'Email',
                      controller: firstNameController,
                      widthInput: 0.38,
                      readOnly: false,
                      content: (user?.email != null)
                          ? '${user!.email}'
                          : 'staff@gmail.com',
                      onChangeText: (value) {
                        setState(() {
                          inforUpdate.firstName = value;
                        });
                      },
                    ),
                    FieldProfile(
                      icon: Icons.person,
                      label: 'SĐT',
                      controller: lastNameController,
                      widthInput: 0.38,
                      readOnly: false,
                      content: (user?.phoneNumber != null)
                          ? '${user!.phoneNumber}'
                          : '0349878452',
                      onChangeText: (value) {
                        setState(() {
                          inforUpdate.lastName = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GradientButton(
                      onPressed: () {},
                      s: 'Lưu',
                      widthButton: 0.18,
                      heightButton: 40,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GradientButton(
                      onPressed: () {
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
                            autoCloseDuration:
                                const Duration(milliseconds: 1500),
                            animationDuration:
                                const Duration(milliseconds: 500),
                            alignment: Alignment.topRight);
                      },
                      s: 'Đăng xuất',
                      widthButton: 0.18,
                      heightButton: 40,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
