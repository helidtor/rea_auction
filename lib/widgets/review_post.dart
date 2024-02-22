import 'package:flutter/material.dart';
import 'package:swp_project_web/theme/pallete.dart';
import 'package:swp_project_web/widgets/button/gradient_button.dart';

class ReviewPost extends StatelessWidget {
  const ReviewPost({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.75,
      width: screenWidth * 0.2,
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(253, 255, 255, 255),
          ),
          color: const Color.fromARGB(253, 255, 255, 255),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Thời gian đấu giá',
              style: TextStyle(fontSize: 18, color: Pallete.hintColor),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              '01/02/2024 14:00:00',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: screenWidth * 0.18,
            height: screenHeight * 0.3,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(253, 255, 255, 255),
              ),
              color: const Color.fromARGB(253, 255, 255, 255),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/image_template.png"),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Nhà hai mặt tiền, trung tâm mặt tiền Quận 1. 3 phòng ngủ, 1 phòng khách, 3 tầng. Liên hệ ngay: 0348456125',
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                    text: 'Giá khởi điểm:',
                    style: TextStyle(fontSize: 18, color: Pallete.hintColor)),
                TextSpan(
                  text: ' 1.000.000.000',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.pinkBold,
                  shadowColor: Colors.transparent,
                ),
                child: const Text(
                  'Chi tiết',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.share,
                  color: Pallete.pinkBold,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
