import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:punchin/auth_module/login_screen.dart';

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
      backgroundColor: Colors.white,
      body: Center(
        child: SvgPicture.asset(
          "assets/officiallogo.svg",
          height: Get.height * 0.15,
          width: Get.width * 0.4,
          color: Color(0xff12B5D6),
        ),
      ),
    );
  }
}
