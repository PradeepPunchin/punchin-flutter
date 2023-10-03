import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class ClaimFormController extends GetxController {
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
