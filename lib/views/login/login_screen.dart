import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/widget/Tab_bar.dart';

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
                      // Get.off(()=>OtpV());
                      FocusManager.instance.primaryFocus?.unfocus();
                      Get.offAll(() => CustomNavigation());
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
              Icons.email,
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
                    "User Id",
                    style: CustomFonts.getMultipleStyle(
                        15.0, kBlack, FontWeight.w400),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "userid cannot be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter your user id",
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
              Icons.visibility,
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
                    "Password",
                    style: CustomFonts.getMultipleStyle(
                        15.0, kBlack, FontWeight.w400),
                  ),
                  Obx(() => TextFormField(
                        obscureText: loginController.showPassword.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                loginController.showPassword.value =
                                    !loginController.showPassword.value;
                              },
                              child: loginController.showPassword.value
                                  ? const Icon(
                                      Icons.visibility,
                                      size: 20.0,
                                      color: kdarkBlue,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      size: 20.0,
                                      color: kdarkBlue,
                                    ),
                            ),
                            hintText: "Enter your Password",
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 5),
                            hintStyle: CustomFonts.getMultipleStyle(
                                14.0, kTextFieldGrey, FontWeight.w400),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      ))
                ],
              ),
            )
          ],
        ),
      );
}
