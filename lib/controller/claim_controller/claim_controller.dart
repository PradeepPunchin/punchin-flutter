import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:punchin/constant/api_url.dart';
import 'package:punchin/model/claim_model/claim_submitted.dart';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';





class ClaimController extends GetxController{


  var box =GetStorage();
  RxString causeofDealth = "".obs;
  RxString document = "".obs;
  RxString nominee = "Major".obs;
  RxString path = "".obs;
  RxString filled = "".obs;
  RxString dealthCertificate = "".obs;
  RxString borroweridProof = "".obs;
  RxString borrowerAddressProof = "".obs;
  RxString nomineeIdProof = "".obs;
  RxString nomineeAddressProof = "".obs;
  RxString bankProof = "".obs;
  RxString firProof = "".obs;
  RxString additionalProof = "".obs;


  /// claim draft
   getClaimSubmitted() async {

    try {
      var response = await http.get(
        Uri.parse(getBankerClaimApi),
        headers: {
          "Content-Type": "application/json",
          "X-Xsrf-Token": box.read("authToken"),
        },

      );

      if (response.statusCode == 200) {
        return ClaimSubmitted.fromJson(jsonDecode(response.body));
      }
      else if(response.statusCode==401){
        final details=jsonDecode(response.body);
        //getErrorToaster(details["message"]);
      }
      else if(response.statusCode==400){
        final details=jsonDecode(response.body);
        //getErrorToaster(details["message"]);
      }
      else if(response.statusCode==405){
        final details=jsonDecode(response.body);
        //getErrorToaster(details["message"]);
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


  /// upload file
  Future<String> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'jpg', 'jpeg']);

    if (result != null) {
      File file = File(result.files.single.path!);
      path.value = basename(file.path);
    } else {
      // User canceled the picker
    }
    return path.value;
  }

}