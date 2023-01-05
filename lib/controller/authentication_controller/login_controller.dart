import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:punchin/constant/api_url.dart';
import 'package:punchin/views/login/login_screen.dart';
import 'package:punchin/widget/custom_bottom_bar.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool showPassword = true.obs;

  postlogin() async {
    try {
      Map<String, String> data = {
        "userId": email.text.toString(),
        "password": password.text.toString(),
        "platform": "ANDROID",
        "deviceInfo":GetStorage().read("deviceinfo").toString(),
      };

      var response = await http.post(
        loginApi,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        var details = jsonDecode(response.body);
        log("login details "+details.toString());
        var data = details["data"];
        var user = data["user"];

        if (user["role"] == "AGENT") {
          GetStorage().write("authToken", data["authToken"]);
          GetStorage().write("userId", data['user']["userId"]);
          GetStorage().write("firstName", data['user']["firstName"]);
          GetStorage().write("lastName", data['user']["lastName"]);
          GetStorage().write("role", data['user']["role"]);
          Get.offAll(() => CustomNavigation());
        } else {
          //getErrorToaster("you are not authorized");
        }
      } else if (response.statusCode == 401) {
        final details = jsonDecode(response.body);
        // getErrorToaster(details["message"]);
      } else if (response.statusCode == 400) {
        final details = jsonDecode(response.body);
        print(details);
        Get.rawSnackbar(
            message: "${details["message"]}",
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.zero,
            snackStyle: SnackStyle.GROUNDED,
            backgroundColor: Colors.red);
        // getErrorToaster(details["message"]);
      } else if (response.statusCode == 405) {
        final details = jsonDecode(response.body);
        //  getErrorToaster(details["message"]);
      }
    }
    // on SocketException {
    //   Get.rawSnackbar(
    //       message: "Internet Exception",
    //       snackPosition: SnackPosition.BOTTOM,
    //       margin: EdgeInsets.zero,
    //       snackStyle: SnackStyle.GROUNDED,
    //       backgroundColor: Colors.red);
    // }
    catch (e) {
      Get.rawSnackbar(
          message: "$e Error Occured",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED,
          backgroundColor: Colors.red);
    } finally {
      //btnController.value.stop();
    }
  }

  Future postLogout() async {
    final response = await http.get(
      Uri.parse(logoutApi),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      GetStorage().remove("authToken");
      Get.offAll(() => LoginScreen());
    } else {
      final details = jsonDecode(response.body);
      //getErrorToaster(details["message"]);

    }
  }
}
