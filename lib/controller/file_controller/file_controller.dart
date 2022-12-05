import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:punchin/constant/api_url.dart';
import 'package:punchin/widget/custom_snackBar.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class FileController extends GetxController {


  // variable
  List ImageType = [".jpg", ".jpeg", "doc",".docx",".pdf"];
  var box= GetStorage();
  /// 404 invalid claim id
  /// 200 success
  Future UpdateFile(image) async {
    try {
      print(image.toString());
      File _file = File(image);
      var _extenion = extension(_file.path);

      if (ImageType.contains(_extenion)) {
        //Map<String, dynamic> data = {"image": image};

        print(multipartApi.toString());
        var postUri = Uri.parse("${multipartApi}");
        var request = http.MultipartRequest("POST", postUri);
        Map<String, String> headers = {
          "Content-Type": "application/json",
          "X-Xsrf-Token": box.read("authToken"),
          //HttpHeaders.cookieHeader: GetStorage().read("header"),
        };
        request.headers.addAll(headers);
        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            image,
            contentType: MediaType('file', 'jpg'),
          ),
        );

        var response = await request.send();
        var responsed = await http.Response.fromStream(response);
        final responseData = json.decode(responsed.body);

        print(responseData);
        print(responsed.body);
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