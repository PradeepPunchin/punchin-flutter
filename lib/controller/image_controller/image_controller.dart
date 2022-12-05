
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

import 'package:punchin/constant/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:punchin/widget/custom_snackBar.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class ImageController extends GetxController {


  /// variable declared
  List ImageType = [".jpg", ".jpeg", "doc",".docx",".pdf"];
  var box= GetStorage();
  ImagePicker imagePicker = ImagePicker();
  File? file;
  late final imageUrl;
  late Uint8List bytes;
  String? imagebase64;
  var localImage;
  var filepath;
  final imageText=TextEditingController() ;
  RxBool isImage= false.obs;

  /// functioin open camera
  Future pickImageCamera() async {
    var image = await imagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 360, maxWidth: 360);
    if (image != null) {
      File imageFile = File(image.path);
      filepath=image.path;
      localImage = imageFile ;
      List<int> imageBytes = imageFile.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      imagebase64 = base64Image;
      print(imagebase64.toString());
      imageText.text= "${localImage.toString()}";
      isImage.value=false;
      print("filepath :" + filepath.toString());
      return imagebase64;
    }
    else{
     //  part
    }


  }





  /// 404 invalid claim id
  /// 200 success
  UpdateFile() async {
    try {
      print(imagebase64.toString());
      File _file = File(filepath);

      var _extenion = extension(_file.path);

      if (ImageType.contains(_extenion)) {
        //Map<String, dynamic> data = {"image": image};

        print(multipartApi.toString());
        // var postUri = Uri.parse("${multipartApi}");
        // var request = http.MultipartRequest("POST", postUri);
        // Map<String, String> headers = {
        //   "Content-Type": "application/json",
        //   "X-Xsrf-Token": box.read("authToken"),
        //   //HttpHeaders.cookieHeader: GetStorage().read("header"),
        // };
        // request.headers.addAll(headers);
        // request.files.add(
        //   await http.MultipartFile.fromPath(
        //     'file',
        //     filepath,
        //     //contentType: MediaType('file', 'jpg'),
        //   ),
        // );

        //var response = await request.send();
        //var responsed = await http.Response.fromStream(response);
        //final responseData = json.decode(responsed.body);

        //print(responseData);
        Map<String,dynamic> data = {
          "file" : imagebase64.toString(),
        };
        print(data);
        var response = await http.post(Uri.parse(multipartApi),
          headers: {
            "Content-Type": "application/json",
            "X-Xsrf-Token": box.read("authToken"),
          },
          body: jsonEncode(data),
        );

        print("response" + response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          // final details=jsonDecode(response.body);


          getErrorToaster("Error");
        }
        if (response.statusCode == 401) {
          // final details=jsonDecode(response.body);
          // getErrorSnackerBar("Wrong Login Credentials",details["message"]);
        }
        if (response.statusCode == 400) {
          // final details = jsonDecode(response.body);
          // getErrorSnackerBar(details["message"], "");

        }
        if (response.statusCode == 405) {
          // final details=jsonDecode(response.body);
          // getErrorSnackerBar("Method Not Allowed",details["message"]);
        }
      } else {
        getErrorToaster("File Type InValid",);
      }
    } catch (e) {
      if (e is SocketException) {
        //treat SocketException
        //   getErrorSnackerBar("Something Went Wrong", "No Internet Found");

      } else if (e is TimeoutException) {
        //treat TimeoutException
        // getErrorSnackerBar("Something Went Wrong", "Time Out");

      } else {
        // getErrorSnackerBar("Unhandled exception", "${e.toString()}");

      }
    }
  }
}