import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class DiscrepencyController extends GetxController {
  RxString document = "".obs;
  RxString bankProof = "".obs;
  RxString path = "".obs;

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
