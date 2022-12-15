import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:punchin/constant/api_url.dart';
import 'package:punchin/model/claim_model/claim_discrepancy_model.dart';
import 'package:punchin/model/claim_model/claim_in_progress_model.dart';
import 'package:punchin/model/claim_model/claim_submitted.dart';
import 'package:punchin/views/claim_details/details.dart';
import 'package:punchin/views/login/login_screen.dart';

import '../../model/claim_model/claim_details.dart';

class ClaimController extends GetxController {
  var box = GetStorage();
  late final PageController pageController;
  RxInt currentIndex = 0.obs;

  updateIndex(int index) {
    currentIndex.value = index;
  }

  RxString causeofDealth = "".obs;
  RxString document = "".obs;
  RxString nominee = "Major".obs;
  RxString path = "".obs;
  RxString DiscrepancyFilePath = "".obs;
  RxString filled = "".obs;
  RxString dealthCertificate = "".obs;
  RxString borroweridProof = "".obs;
  RxString borroweridProofDoc = "".obs;
  RxString borrowerAddressProof = "".obs;
  RxString borrowerAddressProofDoc = "".obs;
  RxString nomineeIdProof = "".obs;
  RxString nomineeIdProofDoc = "".obs;
  RxString nomineeAddressProof = "".obs;
  RxString nomineeAddressProofDoc = "".obs;
  RxString bankProof = "".obs;
  RxString bankProofDoc = "".obs;
  RxString firProof = "".obs;
  RxString additionalProof = "".obs;
  RxString additionalProofDoc = "".obs;
  var discrepancyData={}.obs;

  RxBool loading = true.obs;
  RxBool loadUpload = false.obs;

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

