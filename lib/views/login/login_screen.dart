import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';

import '../../controller/authentication_controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: loginController.formKey,
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.12,
              ),
              Image.asset("assets/insurance.png"),
              SizedBox(
                height: 15.0.h,
              ),
              Center(child: Image.asset("assets/img.png")),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Text(
                "Please login to continue",
                style:
                    CustomFonts.getMultipleStyle(15.0, kBlack, FontWeight.w400),
              ),
              SizedBox(
                height: 10.0.h,
              ),
              emailContainer(),
              SizedBox(
                height: 15.0.h,
              ),
              phoneContainer(),
              SizedBox(
                height: 15.0.h,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: MaterialButton(
                  height: 53,
                  minWidth: Get.width,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: kdarkBlue,
                  onPressed: () {
                    if (loginController.formKey.currentState!.validate()) {
                      // Get.off(()=>VerifcationScreen());
                    }
                  },
                  child: Text(
                    "Login",
                    style: CustomFonts.getMultipleStyle(
                        15.0, Colors.white, FontWeight.w400),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget emailContainer() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: kGrey)),
        child: Row(
          children: [
            const Icon(
              Icons.person,
              color: kdarkBlue,
            ),
            SizedBox(
              width: Get.width * 0.05,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Full Name",
                    style: CustomFonts.getMultipleStyle(
                        15.0, kBlack, FontWeight.w400),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name cannot be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter your Full Name",
                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                        hintStyle: CustomFonts.getMultipleStyle(
                            14.0, kTextFieldGrey, FontWeight.w400),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none),
                  )
                ],
              ),
            )
          ],
        ),
      );

  Widget phoneContainer() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: kGrey)),
        child: Row(
          children: [
            const Icon(
              Icons.phone_android,
              color: kdarkBlue,
            ),
            SizedBox(
              width: Get.width * 0.05,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Enter Mobile Number",
                    style: CustomFonts.getMultipleStyle(
                        15.0, kBlack, FontWeight.w400),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Phone cannot be empty";
                      } else if (value.length < 10) {
                        return "Phone  number length short";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter your Mobile Number",
                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                        hintStyle: CustomFonts.getMultipleStyle(
                            14.0, kTextFieldGrey, FontWeight.w400),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none),
                  )
                ],
              ),
            )
          ],
        ),
      );
}
