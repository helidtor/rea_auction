import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/screens/customer/home/home_page.dart';
import 'package:swp_project_web/widgets/button/gradient_button.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class PaySuccess extends StatefulWidget {
  const PaySuccess({super.key});

  @override
  State<PaySuccess> createState() => _PaySuccessState();
}

class _PaySuccessState extends State<PaySuccess> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              SizedBox(
                width: 400,
                height: 400,
                child: Image.asset(
                  'assets/images/success_payments.png',
                  fit: BoxFit.cover,
                ),
              ),
              GradientButton(
                s: 'Trở về trang chủ',
                widthButton: 0.2,
                onPressed: () async {
                  // SharedPreferences prefs =
                  //     await SharedPreferences.getInstance();
                  // int? idAuction = prefs.getInt("idAuctionPayment");
                  // if (idAuction != null) {
                  //   var checkPay = await ApiProvider.paymentDeposit(idAuction);
                  //   if (checkPay == true) {
                  //     Navigator.pushReplacement(
                  //         // ignore: use_build_context_synchronously
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (BuildContext context) =>
                  //                 const HomePage()));
                  //   }
                  // }
                  // Navigator.pushReplacement(
                  //     // ignore: use_build_context_synchronously
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => const HomePage()));
                  _launchURL('http://localhost:55554/#/home');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
      Navigator.pop(context);
    } else {
      throw 'Could not launch $url';
    }
  }
}
