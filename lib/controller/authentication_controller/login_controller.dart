import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:punchin/constant/api_url.dart';
import 'package:punchin/widget/custom_bottom_bar.dart';
import 'package:punchin/widget/custom_snackBar.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool showPassword = true.obs;

   postlogin() async {
    try{

      Map<String, String> data={

        "userId":email.text.toString(),
        "password":password.text.toString(),
      };



      var response = await http.post(
        loginApi,
        headers: {
          "Content-Type":"application/json",
        },
        body: jsonEncode(data),
      );

      print(response.body);
      print(data);
      print(loginApi);
      print(response.statusCode);
      if (response.statusCode==200) {

        var details= jsonDecode(response.body);

        Get.offAll(() => CustomNavigation());


       // return  LoginResponse.fromJson(jsonDecode(response.body));
      }
      if(response.statusCode==401){
        final details=jsonDecode(response.body);
        getSuccessToaster(details["message"]);
      }
      if(response.statusCode==400){
        final details=jsonDecode(response.body);
        getSuccessToaster(details["message"]);
      }
      if(response.statusCode==405){
        final details=jsonDecode(response.body);
        getSuccessToaster(details["message"]);
      }
    }
    on SocketException {
      Get.rawSnackbar(
          message: "Internet Exception",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED,
          backgroundColor: Colors.red);
    } catch (e) {
      Get.rawSnackbar(
          message: " $e Error Occured",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED,
          backgroundColor: Colors.red);
    } finally {
      //btnController.value.stop();
    }

  }

}
