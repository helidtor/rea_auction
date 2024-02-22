import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/models/response/user_profile_model.dart';
import 'package:swp_project_web/router/router.dart';
import 'package:swp_project_web/screens/profile/bloc/profile.event.dart';
import 'package:swp_project_web/screens/profile/bloc/profile_bloc.dart';
import 'package:swp_project_web/screens/profile/bloc/profile_state.dart';
import 'package:swp_project_web/widgets/bar/footer_web.dart';
import 'package:swp_project_web/widgets/bar/top_bar.dart';
import 'package:swp_project_web/widgets/button/gradient_button.dart';
import 'package:swp_project_web/widgets/input/field_profile.dart';
import 'package:swp_project_web/widgets/input/input_field.dart';
import 'package:swp_project_web/widgets/others/loading.dart';
import 'package:swp_project_web/widgets/others/toast.dart';

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
              print("Thông tin profile: $profile");
              isShow = true;
            } else if (state is ChangeAvatarSuccess) {
              Navigator.pop(context);
              showToast(
                context: context,
                msg: "Cập nhật thành công",
                color: const Color.fromARGB(255, 32, 255, 76),
                icon: const Icon(Icons.done),
              );
              _bloc.add(GetProfileEvent());
            } else if (state is UpdateProfileSuccess) {
              Navigator.pop(context);
              showToast(
                context: context,
                msg: "Update successfully",
                color: const Color.fromARGB(255, 32, 255, 76),
                icon: const Icon(Icons.done),
              );
            } else if (state is ProfileStateFailure) {
              showToast(
                context: context,
                msg: state.error,
                color: Colors.orange,
                icon: const Icon(Icons.warning),
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
                                                inforUpdate.firstName = value;
                                              },
                                            ),
                                            const SizedBox(width: 20),
                                            FieldProfile(
                                              label: 'Tên',
                                              controller: _emailController,
                                              widthInput: 0.3,
                                              readOnly: false,
                                              content: profile.lastName ?? "",
                                              onChangeText: (value) {
                                                inforUpdate.lastName = value;
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
                                              content: profile.username ?? "",
                                            ),
                                            const SizedBox(width: 20),
                                            FieldProfile(
                                              label: 'Số CCCD',
                                              controller: _emailController,
                                              widthInput: 0.3,
                                              readOnly: false,
                                              content: profile.identifyId ?? "",
                                              onChangeText: (value) {
                                                inforUpdate.identifyId = value;
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
                                              content: profile.email ?? "",
                                            ),
                                            const SizedBox(width: 20),
                                            FieldProfile(
                                              label: 'Số điện thoại',
                                              controller: _emailController,
                                              widthInput: 0.3,
                                              readOnly: false,
                                              content:
                                                  profile.phoneNumber ?? "",
                                              onChangeText: (value) {
                                                inforUpdate.phoneNumber = value;
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
                                              content:
                                                  profile.dateOfBirth ?? "",
                                            ),
                                            const SizedBox(width: 20),
                                            FieldProfile(
                                              label: 'Địa chỉ',
                                              controller: _emailController,
                                              widthInput: 0.3,
                                              readOnly: false,
                                              content: profile.address ?? "",
                                              onChangeText: (value) {
                                                inforUpdate.address = value;
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                print(
                                                    "Thông tin thay đổi update profile: $inforUpdate");
                                                _bloc.add(UpdateProfileEvent(
                                                    userProfileModel:
                                                        inforUpdate));
                                              },
                                              child: const GradientButton(
                                                s: 'Cập nhật',
                                                widthButton: 0.2,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            const GradientButton(
                                              s: 'Đổi mật khẩu',
                                              widthButton: 0.2,
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
