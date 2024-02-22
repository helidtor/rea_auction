import 'package:flutter/material.dart';
import 'package:swp_project_web/widgets/bar/footer_web.dart';
import 'package:swp_project_web/widgets/button/gradient_button.dart';
import 'package:swp_project_web/widgets/input/input_field.dart';
import 'package:swp_project_web/widgets/bar/top_bar.dart';

class CreateForm extends StatefulWidget {
  const CreateForm({Key? key}) : super(key: key);

  @override
  State<CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: screenWidth * 0.15,
                right: screenWidth * 0.15,
                // bottom: screenHeight * 0.05,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(166, 166, 164, 164)),
                  color: const Color.fromARGB(253, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 60,
                        ),
                        Text(
                          'Thông tin bài viết',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InputField(
                          content: 'Tiêu đề',
                          controller: _emailController,
                          widthInput: 0.3,
                        ),
                        const SizedBox(width: 20),
                        InputField(
                            content: 'Mô tả',
                            controller: _emailController,
                            widthInput: 0.3),
                      ],
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      content: 'Tên đăng nhập',
                      controller: _emailController,
                      widthInput: 0.61,
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      content: 'Mật khẩu',
                      controller: _emailController,
                      widthInput: 0.61,
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      content: 'Nhập lại mật khẩu',
                      controller: _emailController,
                      widthInput: 0.61,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InputField(
                          content: 'Email',
                          controller: _emailController,
                          widthInput: 0.2,
                        ),
                        const SizedBox(width: 10),
                        InputField(
                          content: 'Số điện thoại',
                          controller: _emailController,
                          widthInput: 0.2,
                        ),
                        const SizedBox(width: 10),
                        InputField(
                            content: 'Giới tính',
                            controller: _emailController,
                            widthInput: 0.2),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     InputField(
                    //       content: 'Email',
                    //       controller: _emailController,
                    //       widthInput: 0.2,
                    //     ),
                    //     const SizedBox(width: 10),
                    //     InputField(
                    //       content: 'Số điện thoại',
                    //       controller: _emailController,
                    //       widthInput: 0.2,
                    //     ),
                    //     const SizedBox(width: 10),
                    //     InputField(
                    //         content: 'Giới tính',
                    //         controller: _emailController,
                    //         widthInput: 0.2),
                    //   ],
                    // ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InputField(
                          content: 'Ngày sinh',
                          controller: _emailController,
                          widthInput: 0.3,
                        ),
                        const SizedBox(width: 20),
                        InputField(
                            content: 'Địa chỉ',
                            controller: _emailController,
                            widthInput: 0.3),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InputField(
                          content: 'Số CCCD/CMND',
                          controller: _emailController,
                          widthInput: 0.2,
                        ),
                        const SizedBox(width: 10),
                        InputField(
                          content: 'Ngày cấp',
                          controller: _emailController,
                          widthInput: 0.2,
                        ),
                        const SizedBox(width: 10),
                        InputField(
                            content: 'Nơi cấp',
                            controller: _emailController,
                            widthInput: 0.2),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.15,
                right: screenWidth * 0.15,
                bottom: screenHeight * 0.05,
                top: 3,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(166, 166, 164, 164)),
                  color: const Color.fromARGB(253, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 60,
                        ),
                        Text(
                          'Thông tin tài sản',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InputField(
                          content: "Tiêu đề",
                          controller: _emailController,
                          widthInput: 0.3,
                        ),
                        const SizedBox(width: 20),
                        InputField(
                            content: "Mô tả",
                            controller: _emailController,
                            widthInput: 0.3),
                      ],
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      content: 'Tên đăng nhập',
                      controller: _emailController,
                      widthInput: 0.61,
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      content: 'Mật khẩu',
                      controller: _emailController,
                      widthInput: 0.61,
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      content: 'Nhập lại mật khẩu',
                      controller: _emailController,
                      widthInput: 0.61,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InputField(
                          content: 'Email',
                          controller: _emailController,
                          widthInput: 0.2,
                        ),
                        const SizedBox(width: 10),
                        InputField(
                          content: 'Số điện thoại',
                          controller: _emailController,
                          widthInput: 0.2,
                        ),
                        const SizedBox(width: 10),
                        InputField(
                            content: 'Giới tính',
                            controller: _emailController,
                            widthInput: 0.2),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     InputField(
                    //       content: 'Email',
                    //       controller: _emailController,
                    //       widthInput: 0.2,
                    //     ),
                    //     const SizedBox(width: 10),
                    //     InputField(
                    //       content: 'Số điện thoại',
                    //       controller: _emailController,
                    //       widthInput: 0.2,
                    //     ),
                    //     const SizedBox(width: 10),
                    //     InputField(
                    //         content: 'Giới tính',
                    //         controller: _emailController,
                    //         widthInput: 0.2),
                    //   ],
                    // ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InputField(
                          content: 'Ngày sinh',
                          controller: _emailController,
                          widthInput: 0.3,
                        ),
                        const SizedBox(width: 20),
                        InputField(
                            content: 'Địa chỉ',
                            controller: _emailController,
                            widthInput: 0.3),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InputField(
                          content: 'Số CCCD/CMND',
                          controller: _emailController,
                          widthInput: 0.2,
                        ),
                        const SizedBox(width: 10),
                        InputField(
                          content: 'Ngày cấp',
                          controller: _emailController,
                          widthInput: 0.2,
                        ),
                        const SizedBox(width: 10),
                        InputField(
                            content: 'Nơi cấp',
                            controller: _emailController,
                            widthInput: 0.2),
                      ],
                    ),
                    const SizedBox(height: 50),
                    const GradientButton(
                      s: 'Gửi đơn',
                      widthButton: 0.611,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            const FooterWeb(),
          ],
        ),
      ),
    );
  }
}
