import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persist_ventures_asn/pages/home_page.dart';
import 'package:persist_ventures_asn/pages/signin_page.dart';

import '../controllers/auth_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      bool isUser = await _authController.isUserLoggedIn();
      if (isUser) {
        Get.to(const HomePage());
      } else {
        Get.to(const SigninPage());
      }
    });

    // _authController.saveUserNameToShared();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/ngbrgd_logo.png",
        ),
      ),
    );
  }
}
