import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:async/async.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:punchin/constant/api_url.dart';
import 'package:punchin/model/claim_model/claim_discrepancy_model.dart';
import 'package:punchin/model/claim_model/claim_in_progress_model.dart';
import 'package:punchin/model/claim_model/claim_submitted.dart';
import 'package:punchin/model/tracking_model/tracking_model.dart';
import 'package:punchin/views/claim_details/details.dart';
import 'package:punchin/views/login/login_screen.dart';

import '../../model/claim_model/claim_details.dart';

class ClaimController extends GetxController {
  RxString RelationProof = ''.obs;
  RxString GUARDIAN_ID_PROOF = ''.obs;
  RxString GUARDIAN_ADD_PROOF = ''.obs;

  var box = GetStorage();
  late final PageController pageController;
  RxInt currentIndex = 0.obs;

  updateIndex(int index) {
    currentIndex.value = index;
  }

  RxString causeofDeath = "".obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
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
  var discrepancyData = {}.obs;

  RxBool agentRemarkValue = false.obs;
  RxString agentRemarkDropDownValue = "".obs;

  RxBool loading = true.obs;
  RxBool loadUpload = false.obs;

  RxString minorDropdown = "".obs;
  RxList minor = [].obs;
  RxList minorImage = [].obs;
  RxString minorProof = "".obs;
  RxString minorProofPath = "".obs;
  RxList minorNominee = [].obs;

  /// Additional
  List additionalList = [].obs;
  List additionalImage = [].obs;
  List additionalDropDownList = [].obs;

