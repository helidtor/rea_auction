import 'package:flutter/material.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';
import 'package:swp_project_web/widgets/input/text_header.dart';

class FooterWeb extends StatelessWidget {
  const FooterWeb({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.25,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextHeader(contentText: 'Tổ chức đấu giá REA'),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const TextContent(contentText: 'Mã số thuế: Đang cập nhật'),
              const TextContent(
                  contentText:
                      'Đại diện: ông Nguyễn Văn A - Chức vụ: Tổng giám đốc'),
              const TextContent(contentText: 'Điện thoại: 03498799xx'),
              const TextContent(contentText: 'Email: reaauction@gmail.com'),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextHeader(contentText: 'Về chúng tôi'),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const TextContent(contentText: 'Giới thiệu'),
              const TextContent(contentText: 'Quy chế hoạt động'),
              const TextContent(contentText: 'Cơ chế giải quyết tranh chấp'),
              const TextContent(contentText: 'Hướng dẫn sử dụng'),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextHeader(contentText: 'Chính sách'),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const TextContent(contentText: 'Câu hỏi thường gặp'),
              const TextContent(
                  contentText: 'Cho thuê tổ chức đấu giá trực tuyến'),
              const TextContent(contentText: 'Văn bản pháp quy'),
              const TextContent(contentText: 'Điều khoản sử dụng'),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
