import 'package:flutter/material.dart';


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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white ,
      body: Center(
        child:Image.asset("testing",
          height: 110,
          width: 258,
        ),
      ),
    );
  }
}



