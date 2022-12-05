

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchin/constant/api_url.dart';
import 'package:punchin/model/home_model/home_count_model.dart';
import 'package:punchin/widget/custom_snackBar.dart';

class HomeController extends GetxController{

  var box =GetStorage();

  Future homeCount() async {

    try {
      final response = await http.get(
        Uri.parse(homeCountApi),
        headers: {
          "Content-Type": "application/json",
          "X-Xsrf-Token": box.read("authToken"),
        },

      );
      if (response.statusCode == 200) {

        return HomeCount.fromJson(jsonDecode(response.body));
      }
      else if(response.statusCode==401){
        final details=jsonDecode(response.body);
        getErrorToaster(details["message"]);
      }
      else if(response.statusCode==400){
        final details=jsonDecode(response.body);
        getErrorToaster(details["message"]);
      }
      else if(response.statusCode==405){
        final details=jsonDecode(response.body);
        getErrorToaster(details["message"]);
      }
    } on SocketException {
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