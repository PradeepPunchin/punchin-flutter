import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/controller/claim_controller/claim_controller.dart';
import 'package:punchin/views/claim_form_view/preview_screen.dart';
import 'package:path/path.dart';

import 'details.dart';

class ClaimDiscrepancy extends StatefulWidget {
  const ClaimDiscrepancy({Key? key}) : super(key: key);

  @override
  State<ClaimDiscrepancy> createState() => _ClaimDiscrepancyState();
}

class _ClaimDiscrepancyState extends State<ClaimDiscrepancy> {
  ClaimController controller = Get.put(ClaimController());
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
  var ArgData= Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // app bar
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.off(() => Details(title: ArgData ,));
                            },
                            child: Icon(Icons.arrow_back_ios_new,
                                color: Colors.black)),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Discrepancy/New Requirements", style: kBody16black600),
                      ],
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.white10,
                      radius: 17.0,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2, color: Colors.black12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.notifications_outlined,
                              color: Colors.black,
                            ),
                          )),
                    ),
                  ],
                ),

             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  border: Border.all(width: .5,color: kBorderColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Document Uploaded",
                                style: CustomFonts.kBlack15Black,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                height: Get.height * 0.6,
                                width: Get.width,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 3.0, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
                                child: ListView.builder(
                                    itemCount: options.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, int index) {
                                      return Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: kGrey)),
                                                child: Text(
                                                  "${options[index]["name"]}",
                                                  style: CustomFonts
                                                      .kBlack15Black,
                                                ),
                                                height: 50,
                                                alignment:
                                                Alignment.center,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: kGrey)),
                                                child: !options[index]
                                                ["status"]
                                                    ? Icon(Icons.cancel,
                                                    color: Colors.red)
                                                    : Icon(
                                                    Icons
                                                        .check_circle,
                                                    color: Colors
                                                        .blue),
                                                height: 50,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),

                        Text(
                          "Discrepancy Remark",
                          style: CustomFonts.kBlack15Black,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),

                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: kFilledTextColor,
                            border: Border.all(color: kTextFieldBorder)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Document mismatch please upload again the following documents.",
                                style: CustomFonts.kBlack15Black,
                              ),



                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                "1.Death Certificate",
                                style: CustomFonts.kBlack15Black,
                              ),

                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                "2.Police Investigation Report",
                                style: CustomFonts.kBlack15Black,
                              ),


                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                "3.Income Tax Return (Additional Doc)",
                                style: CustomFonts.kBlack15Black,
                              ),

                              const SizedBox(
                                height: 8.0,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),

                        Text(
                          "Upload Documents",
                          style: CustomFonts.kBlack15Black,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),

                        Container(
                          decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(1.0),

                              border: Border.all(color: kBorderColor)),
                          child: Obx(() => DropdownButton<String>(
                            isExpanded: true,
                            hint: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: controller
                                  .additionalProof.value.isNotEmpty
                                  ? Text(
                                controller.additionalProof.value,
                                style: CustomFonts.kBlack15Black
                                    .copyWith(fontSize: 14.0),
                              )
                                  : Text(
                                "Select Document Type",
                                style: CustomFonts.kBlack15Black
                                    .copyWith(fontSize: 14.0),
                              ),
                            ),
                            underline: const SizedBox(),
                            items: <String>[
                              'Income Tax Return',
                              'Medical Records',
                              'Legal Heir Certificate',
                              'Police Investigation Report',
                              'Other',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.additionalProof.value = value!;
                            },
                          )),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 40.0,
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
                                    controller.additionalProofDoc.value,
                                    style: CustomFonts.kBlack15Black
                                        .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0),
                                  )),
                                ),
                              ),
                              const Spacer(),
                              MaterialButton(
                                elevation: 1.0,
                                onPressed: () async {
                                  Get.defaultDialog(
                                      title: "Upload",
                                      titleStyle: CustomFonts.kBlack15Black
                                          .copyWith(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Divider(),
                                          GestureDetector(
                                            onTap: () async {
                                              var file = await controller
                                                  .imageFromCamera();

                                              controller.additionalProofDoc
                                                  .value = basename(file);
                                              controller.additionalDocpath
                                                  .value = file;
                                              Get.back(closeOverlays: true);
                                            },
                                            child: Text(
                                              "Take Photo ...",
                                              style: CustomFonts
                                                  .kBlack15Black
                                                  .copyWith(
                                                  color: kdarkBlue,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  fontSize: 16.0),
                                            ),
                                          ),
                                          const Divider(),
                                          GestureDetector(
                                            behavior:
                                            HitTestBehavior.opaque,
                                            onTap: () async {
                                              var file = await controller
                                                  .uploadFile();

                                              controller.additionalProofDoc
                                                  .value = basename(file);
                                              controller.additionalDocpath
                                                  .value = file;
                                              Get.back(closeOverlays: true);
                                            },
                                            child: Text(
                                              "Choose Files from Custom options",
                                              style: CustomFonts
                                                  .kBlack15Black
                                                  .copyWith(
                                                  color: kdarkBlue,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  fontSize: 16.0),
                                            ),
                                          ),
                                          const Divider(),
                                        ],
                                      ),
                                      cancel: GestureDetector(
                                        onTap: () {
                                          Get.back(closeOverlays: true);
                                        },
                                        behavior: HitTestBehavior.opaque,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Cancel",
                                            style: CustomFonts.kBlack15Black
                                                .copyWith(
                                                color: Colors.red,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      onCancel: () => Get.back());
                                },
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: kGrey),
                                    borderRadius:
                                    BorderRadius.circular(5.0)),
                                color: Colors.white,
                                child: Text("Upload",
                                    style: CustomFonts.kBlack15Black
                                        .copyWith(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400)),
                              ),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),

                        Obx(() => controller
                            .additionalDocpath.value.isNotEmpty
                            ? Row(
                          children: [
                            GestureDetector(
                              child: Text(
                                "Preview",
                                style: CustomFonts.kBlack15Black
                                    .copyWith(
                                    fontSize: 14.0,
                                    color: kdarkBlue,
                                    fontWeight: FontWeight.w700),
                              ),
                              onTap: () => Get.to(() => PreviewScreen(
                                filePath: controller
                                    .additionalDocpath.value,
                              )),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                controller.additionalProofDoc.value =
                                "";
                                controller.additionalDocpath.value =
                                "";
                              },
                              child: const Icon(
                                Icons.delete,
                                color: klightBlue,
                                size: 20,
                              ),
                            )
                          ],
                        )
                            : SizedBox()),

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 22),
                          child: MaterialButton(
                            height: 53,
                            minWidth: Get.width,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            color: kdarkBlue,
                            onPressed: () {


                            },
                            child: Text(
                              "Submit",
                              style: CustomFonts.getMultipleStyle(
                                  15.0, Colors.white, FontWeight.w400),
                            ),
                          ),
                        ),

                      ]),
                ),
              ),
            ),





          ],
            ),
          ),
        ),
      ),
    );
  }
}
