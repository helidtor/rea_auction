import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/models/response/user_profile_model.dart';
import 'package:swp_project_web/router/router.dart';
import 'package:swp_project_web/screens/customer/profile/bloc/profile.event.dart';
import 'package:swp_project_web/screens/customer/profile/bloc/profile_bloc.dart';
import 'package:swp_project_web/screens/customer/profile/bloc/profile_state.dart';
import 'package:swp_project_web/widgets/bar/footer_web.dart';
import 'package:swp_project_web/widgets/bar/top_bar.dart';
import 'package:swp_project_web/widgets/button/gradient_button.dart';
import 'package:swp_project_web/widgets/input/field_profile.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';
import 'package:swp_project_web/widgets/others/loading.dart';
import 'package:swp_project_web/widgets/notification/toast.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isShow = false;
  final _bloc = ProfileBloc();
  UserProfileModel profile = UserProfileModel();
  UserProfileModel inforUpdate = UserProfileModel();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetProfileEvent());
  }

  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: TopBar(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is ProfileStateLoading) {
              onLoading(context);
              return;
            } else if (state is ProfileStateSuccess) {
              Navigator.pop(context);
              profile = state.userProfileModel;
              isShow = true;
            } else if (state is UpdateProfileSuccess) {
              Navigator.pop(context);
              router.go(RouteName.home);
              toastification.show(
                  pauseOnHover: false,
                  progressBarTheme: const ProgressIndicatorThemeData(
                    color: Colors.green,
                  ),
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  foregroundColor: Colors.black,
                  context: context,
                  type: ToastificationType.success,
                  style: ToastificationStyle.minimal,
                  title: const TextContent(
                    contentText: "Cập nhật thành công!",
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  autoCloseDuration: const Duration(milliseconds: 1500),
                  animationDuration: const Duration(milliseconds: 500),
                  alignment: Alignment.topRight);
            } else if (state is ChangeAvatarSuccess) {
              Navigator.pop(context);
              showToast(
                context: context,
                msg: "Cập nhật thành công",
                color: const Color.fromARGB(255, 32, 255, 76),
                icon: const Icon(Icons.done, color: Colors.white),
                colorText: Colors.white,
              );
              _bloc.add(GetProfileEvent());
            } else if (state is ProfileStateFailure) {
              showToast(
                context: context,
                msg: state.error,
                color: Colors.orange,
                icon: const Icon(Icons.warning, color: Colors.white),
                colorText: Colors.white,
              );
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return isShow
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              screenWidth * 0.1,
                              0,
                              screenWidth * 0.1,
                              screenHeight * 0.1,
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 50),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 166, 164, 164)),
                                      color: const Color.fromARGB(
                                          253, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 30),
                                        Container(
                                          // ảnh ava
                                          width: 200,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 5,
                                              color: const Color.fromARGB(
                                                  252, 0, 0, 0),
                                            ),
                                            color: const Color.fromARGB(
                                                253, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: (profile.avatarUrl != null)
                                                  ? Image.network(
                                                          profile.avatarUrl!)
                                                      .image
                                                  : const AssetImage(
                                                      "assets/images/ava_default.png"),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const Text(
                                          'Thông tin tài khoản',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FieldProfile(
                                              label: 'Họ',
                                              controller: _emailController,
                                              widthInput: 0.3,
                                              readOnly: false,
                                              content:
                                                  profile.firstName ?? "Họ",
                                              onChangeText: (value) {
                                                setState(() {
                                                  inforUpdate.firstName = value;
                                                });
                                              },
                                            ),
                                            const SizedBox(width: 20),
                                            FieldProfile(
                                              label: 'Tên',
                                              controller: _emailController,
                                              widthInput: 0.3,
                                              readOnly: false,
                                              content:
                                                  profile.lastName ?? "...",
                                              onChangeText: (value) {
                                                setState(() {
                                                  inforUpdate.lastName = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FieldProfile(
                                              label: 'Tên đăng nhập',
                                              controller: _emailController,
                                              widthInput: 0.3,
                                              readOnly: true,
                                              content:
                                                  profile.username ?? "...",
                                            ),
                                            const SizedBox(width: 20),
                                            FieldProfile(
                                              label: 'Số CCCD',
                                              controller: _emailController,
                                              widthInput: 0.3,
                                              readOnly: false,
                                              content:
                                                  profile.identifyId ?? "...",
                                              onChangeText: (value) {
                                                setState(() {
                                                  inforUpdate.identifyId =
                                                      value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FieldProfile(
                                              label: 'Email',
                                              controller: _emailController,
                                              widthInput: 0.3,
                                              readOnly: true,
                                              content: profile.email ?? "...",
                                            ),
                                            const SizedBox(width: 20),
                                            FieldProfile(
                                              label: 'Số điện thoại',
                                              controller: _emailController,
                                              widthInput: 0.3,
                                              readOnly: false,
                                              content:
                                                  profile.phoneNumber ?? "...",
                                              onChangeText: (value) {
                                                setState(() {
                                                  inforUpdate.phoneNumber =
                                                      value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FieldProfile(
                                              label: 'Ngày sinh',
                                              controller: _emailController,
                                              widthInput: 0.3,
                                              readOnly: false,
                                              content: DateFormat("dd-MM-yyyy")
                                                      .format(DateTime.parse(
                                                          profile
                                                              .dateOfBirth!)) ??
                                                  "...",
                                            ),
                                            const SizedBox(width: 20),
                                            FieldProfile(
                                              label: 'Địa chỉ',
                                              controller: _emailController,
                                              widthInput: 0.3,
                                              readOnly: false,
                                              content: profile.address ?? "...",
                                              onChangeText: (value) {
                                                setState(() {
                                                  inforUpdate.address = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GradientButton(
                                              s: 'Cập nhật',
                                              widthButton: 0.2,
                                              onPressed: () {
                                                _bloc.add(UpdateProfileEvent(
                                                    userProfileModel:
                                                        inforUpdate));
                                              },
                                            ),
                                            const SizedBox(width: 20),
                                            GradientButton(
                                              s: 'Đổi mật khẩu',
                                              widthButton: 0.2,
                                              onPressed: () {
                                                // _bloc.add(UpdateProfileEvent(
                                                //     userProfileModel:
                                                //         inforUpdate));
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 50),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const FooterWeb(),
                      ],
                    ),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.white,
                          margin: const EdgeInsets.only(top: 100, bottom: 50),
                          height: 100,
                          // child: Image.asset(
                          //   "assets/images/loading-71.gif",
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ],
                    ),
                  );
          }),
    );
  }
}