  addProductLot({selectedValue, imagePath, dropDownValue}) {
    log(dropDownValue.toString());

    if (minorNominee.value.contains(dropDownValue.toString())) {
      Fluttertoast.showToast(
          msg: "File Already Exists for $selectedValue",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Map<String, dynamic> trendColorMap = {
        'image_path': imagePath,
        'dropDownValue': dropDownValue
      };
      jsonEncode(trendColorMap);
      minor.addAll({jsonEncode(trendColorMap)});
      minorNominee.add(dropDownValue);
      minorImage.add(imagePath);
      log("$minor");
      log("$minorImage");
    }
  }

  additionalDocumentList({selectedValue, imagePath, dropDownValue}) {
    if (additionalDropDownList.contains(dropDownValue.toString())) {
      Fluttertoast.showToast(
          msg: "File Already Exists for $selectedValue",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Map<String, dynamic> trendColorMap = {
        'image_path': imagePath,
        'dropDownValue': dropDownValue
      };
      jsonEncode(trendColorMap);
      additionalList.addAll({jsonEncode(trendColorMap)});
      additionalDropDownList.add(dropDownValue);
      additionalImage.add(imagePath);
      log("$additionalList");
      log("$additionalImage");
    }
  }

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
      if (response.statusCode == 200) {
        return WipInProgressModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        final details = jsonDecode(response.body);
        Get.off(() => LoginScreen());
        //getErrorToaster(details["message"]);
      } else if (response.statusCode == 400) {
        final details = jsonDecode(response.body);
        //getErrorToaster(details["message"]);
      } else if (response.statusCode == 405) {
        final details = jsonDecode(response.body);
        //getErrorToaster(details["message"]);
      }
    }
    catch (e) {
      print("2");
      print(e);
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
    try {
      var response = await http.get(
        Uri.parse(getAgentClaimApi + "$status&page=0&limit=200"),
        headers: {
          "Content-Type": "application/json",
          "X-Xsrf-Token": box.read("authToken"),
        },
      );
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
    }
    // on SocketException {
    //   Get.rawSnackbar(
    //       message: "Bad Connectivity",
    //       snackPosition: SnackPosition.BOTTOM,
    //       margin: EdgeInsets.zero,
    //       snackStyle: SnackStyle.GROUNDED,
    //       backgroundColor: Colors.red);
    // }

    catch (e) {
      print("1");
      print(e);
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

  getClaimSearch({status, searchKey}) async {
    try {
      if (status != null &&
          (searchController.value.text == '' ||
              searchController.value.text == null ||
              searchController.value.text == "null")) {
        var Url = getAgentClaimApi + "ALLOCATED&page=0&limit=200";
        var response = await http.get(
          Uri.parse(Url),
          headers: {
            "Content-Type": "application/json",
            "X-Xsrf-Token": box.read("authToken"),
          },
        );
        if (response.statusCode == 200) {
          log(response.body);
          return ClaimSubmitted.fromJson(jsonDecode(response.body));
        }
        if (response.statusCode == 404) {
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
      } else {
        var Url =
            "$SearchApi${dropDownSearchChecker(causeofDeath.value)}&searchedKeyword=${searchKey.toString()}&claimDataFilter=${status}&pageNo=0&limit=200";
        print(Url);

        var response = await http.get(
          Uri.parse(Url),
          headers: {
            "Content-Type": "application/json",
            // "Accept": "application/json",
            "X-Xsrf-Token": box.read("authToken"),
          },
        );
        print(Url);
        print(response.body);

        if (response.statusCode == 200) {
          return ClaimSubmitted.fromJson(jsonDecode(response.body));
          var body = ClaimSubmitted.fromJson(jsonDecode(response.body));
          log("claim body" + body.toString());
        }
        if (response.statusCode == 404) {
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
      }
    }
    // on SocketException {
    //   Get.rawSnackbar(
    //       message: "Bad Connectivity",
    //       snackPosition: SnackPosition.BOTTOM,
    //       margin: EdgeInsets.zero,
    //       snackStyle: SnackStyle.GROUNDED,
    //       backgroundColor: Colors.red);
    // }
    catch (e) {
      // print("12345" + e.toString());
      // print(e);
      // Get.rawSnackbar(
      //     message: " $e Error Occured",
      //     snackPosition: SnackPosition.BOTTOM,
      //     margin: EdgeInsets.zero,
      //     snackStyle: SnackStyle.GROUNDED,
      //     backgroundColor: Colors.red);
    } finally {
      //btnController.value.stop();
    }
  }

  /// claim draft
  getClaimSubmitted({status}) async {
    try {
      if (status == null) {
        var response = await http.get(
          Uri.parse(getAgentClaimApi + "$status&page=0&limit=200"),
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
      } else {
        var response = await http.get(
          Uri.parse(SearchApi +
              "${causeofDeath.value}&searchedKeyword=searchKey&pageNo=0&limit=200"),
          headers: {
            "Content-Type": "application/json",
            "X-Xsrf-Token": box.read("authToken"),
          },
        );

        log("search message" + response.body);
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
      }
    }
    // on SocketException {
    //   Get.rawSnackbar(
    //       message: "Bad Connectivity",
    //       snackPosition: SnackPosition.BOTTOM,
    //       margin: EdgeInsets.zero,
    //       snackStyle: SnackStyle.GROUNDED,
    //       backgroundColor: Colors.red);
    // }
    catch (e) {
      // print("6");
      // print(e);
      // Get.rawSnackbar(
      //     message: " $e Error Occured",
      //     snackPosition: SnackPosition.BOTTOM,
      //     margin: EdgeInsets.zero,
      //     snackStyle: SnackStyle.GROUNDED,
      //     backgroundColor: Colors.red);
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


      log(response.body);
      if (response.statusCode == 200) {
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
    }
    // on SocketException {
    //   Get.rawSnackbar(
    //       message: "Bad Connectivity",
    //       snackPosition: SnackPosition.BOTTOM,
    //       margin: EdgeInsets.zero,
    //       snackStyle: SnackStyle.GROUNDED,
    //       backgroundColor: Colors.red);
    // }
    catch (e) {
      // print("5");
      // print(e);
      // Get.rawSnackbar(
      //     message: " $e Error Occured",
      //     snackPosition: SnackPosition.BOTTOM,
      //     margin: EdgeInsets.zero,
      //     snackStyle: SnackStyle.GROUNDED,
      //     backgroundColor: Colors.red);
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
    }
    // on SocketException {
    //   Get.rawSnackbar(
    //       message: "Bad Connectivity",
    //       snackPosition: SnackPosition.BOTTOM,
    //       margin: EdgeInsets.zero,
    //       snackStyle: SnackStyle.GROUNDED,
    //       backgroundColor: Colors.red);
    // }
    catch (e) {
      // print("4");
      // print(e);
      // Get.rawSnackbar(
      //     message: " $e Error Occured",
      //     snackPosition: SnackPosition.BOTTOM,
      //     margin: EdgeInsets.zero,
      //     snackStyle: SnackStyle.GROUNDED,
      //     backgroundColor: Colors.red);
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

      log(response.body);
      if (response.statusCode == 200) {
        // return ClaimSubmitted.fromJson(jsonDecode(response.body));
        Map data = jsonDecode(response.body);

        if (data != null && data["isSuccess"]) {
          loading.value = false;

          claimDetail.value = data["data"]; //["claimData"];

          //claimDetailsObject.value = ClaimDetailsData.fromJson(data["data"]["claimData"]);
        }
      } else if (response.statusCode == 401) {
        final details = jsonDecode(response.body);
        //getErrorToaster(details["message"]);
        Get.off(() => LoginScreen());
      } else if (response.statusCode == 400) {
        final details = jsonDecode(response.body);
        //getErrorToaster(details["message"]);
      } else if (response.statusCode == 405) {
        final details = jsonDecode(response.body);
        //getErrorToaster(details["message"]);
      }
    }
    // on SocketException {
    //   Get.rawSnackbar(
    //       message: "Bad Connectivity",
    //       snackPosition: SnackPosition.BOTTOM,
    //       margin: EdgeInsets.zero,
    //       snackStyle: SnackStyle.GROUNDED,
    //       backgroundColor: Colors.red);
    // }
    catch (e) {
      // print("3");
      // print(e);
      // Get.rawSnackbar(
      //     message: " $e Error Occured",
      //     snackPosition: SnackPosition.BOTTOM,
      //     margin: EdgeInsets.zero,
      //     snackStyle: SnackStyle.GROUNDED,
      //     backgroundColor: Colors.red);
    } finally {
      //btnController.value.stop();
    }
  }


  /// send to verifier
  sendToVerifier() async {
    try {
      var Url="$claimDetails${Get.arguments[1].id.toString()}/forward-to-verifier";
      print("link url"+Url);
      var response = await http.post(
        Uri.parse(Url),
        headers: {
          "Content-Type": "application/json",
          "X-Xsrf-Token": box.read("authToken"),
        },
      );


      if (response.statusCode == 200) {
      } else if (response.statusCode == 401) {
        final details = jsonDecode(response.body);
        //getErrorToaster(details["message"]);
        Get.off(() => LoginScreen());
      } else if (response.statusCode == 400) {
        final details = jsonDecode(response.body);
        //getErrorToaster(details["message"]);
      } else if (response.statusCode == 405) {
        final details = jsonDecode(response.body);
        //getErrorToaster(details["message"]);
      }
    }
    // on SocketException {
    //   Get.rawSnackbar(
    //       message: "Bad Connectivity",
    //       snackPosition: SnackPosition.BOTTOM,
    //       margin: EdgeInsets.zero,
    //       snackStyle: SnackStyle.GROUNDED,
    //       backgroundColor: Colors.red);
    // }
    catch (e) {
      // print("3");
      // print(e);
      // Get.rawSnackbar(
      //     message: " $e Error Occured",
      //     snackPosition: SnackPosition.BOTTOM,
      //     margin: EdgeInsets.zero,
      //     snackStyle: SnackStyle.GROUNDED,
      //     backgroundColor: Colors.red);
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

  List<File>? files1;
  List<http.MultipartFile> signForm = [];

  Future<List<File>?> uploadFile1() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'jpg', 'jpeg']);
    if (result != null) {
      //List<File> file = File(result.files.single.path!);
      files1 = result.paths
          .map((path) => File(path!))
          .toList(); //result.paths.map((path) => File(result.files.path.toString())).toList();
      // path.value = basename(file.path);
      //path.value = file.path;
    } else {
      // User canceled the picker
    }
    // return path.value;
    return files1;
  }

  /// death certificate
  List<File>? deathCertificate;

  Future<List<File>?> uploadCertificate() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'jpg', 'jpeg']);
    if (result != null) {
      deathCertificate = result.paths.map((path) => File(path!)).toList();
    } else {
      // User canceled the picker
    }
    // return path.value;
    return deathCertificate;
  }

  List<File>? borrowerProof;

  Future<List<File>?> uploadBorrowerProof() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'jpg', 'jpeg']);
    if (result != null) {
      borrowerProof = result.paths.map((path) => File(path!)).toList();
    } else {
      // User canceled the picker
    }
    // return path.value;
    return borrowerProof;
  }

