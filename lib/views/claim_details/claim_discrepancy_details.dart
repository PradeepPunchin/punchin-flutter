import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/controller/claim_controller/claim_controller.dart';
import 'package:punchin/model/claim_model/claim_discrepancy_model.dart';
import 'package:punchin/views/claim_details/details.dart';
import 'package:punchin/views/claim_form_view/preview_screen.dart';
import 'package:path/path.dart';


class ClaimDiscrepancy extends StatefulWidget {
  const ClaimDiscrepancy({Key? key}) : super(key: key);

  @override
  State<ClaimDiscrepancy> createState() => _ClaimDiscrepancyState();
}

class _ClaimDiscrepancyState extends State<ClaimDiscrepancy> {
  ClaimController controller = Get.put(ClaimController());
  var ArgData= Get.arguments;
  var dropdownName ;
  var claimStatus;
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
                              Get.off(() => Details(title: ArgData[0] ,));
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


              FutureBuilder(
                  future: controller.getClaimDiscrepeancy(id: ArgData[1]),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If we got an error

                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${snapshot.error} occurred',
                            style: const TextStyle(fontSize: 18),
                          ),
                        );

                        // if we got our data
                      } else if (snapshot.hasData) {
                        // Extracting data from snapshot object
                        print(snapshot.hasData);
                        ClaimDiscrepancyModel? claimSubmitted = snapshot.data as ClaimDiscrepancyModel; // paymentModelFromJson(snapshot.data);
                        return Padding(
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
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5.0),
                                                border: Border.all(color: kGrey)),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Application process:",
                                                  style: CustomFonts.kBlack15Black
                                                      .copyWith(
                                                      fontSize: 14.0,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "In-progress",
                                                  style: CustomFonts.kBlack15Black
                                                      .copyWith(
                                                      fontSize: 15.0,
                                                      color: klightBlue),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            //height: Get.height * 0.8,
                                            width: Get.width,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 3.0, vertical: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10.0)),
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                itemCount: controller.discrepancyData.value["claimDocuments"].length,
                                                itemBuilder: (context, int index) {
                                                  var claimDiscrepancy= controller.discrepancyData.value["claimDocuments"][index];

                                                  claimStatus= claimSubmitted.data!.claimStatus.toString();

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
                                                              "${claimDiscrepancy["agentDocType"]}",
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
                                                            height: 50,
                                                            child: claimDiscrepancy["isApproved"]==false && claimDiscrepancy["isVerified"] ==false
                                                                ? Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color: Colors
                                                                    .blue)
                                                                : claimDiscrepancy["isApproved"]==true && claimDiscrepancy["isVerified"] ==true
                                                                ? Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color: Colors
                                                                    .green)
                                                                : Icon(Icons.cancel,
                                                                color: Colors.red)
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),


                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Verifier Remark",
                                      style: CustomFonts.kBlack15Black
                                          .copyWith(
                                          fontSize: 15.0,
                                          color: klightBlue),
                                    ),
                                    Container(
                                      //height: Get.height * 0.8,
                                      width: Get.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3.0, vertical: 10),
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(7),
                                          color: kFilledTextColor,
                                          border: Border.all(color: kTextFieldBorder)
                                      ),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: controller.discrepancyData.value["claimDocuments"].length,
                                          itemBuilder: (context, int index) {
                                            var claimDiscrepancy= controller.discrepancyData.value["claimDocuments"][index];

                                            return Container(
                                              //padding: EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                 // borderRadius: BorderRadius.circular(7),
                                                  color: kWhite,
                                                 // border: Border.all(color: kTextFieldBorder)
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  claimDiscrepancy["reason"]==null || claimDiscrepancy["reason"]=="null" ||claimDiscrepancy["reason"]=="" ?SizedBox():Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "${index+1}. ${claimDiscrepancy["agentDocType"]}",
                                                        style: CustomFonts
                                                            .kBlack15Black,
                                                      ),
                                                      Text(
                                                        " reason :${claimDiscrepancy["reason"]}",
                                                        style: CustomFonts
                                                            .kBlack15Black,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
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

                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: claimSubmitted.data!.rejectedDocList!.length,
                                              itemBuilder: (context, int index) {
                                                var claimDiscrepancy= claimSubmitted.data!.rejectedDocList![index];

                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 8.0,
                                                    ),
                                                    Text(
                                                      "${index+1}.${claimDiscrepancy}",
                                                      style: CustomFonts.kBlack15Black,
                                                    ),
                                                    const SizedBox(
                                                      height: 8.0,
                                                    ),
                                                  ],
                                                );
                                              }),

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

                                    dropDown(reject: claimSubmitted.data!.rejectedDocList!),
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       color: kWhite,
                                    //       borderRadius: BorderRadius.circular(1.0),
                                    //
                                    //       border: Border.all(color: kBorderColor)),
                                    //   child: //Obx(() =>
                                    //   DropdownButton<dynamic>(
                                    //     isExpanded: true,
                                    //     hint: Padding(
                                    //       padding: const EdgeInsets.all(8.0),
                                    //       child: dropdownName!= null
                                    //           ? Text(
                                    //         "$dropdownName",
                                    //         style: CustomFonts.kBlack15Black
                                    //             .copyWith(fontSize: 14.0),
                                    //       )
                                    //           : Text(
                                    //         "Select Document Type",
                                    //         style: CustomFonts.kBlack15Black
                                    //             .copyWith(fontSize: 14.0),
                                    //       ),
                                    //     ),
                                    //     underline: const SizedBox(),
                                    //     items: claimSubmitted.data!.rejectedDocList!.map((value) {
                                    //       return DropdownMenuItem<String>(
                                    //         value: value,
                                    //         child: Text(value),
                                    //       );
                                    //     }).toList(),
                                    //     onChanged: (dynamic value) {
                                    //
                                    //       //controller.additionalProof.value = value!;
                                    //       dropdownName=value;
                                    //
                                    //       setState(() {
                                    //         dropdownName=value;
                                    //       });
                                    //
                                    //     },
                                    //   ),
                                    //   // ),
                                    // ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    // Container(
                                    //   height: 40.0,
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.grey.shade50,
                                    //       borderRadius: BorderRadius.circular(5.0),
                                    //       border: Border.all(
                                    //         color: kGrey,
                                    //       )),
                                    //   child: Row(
                                    //     children: [
                                    //       Flexible(
                                    //         fit: FlexFit.tight,
                                    //         child: Padding(
                                    //           padding: const EdgeInsets.all(8.0),
                                    //           child: Obx(() => Text(
                                    //             controller.additionalProofDoc.value,
                                    //             style: CustomFonts.kBlack15Black
                                    //                 .copyWith(
                                    //                 fontWeight: FontWeight.w600,
                                    //                 fontSize: 14.0),
                                    //           )),
                                    //         ),
                                    //       ),
                                    //       const Spacer(),
                                    //       MaterialButton(
                                    //         elevation: 1.0,
                                    //         onPressed: () async {
                                    //           Get.defaultDialog(
                                    //               title: "Upload",
                                    //               titleStyle: CustomFonts.kBlack15Black
                                    //                   .copyWith(
                                    //                   color: Colors.black,
                                    //                   fontSize: 20.0,
                                    //                   fontWeight: FontWeight.bold),
                                    //               content: Column(
                                    //                 mainAxisSize: MainAxisSize.min,
                                    //                 crossAxisAlignment:
                                    //                 CrossAxisAlignment.center,
                                    //                 mainAxisAlignment:
                                    //                 MainAxisAlignment.center,
                                    //                 children: [
                                    //                   Divider(),
                                    //                   GestureDetector(
                                    //                     onTap: () async {
                                    //                       var file = await controller
                                    //                           .imageFromCamera();
                                    //
                                    //                       controller.additionalProofDoc
                                    //                           .value = basename(file);
                                    //                       controller.additionalDocpath
                                    //                           .value = file;
                                    //                       Get.back(closeOverlays: true);
                                    //                     },
                                    //                     child: Text(
                                    //                       "Take Photo ...",
                                    //                       style: CustomFonts
                                    //                           .kBlack15Black
                                    //                           .copyWith(
                                    //                           color: kdarkBlue,
                                    //                           fontWeight:
                                    //                           FontWeight.w600,
                                    //                           fontSize: 16.0),
                                    //                     ),
                                    //                   ),
                                    //                   const Divider(),
                                    //                   GestureDetector(
                                    //                     behavior:
                                    //                     HitTestBehavior.opaque,
                                    //                     onTap: () async {
                                    //                       await controller
                                    //                           .uploadBorrowerProof();
                                    //                       setState(() {});
                                    //                       Get.back(
                                    //                           closeOverlays:
                                    //                           true);
                                    //                     },
                                    //                     child: Text(
                                    //                       "Choose Files from Phone",
                                    //                       style: CustomFonts
                                    //                           .kBlack15Black
                                    //                           .copyWith(
                                    //                           color: kdarkBlue,
                                    //                           fontWeight:
                                    //                           FontWeight.w600,
                                    //                           fontSize: 16.0),
                                    //                     ),
                                    //                   ),
                                    //                   const Divider(),
                                    //                 ],
                                    //               ),
                                    //               cancel: GestureDetector(
                                    //                 onTap: () {
                                    //                   Get.back(closeOverlays: true);
                                    //                 },
                                    //                 behavior: HitTestBehavior.opaque,
                                    //                 child: Padding(
                                    //                   padding:
                                    //                   const EdgeInsets.all(8.0),
                                    //                   child: Text(
                                    //                     "Cancel",
                                    //                     style: CustomFonts.kBlack15Black
                                    //                         .copyWith(
                                    //                         color: Colors.red,
                                    //                         fontSize: 16),
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //               onCancel: () => Get.back());
                                    //         },
                                    //         shape: RoundedRectangleBorder(
                                    //             side: const BorderSide(color: kGrey),
                                    //             borderRadius:
                                    //             BorderRadius.circular(5.0)),
                                    //         color: Colors.white,
                                    //         child: Text("Upload",
                                    //             style: CustomFonts.kBlack15Black
                                    //                 .copyWith(
                                    //                 fontSize: 15.0,
                                    //                 fontWeight: FontWeight.w400)),
                                    //       ),
                                    //       const SizedBox(
                                    //         width: 10,
                                    //       )
                                    //     ],
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: 10.0,
                                    // ),
                                    // Text("data"),
                                    Container(
                                      height: 40.0.h,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade50,
                                          borderRadius:
                                          BorderRadius.circular(5.0),
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
                                                    titleStyle: CustomFonts
                                                        .kBlack15Black
                                                        .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                    content: Column(
                                                      mainAxisSize:
                                                      MainAxisSize.min,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        Divider(),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            var file =
                                                            await controller
                                                                .imageFromCamera();
                                                            print(file);
                                                            controller
                                                                .borroweridProofDoc
                                                                .value =
                                                                basename(file);
                                                            controller
                                                                .borrowerIdDocPath
                                                                .value = file;
                                                            Get.back(
                                                                closeOverlays:
                                                                true);
                                                          },
                                                          child: Text(
                                                            "Take Photo ...",
                                                            style: CustomFonts
                                                                .kBlack15Black
                                                                .copyWith(
                                                                color:
                                                                kdarkBlue,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                                fontSize:
                                                                16.0),
                                                          ),
                                                        ),
                                                        Divider(),
                                                        GestureDetector(
                                                          behavior:
                                                          HitTestBehavior
                                                              .opaque,
                                                          onTap: () async {
                                                            // var file =
                                                            //     await controller
                                                            //         .uploadFile();
                                                            // controller
                                                            //         .borroweridProofDoc
                                                            //         .value =
                                                            //     basename(file);
                                                            // controller
                                                            //     .borrowerIdDocPath
                                                            //     .value = file;

                                                            await controller
                                                                .uploadDiscrepancyDocument();
                                                            setState(() {});
                                                            Get.back(
                                                                closeOverlays:
                                                                true);
                                                          },
                                                          child: Text(
                                                            "Choose Files from Phone",
                                                            style: CustomFonts
                                                                .kBlack15Black
                                                                .copyWith(
                                                                color:
                                                                kdarkBlue,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                                fontSize:
                                                                16.0),
                                                          ),
                                                        ),
                                                        Divider(),
                                                      ],
                                                    ),
                                                    cancel: GestureDetector(
                                                      onTap: () {
                                                        Get.back(
                                                            closeOverlays: true);
                                                      },
                                                      behavior:
                                                      HitTestBehavior.opaque,
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                        child: Text(
                                                          "Cancel",
                                                          style: CustomFonts
                                                              .kBlack15Black
                                                              .copyWith(
                                                              color:
                                                              Colors.red,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                    onCancel: () => Get.back());

                                            },
                                            shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    color: kGrey),
                                                borderRadius:
                                                BorderRadius.circular(5.0)),
                                            color: Colors.white,
                                            child: Text("Upload",
                                                style: CustomFonts.kBlack15Black
                                                    .copyWith(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                    FontWeight.w400)),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                    ),

                                    // Text(controller.discrepancyDocument.toString()),
                                    controller.discrepancyDocument != null
                                        ? ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        itemCount:
                                        controller.discrepancyDocument!.length,
                                        itemBuilder: (context, int index) {
                                          return controller
                                              .discrepancyDocument!.isNotEmpty
                                              ? Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .all(8.0),
                                                child: GestureDetector(
                                                    child: Text(
                                                      "Preview",
                                                      style: CustomFonts
                                                          .kBlack15Black
                                                          .copyWith(
                                                          fontSize:
                                                          14.0,
                                                          color:
                                                          kdarkBlue,
                                                          fontWeight:
                                                          FontWeight
                                                              .w700),
                                                    ),
                                                    onTap: () {
                                                      var filePathinPdf;

                                                      String s =
                                                          "${controller.discrepancyDocument![index].toString()}";
                                                      int idx = s
                                                          .indexOf(":");
                                                      List parts = [
                                                        s
                                                            .substring(
                                                            0, idx)
                                                            .trim(),
                                                        s
                                                            .substring(
                                                            idx + 1)
                                                            .trim()
                                                      ];
                                                      var str =
                                                      parts[1];
                                                      var find = "'";
                                                      var replaceWith =
                                                          '';
                                                      var newString =
                                                      str.replaceAll(
                                                          find,
                                                          replaceWith);
                                                      var parts1 =
                                                      str.split(
                                                          '${str[0]}');
                                                      filePathinPdf =
                                                          newString;
                                                      Get.to(() =>
                                                          PreviewScreen(
                                                            filePath:
                                                            filePathinPdf,
                                                            // filePath:  controller
                                                            //     .deathCertificatePath
                                                            //     .value,
                                                          ));
                                                    }),
                                              ),
                                              const Spacer(),
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .discrepancyDocument!
                                                      .removeAt(index);

                                                  setState(() {});
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: klightBlue,
                                                  size: 20,
                                                ),
                                              )
                                            ],
                                          )
                                              : SizedBox();
                                        })
                                        : SizedBox(),
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
                                        onPressed: ()async {

                                          controller.uploadDiscrepancyData(id: ArgData[1],docType: dropdownName ,claimStatus: claimStatus);






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
                        );
                      }
                    }

                    // Displaying LoadingSpinner to indicate waiting state
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dropDown({required List reject})=> Container(
    decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(1.0),

        border: Border.all(color: kBorderColor)),
    child: //Obx(() =>
    DropdownButton<dynamic>(
      isExpanded: true,
      hint: Padding(
        padding: const EdgeInsets.all(8.0),
        child: dropdownName!= null
            ? Text(
          "$dropdownName",
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
      items: reject.map((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (dynamic value) {

        //controller.additionalProof.value = value!;
        dropdownName=value;

        setState(() {
          dropdownName=value;
        });

      },
    ),
    // ),
  );
}
