import 'package:birthday_reminder/view/screen/background.dart';
import 'package:birthday_reminder/view/screen/login_page.dart';
import 'package:birthday_reminder/view/screen/register.dart';
import 'package:birthday_reminder/view/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button(
                  onTap: () {
                   Get.to(const LoginPage());
                  },
                  label: 'Login'),
              const SizedBox(
                height: 30,
              ),
              Button(
                  onTap: () {
                   Get.to(const RegisterScreen());
                  },
                  label: 'Register'),
            ],
          ),
        ),
      ),
    );
  }
}
