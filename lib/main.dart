import 'package:flutter/material.dart';
import 'package:punchin/widget/Tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:punchin/widget/splash_views.dart';


void main() {
  runApp(const MyClass());
}


class MyClass extends StatelessWidget {
  const MyClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: CustomNavigation(),
      ),
    );
  }
}
