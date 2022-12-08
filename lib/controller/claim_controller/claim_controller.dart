import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:punchin/constant/api_url.dart';
import 'package:punchin/model/claim_model/claim_submitted.dart';

import '../../model/claim_model/claim_details.dart';

class ClaimController extends GetxController {
  var box = GetStorage();
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

  RxBool loading = true.obs;

  ///image  path fields
  ///
  RxString filledPath = "".obs;
  RxString deathCertificatePath = "".obs;
  RxString borrowerIdDocPath = "".obs;
  RxString borrowerAddressDocPath = "".obs;
  RxString nomineeIdDocPath = "".obs;
  RxString nomineeAddressDocPath = "".obs;
  RxString bankAccountDocPath = "".obs;
  RxString firOrPostmortemReportPath = "".obs;
  RxString additionalDocpath = "".obs;

  ///for claim details variable
  var claimDetailsObject = ClaimDetailsData().obs;
  var claimDetail = {}.obs;

  /// claim draft
  getClaimSubmitted({status}) async {
    log(box.read("authToken"));
    try {
      var response = await http.get(
        Uri.parse(getBankerClaimApi + "$status&page=1&limit=10"),
        headers: {
          "Content-Type": "application/json",
          "X-Xsrf-Token": box.read("authToken"),
        },
      );

      log(response.body);
      if (response.statusCode == 200) {
        return ClaimSubmitted.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        final details = jsonDecode(response.body);
        //getErrorToaster(details["message"]);
      } else if (response.statusCode == 400) {
        final details = jsonDecode(response.body);
        //getErrorToaster(details["message"]);
      } else if (response.statusCode == 405) {
        final details = jsonDecode(response.body);
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

  getClaimSubmittedOne() async {
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
      } else if (response.statusCode == 401) {
        final details = jsonDecode(response.body);
        //getErrorToaster(details["message"]);
      } else if (response.statusCode == 400) {
        final details = jsonDecode(response.body);
        //getErrorToaster(details["message"]);
      } else if (response.statusCode == 405) {
        final details = jsonDecode(response.body);
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

  getStepperFormData() async {
    try {
      var response = await http.get(
        Uri.parse("$claimDetails${Get.arguments[1].id.toString()}"),
        headers: {
          "Content-Type": "application/json",
          "X-Xsrf-Token": box.read("authToken"),
        },
      );
      log("$claimDetails${Get.arguments[1].id.toString()}");
      log("${response.statusCode}");
      if (response.statusCode == 200) {
        // return ClaimSubmitted.fromJson(jsonDecode(response.body));

        Map data = jsonDecode(response.body);

        log("var $data");
        if (data != null && data["isSuccess"]) {
          loading.value = false;
          log("Entered here");
          claimDetail.value = data["data"];
          log(claimDetail.value["borrowerName"]);
          claimDetailsObject.value = ClaimDetailsData.fromJson(data["data"]);
          log("Dat ${claimDetailsObject.value.punchinClaimId.toString()}");
        }
      } else if (response.statusCode == 401) {
        final details = jsonDecode(response.body);
        //getErrorToaster(details["message"]);
      } else if (response.statusCode == 400) {
        final details = jsonDecode(response.body);
        //getErrorToaster(details["message"]);
      } else if (response.statusCode == 405) {
        final details = jsonDecode(response.body);
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
      // path.value = basename(file.path);
      path.value = file.path;
    } else {
      // User canceled the picker
    }
    return path.value;
  }

  uploadFormData(body) async {
    var postUri = Uri.parse(formUpload);
    var request = http.MultipartRequest("POST", postUri);
    request.headers.addAll({
      "Content-Type": "application/json",
      "X-Xsrf-Token": box.read("authToken"),
    });

    ///code for adding keys
    request.fields["claimId"] = Get.arguments[1].id.toString();
    request.fields["causeOfDeath"] = documentReturn(causeofDealth.value);
    request.fields["isMinor"] = isMinor().toString();
    request.fields["borrowerIdDocType"] = documentReturn(borroweridProof.value);
    request.fields["borrowerAddressDocType"] =
        documentReturn(borrowerAddressProof.value);
    request.fields["nomineeIdDocType"] =
        documentReturn(borrowerAddressProof.value);
    request.fields["nomineeAddressDocType"] =
        documentReturn(nomineeAddressProof.value);
    request.fields["bankAccountDocType"] = documentReturn(bankProof.value);
    request.fields["additionalDocType"] = documentReturn(additionalProof.value);

    /// code for adding file image
    request.files
        .add(await http.MultipartFile.fromPath('signedForm', filledPath.value));
    request.files.add(await http.MultipartFile.fromPath(
        'deathCertificate', deathCertificatePath.value));
    request.files.add(await http.MultipartFile.fromPath(
        'borrowerIdDoc', borrowerIdDocPath.value));

    request.files.add(await http.MultipartFile.fromPath(
        'borrowerAddressDoc', borrowerAddressDocPath.value));

    request.files.add(await http.MultipartFile.fromPath(
        'nomineeIdDoc', nomineeAddressDocPath.value));

    request.files.add(await http.MultipartFile.fromPath(
        'nomineeAddressDoc', nomineeAddressDocPath.value));

    request.files.add(await http.MultipartFile.fromPath(
        'bankAccountDoc', bankAccountDocPath.value));

    request.files.add(await http.MultipartFile.fromPath(
        'FirOrPostmortemReport', firOrPostmortemReportPath.value));

    request.files.add(await http.MultipartFile.fromPath(
        'additionalDoc', additionalDocpath.value));

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);
    if (response.statusCode == 200) {
      log("Success");
      Get.rawSnackbar(
          message: "Form Submitted Successfully",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED,
          backgroundColor: Colors.green);
    } else {
      log("errorCode ${response.statusCode}");
      Get.rawSnackbar(
          message: "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED,
          backgroundColor: Colors.red);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getStepperFormData();
  }

  bool isMinor() {
    if (nominee.value == "Major") {
      return true;
    } else {
      return false;
    }
  }

  String documentReturn(text) {
    RxString temp = "".obs;
    if (text == "Aadhar Card") {
      temp.value = "AADHAR_CARD";
    } else if (text == "Passport") {
      temp.value = "PASSPORT";
    } else if (text == "Voter card") {
      temp.value = "VOTER_CARD";
    } else if (text == "Driving License") {
      temp.value = "DRIVING_LICENCE";
    } else if (text == "Bank Passbook") {
      temp.value = "BANK_PASSBOOK";
    } else if (text == "Bank Passbook") {
      temp.value = "BANK_PASSBOOK";
    } else {
      temp.value = "OTHER";
    }

    return temp.value.toString();
  }
}
