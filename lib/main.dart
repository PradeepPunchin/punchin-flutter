import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:punchin/widget/splash_views.dart';

void main() {
  runApp(MyClass());
}

class MyClass extends StatelessWidget {
  MyClass({Key? key}) : super(key: key);
  // List<Map<String, dynamic>> steps1 = [{"0": 0},{"1": 1},];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) => const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        // home: ClaimFormView(),
      ),
    );
  }
}
