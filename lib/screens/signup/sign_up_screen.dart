import 'package:flutter/material.dart';
import 'package:swp_project_web/router/router.dart';
import 'package:swp_project_web/screens/contact/contact_infor.dart';
import 'package:swp_project_web/screens/login/login_screen.dart';
import 'package:swp_project_web/widgets/bar/footer_web.dart';
import 'package:swp_project_web/widgets/button/gradient_button.dart';
import 'package:swp_project_web/widgets/input/input_field.dart';
import 'package:swp_project_web/widgets/selection_app_bar.dart';
import 'package:swp_project_web/widgets/bar/top_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: TopBar(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/register_screen.jpg"),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.1,
                      screenHeight * 0.1,
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
                                  color:
                                      const Color.fromARGB(255, 166, 164, 164)),
                              color: const Color.fromARGB(253, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                const Text(
                                  'Đăng ký tài khoản',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Bạn đã có tài khoản?',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        router.go(RouteName.login);
                                      },
                                      child: const FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'Đăng nhập ngay',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 226, 62, 87),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InputField(
                                      hintText: 'Họ',
                                      controller: _emailController,
                                      widthInput: 0.3,
                                    ),
                                    const SizedBox(width: 20),
                                    InputField(
                                        hintText: 'Tên',
                                        controller: _emailController,
                                        widthInput: 0.3),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                InputField(
                                  hintText: 'Tên đăng nhập',
                                  controller: _emailController,
                                  widthInput: 0.61,
                                ),
                                const SizedBox(height: 20),
                                InputField(
                                  hintText: 'Mật khẩu',
                                  controller: _emailController,
                                  widthInput: 0.61,
                                ),
                                const SizedBox(height: 20),
                                InputField(
                                  hintText: 'Nhập lại mật khẩu',
                                  controller: _emailController,
                                  widthInput: 0.61,
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InputField(
                                      hintText: 'Email',
                                      controller: _emailController,
                                      widthInput: 0.2,
                                    ),
                                    const SizedBox(width: 10),
                                    InputField(
                                      hintText: 'Số điện thoại',
                                      controller: _emailController,
                                      widthInput: 0.2,
                                    ),
                                    const SizedBox(width: 10),
                                    InputField(
                                        hintText: 'Giới tính',
                                        controller: _emailController,
                                        widthInput: 0.2),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     InputField(
                                //       hintText: 'Email',
                                //       controller: _emailController,
                                //       widthInput: 0.2,
                                //     ),
                                //     const SizedBox(width: 10),
                                //     InputField(
                                //       hintText: 'Số điện thoại',
                                //       controller: _emailController,
                                //       widthInput: 0.2,
                                //     ),
                                //     const SizedBox(width: 10),
                                //     InputField(
                                //         hintText: 'Giới tính',
                                //         controller: _emailController,
                                //         widthInput: 0.2),
                                //   ],
                                // ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InputField(
                                      hintText: 'Ngày sinh',
                                      controller: _emailController,
                                      widthInput: 0.3,
                                    ),
                                    const SizedBox(width: 20),
                                    InputField(
                                        hintText: 'Địa chỉ',
                                        controller: _emailController,
                                        widthInput: 0.3),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InputField(
                                      hintText: 'Số CCCD/CMND',
                                      controller: _emailController,
                                      widthInput: 0.2,
                                    ),
                                    const SizedBox(width: 10),
                                    InputField(
                                      hintText: 'Ngày cấp',
                                      controller: _emailController,
                                      widthInput: 0.2,
                                    ),
                                    const SizedBox(width: 10),
                                    InputField(
                                        hintText: 'Nơi cấp',
                                        controller: _emailController,
                                        widthInput: 0.2),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const GradientButton(
                                  s: 'Đăng ký',
                                  widthButton: 0.611,
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
          ),
        ],
      ),
    );
  }
}
