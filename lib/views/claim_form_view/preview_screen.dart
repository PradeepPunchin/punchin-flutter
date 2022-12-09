import 'package:flutter/material.dart';
import 'package:flutter_filereader/flutter_filereader.dart';
import 'package:get/get.dart';

import '../../constant/const_text.dart';

class PreviewScreen extends StatefulWidget {
  String filePath;

  PreviewScreen({Key? key, required this.filePath}) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState(filePath);
}

class _PreviewScreenState extends State<PreviewScreen> {
  String filePath;

  _PreviewScreenState(this.filePath);

  @override
  Widget build(BuildContext context) {
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
              color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w400),
        ),
      ),
      body: FileReaderView(
        filePath: filePath,
      ),
    );
  }
}
