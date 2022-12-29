
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import '../../constant/const_text.dart';

class PreviewScreen extends StatefulWidget {
  PreviewScreen({Key? key, required this.filePath}) : super(key: key);
  final  filePath;



  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {

  var filextension;
  String getFileExtension(String fileName) {
    print("." + fileName.split('.').last);
    filextension =fileName.split('.').last;
    print("file type"+filextension);
    print(fileName);
    final file = File('${fileName}');

    return "." + fileName.split('.').last;
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    getFileExtension(widget.filePath.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.blue,
            size: 20,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Preview your uploaded file",
          style: CustomFonts.kBlack15Black.copyWith(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
        ),
      ),
      body: filextension == "jpg" || filextension == "jpeg"|| filextension == "png"?//ImageByteFormat.png ?
      Image.file(File(widget.filePath),
      ):
      Container(
        width: 400,//Get.width,
          height: Get.height,

          child: PdfView(path: "${widget.filePath.toString()}"),
      ),
    );
  }
}


class PreviewScreen1 extends StatefulWidget {
  PreviewScreen1({Key? key, required this.filePath}) : super(key: key);
  final  filePath;



  @override
  State<PreviewScreen1> createState() => _PreviewScreen1State();
}

class _PreviewScreen1State extends State<PreviewScreen1> {

  var filextension;
  String getFileExtension(String fileName) {
    print("." + fileName.split('.').last);
    filextension =fileName.split('.').last;
    print("file type"+filextension);
    print(fileName);
    final file = File('${fileName}');

    return "." + fileName.split('.').last;
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    getFileExtension(widget.filePath.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.blue,
            size: 20,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Preview your uploaded file",
          style: CustomFonts.kBlack15Black.copyWith(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
        ),
      ),
      body: filextension == "jpg" || filextension == "jpeg"|| filextension == "png"?
      Image.file(File(widget.filePath.toString()),
      ):
      Container(
        width: 400,//Get.width,
        height: Get.height,

        child: PdfView(path: widget.filePath.toString()),
      ),
    );
  }
}