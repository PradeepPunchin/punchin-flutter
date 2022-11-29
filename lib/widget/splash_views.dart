import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth_module/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //final UserController userController =Get.find<UserController>();
  @override
  void initState() {
    // userController.initialNavigate();
    super.initState();
    Future.delayed(
        const Duration(seconds: 3), () => Get.offAll(() => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/img.png",
          height: Get.height * 0.3,
          width: Get.width,
        ),
      ),
    );
  }
}
