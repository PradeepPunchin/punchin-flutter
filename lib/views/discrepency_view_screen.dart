import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constant/const_color.dart';
import '../constant/const_text.dart';
import '../controller/discrepency_controller.dart';

class DiscrepencyScreen extends StatelessWidget {
  DiscrepencyScreen({Key? key}) : super(key: key);
  final controller = Get.put(DiscrepencyController());
  List options = [
    {"name": "Nominee Signed Claim Form ", "status": true},
    {"name": "Death Certificate ", "status": false},
    {"name": "Borrower ID Proof", "status": true},
    {"name": "Borrower Add proof", "status": true},
    {"name": "Nominee Id Proof ", "status": true},
    {"name": "Nominee Add proof ", "status": true},
    {"name": "Nominee Bank A/c Proof ", "status": true},
    {"name": "FIR / Postmortem report", "status": true},
    {"name": "Affidavit (Name mismatch etc)", "status": true},
    {"name": "Discrepancy / AR / FR resolution", "status": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Discrepancy/New Requirements",
            style: kBlack15Black.copyWith(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white10,
              radius: 48.0,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: kLightGrey,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Icon(
                      Icons.notifications_none,
                      color: Colors.grey,
                    ),
                  )),
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Document Uploaded",
                    style: kBlack15Black,
                  ),
                  Container(
                    height: Get.height * 0.55,
                    width: Get.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 3.0, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (context, int index) {
                        return Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: kGrey)),
                                  child: Text(
                                    "${options[index]["name"]}",
                                    style: kBlack15Black,
                                  ),
                                  height: 50,
                                  alignment: Alignment.center,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: kGrey)),
                                  child: !options[index]["status"]
                                      ? Icon(Icons.cancel, color: kGrey)
                                      : Icon(Icons.check_circle,
                                          color: klightBlue),
                                  height: 50,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      padding: EdgeInsets.only(bottom: 0),
                    ),
                  ),
                  Text(
                    "Discrepancy Remark",
                    style: kBlack15Black,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: kLightGrey,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: kGrey,
                        )),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Document mismatch please upload again"
                          "the following documents.",
                          style: kBlack15Black.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          " 1. Dealth Certificate",
                          style: kBlack15Black.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Colors.black),
                        ),
                        Text(
                          " 2. Police Investigation Report",
                          style: kBlack15Black.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Colors.black),
                        ),
                        Text(
                          " 3.Income Tax Return (Additional Doc)",
                          style: kBlack15Black.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Upload Required Documents",
                    style: kBlack15Black,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(1.0),
                        border: Border.all(color: kGrey)),
                    child: Obx(() => DropdownButton<String>(
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: controller.document.value.isNotEmpty
                                ? Text(
                                    controller.document.value,
                                    style: kBlack15Black
                                        .copyWith(fontSize: 14.0),
                                  )
                                : Text(
                                    "Select Additional Document Type",
                                    style: kBlack15Black
                                        .copyWith(fontSize: 14.0),
                                  ),
                          ),
                          underline: const SizedBox(),
                          items: <String>[
                            'Aadhar Card',
                            'Passport',
                            'Voter card',
                            'Driving License',
                            'Bank Passbook',
                            'Any other Govt ID Card',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.document.value = value!;
                          },
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40.0.h,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: kGrey,
                        )),
                    child: Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(() => Text(
                                  "${controller.bankProof.value}",
                                  style: kBlack15Black.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0),
                                )),
                          ),
                        ),
                        Spacer(),
                        MaterialButton(
                          elevation: 1.0,
                          onPressed: () async {
                            var file = await controller.uploadFile();
                            print(file);
                            controller.bankProof.value = file;
                          },
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: kGrey),
                              borderRadius: BorderRadius.circular(5.0)),
                          color: Colors.white,
                          child: Text("Upload",
                              style: kBlack15Black.copyWith(
                                  fontSize: 15.0, fontWeight: FontWeight.w400)),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    color: kdarkBlue,
                    height: 45.0,
                    minWidth: Get.width,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Text(
                      "Submit",
                      style: kBlack15Black
                          .copyWith(color: Colors.white, fontSize: 15.0),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