  List<File>? nomineeProof;

  Future<List<File>?> uploadNomineeProof() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'jpg', 'jpeg']);
    if (result != null) {
      nomineeProof = result.paths.map((path) => File(path!)).toList();
    } else {
      // User canceled the picker
    }
    // return path.value;
    return nomineeProof;
  }

  List<File>? bankACProof;

  Future<List<File>?> uploadBankProof() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'jpg', 'jpeg']);
    if (result != null) {
      bankACProof = result.paths.map((path) => File(path!)).toList();
    } else {
      // User canceled the picker
    }
    // return path.value;
    return bankACProof;
  }

  List<File>? additionalIDProof;

  Future<List<File>?> uploadAdditionalIDProof() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'jpg', 'jpeg']);
    if (result != null) {
      additionalIDProof = result.paths.map((path) => File(path!)).toList();
    } else {
      // User canceled the picker
    }
    // return path.value;
    return additionalIDProof;
  }

  List<File>? imageFileList = [];

  Future<void> selectDocuments() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc']);
    if (result != null) {
      List<File> files = result.paths.map((p) => File(p!)).toList();
      imageFileList = result.paths.map((p) => File(p!)).toList();
      print("file length ${files.length}   ${imageFileList!.length}");
      List<String> title = files.map((e) => e.path.split('/').last).toList();
      //fileTitle!.value = title;
      //documentList.value = files;
      //log(fileTitle.toString(), name: "document seletced");
    }
  }



  /// discrepancy upload document
  List<File>? discrepancyDocument;

  Future<List<File>?> uploadDiscrepancyDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'jpg', 'jpeg']);
    if (result != null) {
      discrepancyDocument = result.paths.map((path) => File(path!)).toList();
    } else {
      // User canceled the picker
    }
    // return path.value;
    return discrepancyDocument;
  }




  Future<String> imageFromCamera() async {
    ImagePicker picker = ImagePicker();
    XFile? imageXFile = await picker.pickImage(source: ImageSource.camera);
    log("$imageXFile");
    path.value = imageXFile!.path;

    return path.value;
  }

  Future<http.StreamedResponse?> uploadFormData() async {
    loadUpload.value = true;
    // var postUri = Uri.parse("$formUploadNew");
    var postUri = Uri.parse(
        "$formUpload${Get.arguments[1].id.toString()}/uploadDocument");
    log(postUri.toString());
    var request = http.MultipartRequest("Put", postUri);
    Map<String, String> headers = {
      // "Content-Type": "multipart/form-data",
      "X-Xsrf-Token": box.read("authToken"),
    };
    request.headers.addAll(headers);

    ///code for adding keys

    request.fields["id"] = Get.arguments[1].id.toString(); //compulsory
    log("Key 1: ${Get.arguments[1].id.toString()}");

    request.fields["isMinor"] = nominee.value == "Minor" ? "true" : "false";
    log("Key 1234: ${nominee.value == "Minor" ? "true" : "false"}");
    request.fields["causeOfDeath"] =
        causeofDeathReturn(causeofDeath.value) == "" ||
                causeofDeathReturn(causeofDeath.value) == null ||
                causeofDeathReturn(causeofDeath.value).isEmpty
            ? causeofDeath.value
            : causeofDeathReturn(causeofDeath.value); //compulsory
    log("Key 1234: ${causeofDeathReturn(causeofDeath.value)}");
    log("Key 1234: ${causeofDeath.value}");
    //request.fields["borowerProof"] = "BORROWER_ID_PROOF";

    if (agentRemarkDropDownValue.value.isNotEmpty) {
      request.fields["agentRemark"] = agentRemarkDropDownValue.value.toString();

      /// Agent Remarks
    }

    /// code for adding file image
    if(agentRemarkDropDownValue
        .value  == null || agentRemarkDropDownValue
        .value  == "null" || agentRemarkDropDownValue
        .value  == '' ) {
      if (nominee.value == "Minor") {
        log("true ${nominee.value == "Minor"}");
        if (minorProofPath.value.isNotEmpty) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'OTHER',
              minorProofPath.value,
              contentType: MediaType('file', 'pdf'),
            ),
          );
        }
        if (RelationProof.value.isNotEmpty) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'RELATIONSHIP_PROOF',
              RelationProof.value,
              contentType: MediaType('file', 'pdf'),
            ),
          );
        }
        if (GUARDIAN_ID_PROOF.value.isNotEmpty) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'GUARDIAN_ID_PROOF',
              GUARDIAN_ID_PROOF.value,
              contentType: MediaType('file', 'pdf'),
            ),
          );
        }
        if (GUARDIAN_ADD_PROOF.value.isNotEmpty) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'GUARDIAN_ADD_PROOF',
              GUARDIAN_ADD_PROOF.value,
              contentType: MediaType('file', 'pdf'),
            ),
          );
        }
      }
      if (files1 != null) {
        // request.files.add(
        //   await http.MultipartFile.fromPath(
        //     'SIGNED_FORM',
        //     signForm.toList().toString(),
        //     contentType: MediaType('file', 'pdf'),
        //   ),
        // );"SIGNED_FORM :  : ${i}
        List<http.MultipartFile> newList = [];
        for (int i = 0; i < files1!.length; i++) {
          File imageFile = File(files1![i].path);
          var stream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
          var length = await imageFile.length();
          var multipartFile = http.MultipartFile(
              "SIGNED_FORM :  : ${i}", stream, length,
              filename: imageFile.path
                  .split('/')
                  .last);
          newList.add(multipartFile);
        }

        request.files.addAll(newList);
      }

      if (deathCertificate != null) {
        List<http.MultipartFile> newList = [];
        for (int i = 0; i < deathCertificate!.length; i++) {
          File imageFile = File(deathCertificate![i].path);
          var stream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
          var length = await imageFile.length();
          var multipartFile = http.MultipartFile(
              "DEATH_CERTIFICATE :  : ${i}", stream, length,
              filename: imageFile.path
                  .split('/')
                  .last);
          newList.add(multipartFile);
        }
        request.files.addAll(newList);
      }

      if (borrowerProof != null) {
        List<http.MultipartFile> newList = [];
        for (int i = 0; i < borrowerProof!.length; i++) {
          File imageFile = File(borrowerProof![i].path);
          var stream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
          var length = await imageFile.length();
          var multipartFile = http.MultipartFile(
              "BORROWER_KYC_PROOF : ${borroweridProof.value} : ${i}",
              stream,
              length,
              filename: imageFile.path
                  .split('/')
                  .last);
          newList.add(multipartFile);
        }
        request.files.addAll(newList);
      }

      if (filledPath.value.isEmpty) {}
      if (deathCertificatePath.value.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'DEATH_CERTIFICATE',
            deathCertificatePath.value,
            contentType: MediaType('file', 'pdf'),
          ),
        );
      }
      if (borrowerIdDocPath.value.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'BORROWER_KYC_PROOF :${borroweridProof.value}',
            borrowerIdDocPath.value,
            contentType: MediaType('file', 'pdf'),
          ),
        );
      }
    }

    if(agentRemarkDropDownValue.value  != null){
      request.fields["agentRemark"] = agentRemarkDropDownValue.value.toString();

    }


    var response = await request.send();
    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      getStepperFormData();
      loadUpload.value = false;

      Fluttertoast.showToast(
          msg: "Form Submitted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      log("Success");
    } else {
      loadUpload.value = false;

      log("errorCode ${responsed.body}");
      Get.rawSnackbar(
          message: "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED,
          backgroundColor: Colors.red);
    }
  }


  // uploadFormData1() async {
  //   loadUpload.value = true;
  //   var postUri = Uri.parse("$formUpload/22/uploadDocument");
  //   // var postUri = Uri.parse(
  //   //     "https://b700-223-190-95-222.in.ngrok.io/api/v1/agent/claim/${Get.arguments[1].id.toString()}/uploadDocument");
  //   log(postUri.toString());
  //   var request = http.MultipartRequest("Put", postUri);
  //   Map<String, String> headers = {
  //     // "Content-Type": "multipart/form-data",
  //     "X-Xsrf-Token": box.read("authToken"),
  //   };
  //   request.headers.addAll(headers);
  //
  //   ///code for adding keys
  //
  //   request.fields["id"] = Get.arguments[1].id.toString();
  //   request.fields["nomineeProof"] = documentReturn(nomineeIdProofDoc.value);
  //   log("Key 2 Nomiee id ${documentReturn(nomineeIdProofDoc.value)}");
  //
  //  // request.fields["bankerProof"] = documentReturn(bankProofDoc.value);
  //   log("Key 3 bank id ${documentReturn(bankProofDoc.value)}");
  //
  //   request.fields["isMinorDoc"] = jsonEncode(minor);
  //
  //   /// code for adding file image
  //
  //   if (nomineeAddressDocPath.value.isNotEmpty) {
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'nomineeMultiparts',
  //         borrowerAddressDocPath.value,
  //         contentType: MediaType('file', 'pdf'),
  //       ),
  //     );
  //   }
  //
  //   if (borrowerAddressDocPath.value.isNotEmpty) {
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'bankerPROOFMultipart',
  //         borrowerAddressDocPath.value,
  //         contentType: MediaType('file', 'pdf'),
  //       ),
  //     );
  //   }
  //
  //
  //
  //   log("Request $request");
  //   var response = await request.send();
  //   var responsed = await http.Response.fromStream(response);
  //   log("${responsed.statusCode}");
  //
  //   //final responseData = json.decode(responsed.body);
  //   // log("$responseData");
  //   if (response.statusCode == 200) {
  //     loadUpload.value = false;
  //     Get.rawSnackbar(
  //         message: "Form Submitted Successfully",
  //         snackPosition: SnackPosition.BOTTOM,
  //         margin: EdgeInsets.zero,
  //         snackStyle: SnackStyle.GROUNDED,
  //         backgroundColor: Colors.green);
  //
  //     Get.offAll(() => Details(
  //           title: 'Allocated',
  //         ));
  //     log("Success");
  //   } else {
  //     loadUpload.value = false;
  //     log("errorCode ${response.statusCode}");
  //     Get.rawSnackbar(
  //         message: "Something went wrong",
  //         snackPosition: SnackPosition.BOTTOM,
  //         margin: EdgeInsets.zero,
  //         snackStyle: SnackStyle.GROUNDED,
  //         backgroundColor: Colors.red);
  //   }
  // }

  uploadFormData2() async {
    getStepperFormData();
    loadUpload.value = true;
    // var postUri = Uri.parse("$formUploadNew");
    var postUri = Uri.parse(
        "$formUpload${Get.arguments[1].id.toString()}/uploadDocument");
    var request = http.MultipartRequest("Put", postUri);
    Map<String, String> headers = {
      // "Content-Type": "multipart/form-data",
      "X-Xsrf-Token": box.read("authToken"),
    };
    request.headers.addAll(headers);

    ///code for adding keys

    request.fields["id"] = Get.arguments[1].id.toString(); //compulsory
    log("Key 1: ${Get.arguments[1].id.toString()}");

    if (nomineeIdDocPath.value.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'NOMINEE_KYC_PROOF : ${nomineeIdProof.value}',
          nomineeIdDocPath.value,
          contentType: MediaType('file', 'pdf'),
        ),
      );
    }

    if (nomineeProof != null) {
      List<http.MultipartFile> newList = [];
      for (int i = 0; i < nomineeProof!.length; i++) {
        File imageFile = File(nomineeProof![i].path);
        var stream =
            new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile(
            "NOMINEE_KYC_PROOF : ${nomineeIdProof.value} : ${i}",
            stream,
            length,
            filename: imageFile.path.split('/').last);
        newList.add(multipartFile);
      }

      request.files.addAll(newList);
    }

    if (bankACProof != null) {
      List<http.MultipartFile> newList = [];
      for (int i = 0; i < bankACProof!.length; i++) {
        File imageFile = File(bankACProof![i].path);
        var stream =
            new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile(
            "BANK_ACCOUNT_PROOF : ${bankProof.value} : ${i}", stream, length,
            filename: imageFile.path.split('/').last);
        newList.add(multipartFile);
      }

      request.files.addAll(newList);
    }

    if (bankAccountDocPath.value.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'BANK_ACCOUNT_PROOF : ${bankProof.value}',
          bankAccountDocPath.value,
          contentType: MediaType('file', 'pdf'),
        ),
      );
    }

    if (additionalDocpath.value.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "ADDITIONAL:${additionalProof.value}",
          additionalDocpath.value,
          contentType: MediaType('file', 'pdf'),
        ),
      );
    }

    log("message${additionalList.isNotEmpty}");

    log("Request $request");
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    log("${responsed.statusCode}");

    if (response.statusCode == 200) {
      loadUpload.value = false;

      Fluttertoast.showToast(
          msg: "Form Submitted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
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

  uploadFormData3() async {
    getStepperFormData();
    loadUpload.value = true;
    // var postUri = Uri.parse("$formUploadNew");
    var postUri = Uri.parse(
        "$formUpload${Get.arguments[1].id.toString()}/uploadDocument");
    var request = http.MultipartRequest("Put", postUri);
    Map<String, String> headers = {
      // "Content-Type": "multipart/form-data",
      "X-Xsrf-Token": box.read("authToken"),
    };
    request.headers.addAll(headers);

    ///code for adding keys

    request.fields["id"] = Get.arguments[1].id.toString(); //compulsory
    log("Key 1: ${Get.arguments[1].id.toString()}");

    if (additionalDocpath.value.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "ADDITIONAL:${additionalProof.value}",
          additionalDocpath.value,
          contentType: MediaType('file', 'pdf'),
        ),
      );
    }

    log("message${additionalList.isNotEmpty}");

    log("Request $request");
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    log("${responsed.statusCode}");

    //final responseData = json.decode(responsed.body);
    // log("$responseData");
    if (response.statusCode == 200) {
      loadUpload.value = false;

      Fluttertoast.showToast(
          msg: "Form Submitted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
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

  String causeofDeathReturn(text) {
    RxString temp = "".obs;
    if (text == "Accident") {
      temp.value = "ACCIDENT";
    } else if (text == "Natural Death") {
      temp.value = "NATURAL_DEATH";
    } else if (text == "Suicide") {
      temp.value = "SUICIDE";
    } else if (text == "Illness &  Medical Reason") {
      temp.value = "ILLNESS_MEDICAL_REASON";
    } else if (text == "Death due to Natural Calamity") {
      temp.value = "DUE_TO_NATURAL_CALAMITY";
    }

    return temp.value;
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
      print("file part " + path.value.toString());
    } else {
      // User canceled the picker
    }
    print("file part " + path.value.toString());
    return path.value;
  }

  uploadDiscrepancyData({id, docType}) async {
    loadUpload.value = true;
    var postUri =
        Uri.parse("$formUpload$id/discrepancy-document-upload/$docType");
    log(postUri.toString());
    var request = http.MultipartRequest("Post", postUri);
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "X-Xsrf-Token": box.read("authToken"),
    };
    request.headers.addAll(headers);

    /// code for adding file image
    if (additionalDocpath.value.isNotEmpty) {
      print("1" + additionalDocpath.value);
      request.files.add(await http.MultipartFile.fromPath(
        'multipartFile',
        additionalDocpath.value,
      ));
    }

    if (discrepancyDocument != null) {



      List<http.MultipartFile> newList = [];
      for (int i = 0; i < discrepancyDocument!.length; i++) {
        File imageFile = File(discrepancyDocument![i].path);
        var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
        var length = await imageFile.length();
        print("error line in length "+ discrepancyDocument.toString());
        var multipartFile = http.MultipartFile(
            "multipartFile", stream, length,
            filename: imageFile.path.split('/').last);
        newList.add(multipartFile);
      }

      request.files.addAll(newList);



    }





    var response = await request.send();
    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      //moveToVerify(id: id);
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
    var postUri = Uri.parse("$formUpload$id/forward-to-verifier");
    Map<String, dynamic> data = {
      "id": id,
    };
    log(postUri.toString());
    var response = await http.post(
      postUri,
      headers: {
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

  String dropDownSearchChecker(value) {
    // log("This is called with ${value.toString()}");
    RxString tempValue = "".obs;

    if (value == "PunchIn Ref. ID") {
      tempValue.value = "CLAIM_DATA_ID";
    } else if (value == "Loan Account Number") {
      tempValue.value = "LOAN_ACCOUNT_NUMBER";
    } else if (value == "Name") {
      tempValue.value = "NAME";
    }
    return tempValue.value;
  }




  getClaimTracking({searchKey}) async {
    try {
        var Url = claimDetails + "$searchKey/history";
        log(Url.toString());
        var response = await http.get(
          Uri.parse(Url),
          headers: {
            "Content-Type": "application/json",
            "X-Xsrf-Token": box.read("authToken"),
          },
        );
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          log(response.body);
          return TrackingModel.fromJson(jsonDecode(response.body));
        }
        if (response.statusCode == 404) {
          return TrackingModel.fromJson(jsonDecode(response.body));
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



    }
    // on SocketException {
    //   Get.rawSnackbar(
    //       message: "Bad Connectivity",
    //       snackPosition: SnackPosition.BOTTOM,
    //       margin: EdgeInsets.zero,
    //       snackStyle: SnackStyle.GROUNDED,
    //       backgroundColor: Colors.red);
    // }
    catch (e) {
      // print("12345" + e.toString());
      // print(e);
      // Get.rawSnackbar(
      //     message: " $e Error Occured",
      //     snackPosition: SnackPosition.BOTTOM,
      //     margin: EdgeInsets.zero,
      //     snackStyle: SnackStyle.GROUNDED,
      //     backgroundColor: Colors.red);
    } finally {
      //btnController.value.stop();
    }
  }


}
