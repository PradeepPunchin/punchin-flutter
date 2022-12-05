import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchin/controller/user_controller/user_controller.dart';
import 'package:punchin/views/login/login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserController userController = Get.put(UserController());//Get.find<UserController>();
  @override
  void initState() {
    userController.initialNavigate();
    super.initState();
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
