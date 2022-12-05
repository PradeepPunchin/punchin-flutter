
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';


class ImageController extends GetxController {


  /// variable declared
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
      imageText.text= "${localImage.toString()}";
      isImage.value=false;
      return filepath;
    }
    else{
     //  part
    }


  }

  Future pickUserImageCamera() async {
    var image = await imagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 360, maxWidth: 360);
    if (image != null) {
      File imageFile = File(image.path);
      filepath=image.path;
      localImage = imageFile ;
      List<int> imageBytes = imageFile.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      imagebase64 = base64Image;
      imageText.text= "${localImage.toString()}";
      isImage.value=false;
      return imagebase64;
    }
    else{
      //else part
    }


  }

}