  getClaimInProgress({status}) async {

    try {
      var response = await http.get(
        Uri.parse(getAgentClaimApi + "$status&page=0&limit=100"),
        headers: {
          "Content-Type": "application/json",
          "X-Xsrf-Token": box.read("authToken"),
        },
      );



      log("dis"+response.body);
      if (response.statusCode == 200) {
        return WipInProgressModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        final details = jsonDecode(response.body);
        Get.off(()=>LoginScreen());
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
          message: "Bad Connectivity",
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

  /// claim under verification
  getClaimUnderVerification({status}) async {
    log(box.read("authToken"));
    try {
      var response = await http.get(
        Uri.parse(getAgentClaimApi + "$status&page=0&limit=10"),
        headers: {
          "Content-Type": "application/json",
          "X-Xsrf-Token": box.read("authToken"),
        },
      );


      log("inprogress"+response.body);
      if (response.statusCode == 200) {
        return WipInProgressModel.fromJson(jsonDecode(response.body));
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
          message: "Bad Connectivity",
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




  /// claim draft
  getClaimSubmitted({status}) async {
    log(box.read("authToken"));
    try {
      var response = await http.get(
        Uri.parse(getAgentClaimApi + "$status&page=0&limit=10"),
        headers: {
          "Content-Type": "application/json",
          "X-Xsrf-Token": box.read("authToken"),
        },
      );


      log(status);
      log("inprogress"+response.body);
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
          message: "Bad Connectivity",
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


  /// claim  discrepeancy document
  getClaimDiscrepeancy({id}) async {
    try {
      var response = await http.get(
        Uri.parse("$claimDetails$id/documents"),
        headers: {
          "Content-Type": "application/json",
          "X-Xsrf-Token": box.read("authToken"),
        },
      );

;      if (response.statusCode == 200) {
        // discrepancyData.value=jsonDecode(response.body);
        Map data = jsonDecode(response.body);


        if (data != null && data["isSuccess"]) {
          loading.value = false;
          discrepancyData.value = data["data"];
        }


       return ClaimDiscrepancyModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        final details = jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        final details = jsonDecode(response.body);
      } else if (response.statusCode == 405) {
        final details = jsonDecode(response.body);
      }
    } on SocketException {
      Get.rawSnackbar(
          message: "Bad Connectivity",
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
        Uri.parse(getAgentClaimApi),
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
          message: "Bad Connectivity",
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
      if (response.statusCode == 200) {
        // return ClaimSubmitted.fromJson(jsonDecode(response.body));

        Map data = jsonDecode(response.body);


        if (data != null && data["isSuccess"]) {
          loading.value = false;

          claimDetail.value = data["data"];

          claimDetailsObject.value = ClaimDetailsData.fromJson(data["data"]);

        }
      } else if (response.statusCode == 401) {
        final details = jsonDecode(response.body);
        //getErrorToaster(details["message"]);
        Get.off(()=>LoginScreen());
      } else if (response.statusCode == 400) {
        final details = jsonDecode(response.body);
        //getErrorToaster(details["message"]);
      } else if (response.statusCode == 405) {
        final details = jsonDecode(response.body);
        //getErrorToaster(details["message"]);
      }
    } on SocketException {
      Get.rawSnackbar(
          message: "Bad Connectivity",
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

  Future<String> imageFromCamera() async {
    ImagePicker picker = ImagePicker();
    XFile? imageXFile = await picker.pickImage(source: ImageSource.camera);
    log("$imageXFile");
    path.value = imageXFile!.path;

    return path.value;
  }

  uploadFormData() async {
    loadUpload.value = true;
    var postUri = Uri.parse(
        "$formUpload${Get.arguments[1].id.toString()}/uploadDocument");
    // var postUri = Uri.parse(
    //     "https://b700-223-190-95-222.in.ngrok.io/api/v1/agent/claim/${Get.arguments[1].id.toString()}/uploadDocument");
    log(postUri.toString());
    var request = http.MultipartRequest("Put", postUri);
    Map<String, String> headers = {
      // "Content-Type": "multipart/form-data",
      "X-Xsrf-Token": box.read("authToken"),
    };
    request.headers.addAll(headers);

    ///code for adding keys
    log(Get.arguments[1].id.toString());
    request.fields["claimId"] = Get.arguments[1].id.toString();
    log(documentReturn(causeofDealth.value));
    request.fields["causeOfDeath"] = documentReturn(causeofDealth.value);
    log(isMinor().toString());
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
    log("Path is ${filledPath.value}");

    if (filledPath.value.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'signedForm',
          filledPath.value,
          contentType: MediaType('file', 'pdf'),
        ),
      );
    }

    if (deathCertificatePath.value.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'deathCertificate',
          deathCertificatePath.value,
          contentType: MediaType('file', 'pdf'),
        ),
      );
    }
    if (borrowerIdDocPath.value.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'borrowerIdDoc',
          borrowerIdDocPath.value,
          contentType: MediaType('file', 'pdf'),
        ),
      );
    }

    if (borrowerAddressDocPath.value.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'borrowerAddressDoc',
          borrowerAddressDocPath.value,
          contentType: MediaType('file', 'pdf'),
        ),
      );
    }

    if (nomineeAddressDocPath.value.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'nomineeIdDoc',
          nomineeAddressDocPath.value,
          contentType: MediaType('file', 'pdf'),
        ),
      );
    }

    if (nomineeAddressDocPath.value.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'nomineeAddressDoc',
          nomineeAddressDocPath.value,
          contentType: MediaType('file', 'pdf'),
        ),
      );
    }

    if (bankAccountDocPath.value.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'bankAccountDoc',
          bankAccountDocPath.value,
          contentType: MediaType('file', 'pdf'),
        ),
      );
    }

    if (firOrPostmortemReportPath.value.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'FirOrPostmortemReport',
          firOrPostmortemReportPath.value,
          contentType: MediaType('file', 'pdf'),
        ),
      );
    }

    if (additionalDocpath.value.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'additionalDoc',
          additionalDocpath.value,
          contentType: MediaType('file', 'pdf'),
        ),
      );
    }
    log("Request $request");
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    log("${responsed.statusCode}");

    //final responseData = json.decode(responsed.body);
    // log("$responseData");
    if (response.statusCode == 200) {
      loadUpload.value = false;
      Get.rawSnackbar(
          message: "Form Submitted Successfully",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED,
          backgroundColor: Colors.green);

      Get.offAll(() => Details(
            title: 'Allocated',
          ));
      log("Success");
    } else {
      loadUpload.value = false;
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
    pageController = PageController(initialPage: 0);
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
    } else if (text == "Bank passbook") {
      temp.value = "BANK_PASSBOOK";
    } else if (text == "Bank statement") {
      temp.value = "BANK_STATEMENT";
    } else if (text == "Cheque") {
      temp.value = "CHEQUE_LEAF";
    } else if (text == "Neft form") {
      temp.value = "NEFT_FORM";
    } else if (text == "Income Tax Return") {
      temp.value = "INCOME_TAX_RETURN";
    } else if (text == "Medical Records") {
      temp.value = "MEDICAL_RECORDS";
    } else if (text == "Legal Heir Certificate") {
      temp.value = "LEGAL_HEIR_CERTIFICATE";
    } else if (text == "Police Investigation Report") {
      temp.value = "POLICE_INVESTIGATION_REPORT";
    } else {
      temp.value = "OTHER";
    }

    return temp.value.toString();
  }



  /// claim discrepancy file
  /// upload file
  Future<String> discrepancyFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'jpg', 'jpeg']);

    if (result != null) {
      File file = File(result.files.single.path!);
      // path.value = basename(file.path);
      path.value = file.path;
      print("file part "+path.value.toString());
    } else {
      // User canceled the picker
    }
    print("file part "+ path.value.toString());
    return path.value;
  }

  uploadDiscrepancyData({id,docType}) async {
    loadUpload.value = true;
    var postUri = Uri.parse(
        "$formUpload$id/discrepancy-document-upload/$docType");
    log(postUri.toString());
    var request = http.MultipartRequest("Post", postUri);
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "X-Xsrf-Token": box.read("authToken"),
    };
    request.headers.addAll(headers);


    /// code for adding file image
    log("Path is 1 ${additionalDocpath.value}");


    if (additionalDocpath.value.isNotEmpty) {
      print("1"+additionalDocpath.value);
      request.files
          .add(await http.MultipartFile.fromPath('multipartFile', additionalDocpath.value,));
      // request.files.add(
      //   await http.MultipartFile.fromPath(
      //     '$docType',
      //     additionalDocpath.value,
      //     contentType: MediaType('file', 'jpg'),
      //   ),
      // );
    }
    print(additionalDocpath.value.isNotEmpty);
    print(request.files.length.toString());
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    log("${responsed.statusCode}");

    if (response.statusCode == 200) {
      moveToVerify(id: id);
      loadUpload.value = false;
      Get.rawSnackbar(
          message: "Form Submitted Successfully",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED,
          backgroundColor: Colors.green);

      Get.offAll(() => Details(
        title: 'WIP',
      ));

    } else {
      loadUpload.value = false;
      log("errorCode ${response.statusCode}");
      Get.rawSnackbar(
          message: "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED,
          backgroundColor: Colors.red);
    }
  }


  /// get verify
 moveToVerify({id}) async {
    loadUpload.value = true;
    var postUri = Uri.parse(
        "$formUpload$id/forward-to-verifier");
    Map<String,dynamic> data={
      "id":id,
    };
    log(postUri.toString());
    var response= await http.post(postUri,
        headers :{

          "X-Xsrf-Token": box.read("authToken"),
        },
    body: jsonEncode(data),
    );



    if (response.statusCode == 200) {
      loadUpload.value = false;
      Get.rawSnackbar(
          message: "Form Submitted Successfully",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED,
          backgroundColor: Colors.green);

      Get.offAll(() => Details(
        title: 'WIP',
      ));

    } else {
      loadUpload.value = false;
      log("errorCode ${response.statusCode}");
      Get.rawSnackbar(
          message: "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED,
          backgroundColor: Colors.red);
    }
  }
}
