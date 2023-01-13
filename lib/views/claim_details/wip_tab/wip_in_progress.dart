import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/controller/claim_controller/claim_controller.dart';
import 'package:punchin/model/claim_model/claim_in_progress_model.dart';
import 'package:punchin/views/claim_form_view/claim_form_view.dart';
import 'package:punchin/widget/text_widget/search_text_field.dart';

class WipInProgress extends StatefulWidget {
  const WipInProgress({Key? key,required this.title}) : super(key: key);
  final String title;
  @override
  State<WipInProgress> createState() => _WipInProgressState();
}

class _WipInProgressState extends State<WipInProgress> {
  ClaimController controller = Get.put(ClaimController());
  RxBool details = false.obs;

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [


            // search bar
            Padding(
              padding: EdgeInsets.only(top: 12, bottom: 2),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: kWhite),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8),
                  child: Column(
                    children: [
                      Container(
                        height: 44,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(1.0),
                            border: Border.all(color: kGrey)),
                        child: Obx(() => DropdownButton<String>(
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            controller.causeofDeath.value.isNotEmpty
                                ? Text(
                              controller.causeofDeath.value,
                              style: kBlack15Black
                                  .copyWith(fontSize: 14.0),
                            )
                                : Text(
                              "Search Type",
                              style: kBlack15Black
                                  .copyWith(fontSize: 14.0),
                            ),
                          ),
                          underline: const SizedBox(),
                          items: <String>[
                            'PunchIn Ref. ID',
                            'Loan Account Number',
                            'Name',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.causeofDeath.value = value!;
                          },
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12, bottom: 0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kWhite,
                              border: Border.all()),
                          child: SizedBox(
                            child: CustomSearch(
                              controller: controller.searchController.value,
                              hint: "Search by Bor_Name, LAN & P Ref.id...",
                              search: true,
                              //controller: ,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: kBlue)
                                    )
                                )
                            ),

                            onPressed: () {
                              if (controller.causeofDeath.value == '' ||
                                  controller.causeofDeath.value == null) {
                                Fluttertoast.showToast(
                                    msg: "Search Type cannot be Empty",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {

                                // controller.getClaimSearch(
                                //     status: widget.title.toString(),
                                //     searchKey:
                                //     controller.searchController.value.text);
                                setState(() {});
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Search",
                                style: kBody20white700,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            FutureBuilder(
                future: controller.getClaimInProgress(status: "WIP", searchKey: controller.searchController.value
                    .text),
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
                      WipInProgressModel? claimSubmitted = snapshot.data
                      as WipInProgressModel; // paymentModelFromJson(snapshot.data);
                      return claimSubmitted.data == null
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Center(child: Image.asset("assets/nodata.png"))
                        ],
                      )
                          : ListView.separated(
                        //padding: EdgeInsets.only(top: 15.0.h),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 3),
                        itemCount: claimSubmitted.data!.content!.length,
                        itemBuilder: (context, index) {
                          var singleData =
                          claimSubmitted.data!.content![index];
                          return Container(
                            //width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    width: 1, color: kBorder)),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                // claim id
                                GestureDetector(
                                  onTap: () {
                                    Get.off(() => ClaimFormView(),
                                        arguments: [
                                          widget.title,
                                          claimSubmitted
                                              .data!.content![index]
                                        ]);
                                  },
                                  child: Container(
                                    //width: Get.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(7),
                                        topRight: Radius.circular(7),
                                      ),
                                      color: kBlue,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 12, bottom: 12),
                                      child: Row(
                                        children: [
                                          Text(
                                              "PunchIn Ref. ID : ${singleData.claimId}",
                                              style: kBody14kWhite600)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // details like name contact and date
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 14, left: 22, right: 22),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          // claim register date
                                          const Text(
                                            "Claim Registration Date",
                                            style: kBody13black400,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "${dateChange(singleData.claimDate)}",
                                            style: kBody14black600,
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),

                                          // Nominee Name
                                          const Text(
                                            "Nominee Name",
                                            style: kBody13black400,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            singleData.nomineeName
                                                .toString(),
                                            style: kBody14black600,
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          // claim register date
                                          const Text(
                                            "Borrower Name",
                                            style: kBody13black400,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            singleData.borrowerName
                                                .toString(),
                                            style: kBody14black600,
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),

                                          // Nominee Name
                                          const Text(
                                            "Nominee Contact No.",
                                            style: kBody13black400,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            singleData
                                                .nomineeContactNumber
                                                .toString(),
                                            style: kBody14black600,
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 14,
                                      left: 22,
                                      right: 22,
                                      bottom: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Address",
                                        style: kBody13black400,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        singleData.borrowerAddress
                                            .toString(),
                                        style: kBody14black600,
                                      ),
                                    ],
                                  ),
                                ),

                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 16, left: 22, right: 22),
                                  child: Divider(
                                    thickness: 2,
                                    height: 2,
                                  ),
                                ),

                                //Text( singleData.claimsRemarksDTOs![index].remark.toString()),
                                singleData.claimsRemarksDTOs.toString().length ==2

                                    ? GestureDetector(
                                    onTap: () {
                                      controller
                                          .getClaimDiscrepeancy(
                                          id: singleData.id);
                                      Get.defaultDialog(
                                          title: "",
                                          content: controller
                                              .discrepancyData
                                              .value[
                                          "claimDocuments"]
                                              .length ==
                                              0
                                              ? Container(
                                            child: Column(
                                              children: const [
                                                Icon(Icons
                                                    .hourglass_empty),
                                                Text(
                                                    "No Data Found"),
                                              ],
                                            ),
                                          )
                                              : SingleChildScrollView(
                                            //padding: MediaQuery.of(context).size.height *1,
                                            physics:
                                            NeverScrollableScrollPhysics(),

                                            child: Container(
                                              // height: MediaQuery.of(context).size.height ,
                                              padding:
                                              EdgeInsets
                                                  .all(
                                                  10.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "Document Uploaded",
                                                    style: kBlack15Black,
                                                  ),
                                                  const SizedBox(
                                                    height:
                                                    8.0,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(
                                                            5.0),
                                                        border:
                                                        Border.all(color: kGrey)),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        15,
                                                        vertical:
                                                        10.0),
                                                    child:
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Application process:",
                                                          style:
                                                          kBlack15Black.copyWith(fontSize: 14.0, color: Colors.black),
                                                        ),
                                                        const SizedBox(
                                                          width:
                                                          10,
                                                        ),
                                                        Text(
                                                          "In-progress",
                                                          style:
                                                          kBlack15Black.copyWith(fontSize: 15.0, color: klightBlue),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height:
                                                    Get.height *
                                                        0.6,
                                                    //height: Get.height,
                                                    width: Get
                                                        .width,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        3.0,
                                                        vertical:
                                                        10),
                                                    decoration:
                                                    BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10.0)),
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                        itemCount: controller.discrepancyData.value["agentDocumentStatusList"].length,
                                                        itemBuilder: (context, int index) {
                                                          var claimDiscrepancy = controller.discrepancyData.value["agentDocumentStatusList"][index];

                                                          return Container(
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  flex: 3,
                                                                  child: Container(
                                                                    decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                    height: 50,
                                                                    alignment: Alignment.center,
                                                                    child: Text(
                                                                      "${claimDiscrepancy["agentDocName"]}",
                                                                      style: kBlack15Black,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Container(
                                                                      decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                      height: 50,
                                                                      child: claimDiscrepancy["agentDocName"] == null||claimDiscrepancy["status"] == "UPLOADED"
                                                                          ? Icon(Icons.check_circle, color: Colors.blue)
                                                                          : Icon(Icons.cancel, color: Colors.black12)),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ));
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text(
                                            "View Documentation ",
                                            style: kBlack15Black
                                                .copyWith(
                                                fontWeight:
                                                FontWeight.w800,
                                                color: kdarkBlue,
                                                fontSize: 12.0),
                                          )),
                                    ))
                                    : Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 22.0),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            controller.getClaimDiscrepeancy(id: singleData.id);
                                             Get.defaultDialog(
                                                title: "",
                                                content: controller
                                                    .discrepancyData
                                                    .value[
                                                "claimDocuments"]
                                                    .length ==
                                                    0
                                                    ? Container(
                                                  child:
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text("No Data Found"),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Center(child: Image.asset("assets/nodata.png",))
                                                    ],
                                                  ),
                                                )
                                                    : SingleChildScrollView(
                                                  //padding: MediaQuery.of(context).size.height *1,
                                                  physics:
                                                  NeverScrollableScrollPhysics(),

                                                  child:
                                                  Container(
                                                    // height: MediaQuery.of(context).size.height ,
                                                    padding:
                                                    EdgeInsets.all(10.0),
                                                    child:
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Document Uploaded",
                                                          style: kBlack15Black,
                                                        ),
                                                        const SizedBox(
                                                          height: 8.0,
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), border: Border.all(color: kGrey)),
                                                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "Application process:",
                                                                style: kBlack15Black.copyWith(fontSize: 14.0, color: Colors.black),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                "In-progress",
                                                                style: kBlack15Black.copyWith(fontSize: 15.0, color: klightBlue),
                                                              ),
                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          height: Get.height * 0.6,
                                                          //height: Get.height,
                                                          width: Get.width,
                                                          margin: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 10),
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                                                          child: ListView.builder(
                                                              shrinkWrap: true,
                                                              //physics: NeverScrollableScrollPhysics(),
                                                              itemCount: controller.discrepancyData.value["claimDocuments"].length,
                                                              itemBuilder: (context, int index) {
                                                                var claimDiscrepancy = controller.discrepancyData.value["claimDocuments"][index];

                                                                return SingleChildScrollView(
                                                                  child: Container(
                                                                    child: Column(
                                                                      children: [

                                                                        claimDiscrepancy["agentDocType"]=="SIGNED_FORM"? Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "SIGNED FORM",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child:  Icon(Icons.check_circle, color: Colors.blue)
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ):Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "SIGNED FORM",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child: Icon(Icons.cancel, color: Colors.black12)),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                        claimDiscrepancy["agentDocType"]=="DEATH_CERTIFICATE"? Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "DEATH CERTIFICATE",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child:  Icon(Icons.check_circle, color: Colors.blue)
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ):Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "DEATH CERTIFICATE",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child: Icon(Icons.cancel, color: Colors.black12)),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                        claimDiscrepancy["agentDocType"]=="BORROWER_KYC_PROOF"?Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "BORROWER KYC PROOF",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child:  Icon(Icons.check_circle, color: Colors.blue)
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ):Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "BORROWER KYC PROOF",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child: Icon(Icons.cancel, color: Colors.black12)),
                                                                            ),

                                                                          ],
                                                                        ),




                                                                        claimDiscrepancy["agentDocType"]=="SIGNED_FORM"? Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "SIGNED FORM",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child:  Icon(Icons.check_circle, color: Colors.blue)
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ):Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "SIGNED FORM",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child: Icon(Icons.cancel, color: Colors.black12)),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                        claimDiscrepancy["agentDocType"]=="DEATH_CERTIFICATE"? Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "DEATH CERTIFICATE",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child:  Icon(Icons.check_circle, color: Colors.blue)
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ):Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "DEATH CERTIFICATE",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child: Icon(Icons.cancel, color: Colors.black12)),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                        claimDiscrepancy["agentDocType"]=="BORROWER_KYC_PROOF"?Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "BORROWER KYC PROOF",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child:  Icon(Icons.check_circle, color: Colors.blue)
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ):Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "BORROWER KYC PROOF",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child: Icon(Icons.cancel, color: Colors.black12)),
                                                                            ),

                                                                          ],
                                                                        ),

                                                                        claimDiscrepancy["agentDocType"]=="NOMINEE_KYC_PROOF"? Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "NOMINEE KYC PROOF",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child:  Icon(Icons.check_circle, color: Colors.blue)
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ):Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "NOMINEE KYC PROOF",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child: Icon(Icons.cancel, color: Colors.black12)),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                        claimDiscrepancy["agentDocType"]=="BANK_ACCOUNT_PROOF"? Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "BANK ACCOUNT PROOF",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child:  Icon(Icons.check_circle, color: Colors.blue)
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ):Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "BANK ACCOUNT PROOF",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child: Icon(Icons.cancel, color: Colors.black12)),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                        claimDiscrepancy["agentDocType"]=="ADDITIONAL"? Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "ADDITIONAL",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child:  Icon(Icons.check_circle, color: Colors.blue)
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ):Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "ADDITIONAL",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child: Icon(Icons.cancel, color: Colors.black12)),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                        claimDiscrepancy["agentDocType"]=="RELATIONSHIP_PROOF"? Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "RELATIONSHIP PROOF",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child:  Icon(Icons.check_circle, color: Colors.blue)
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ):Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "RELATIONSHIP PROOF",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child: Icon(Icons.cancel, color: Colors.black12)),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                        claimDiscrepancy["agentDocType"]=="GUARDIAN_ID_PROOF"? Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "GUARDIAN ID PROOF",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child:  Icon(Icons.check_circle, color: Colors.blue)
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ):Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "GUARDIAN ID PROOF",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child: Icon(Icons.cancel, color: Colors.black12)),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                        claimDiscrepancy["agentDocType"]=="GUARDIAN_ADD_PROOF"? Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "GUARDIAN ADD PROOF",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child:  Icon(Icons.check_circle, color: Colors.blue)
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ):Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "GUARDIAN ADD PROOF",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                  height: 50,
                                                                                  child: Icon(Icons.cancel, color: Colors.black12)),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                        // claimDiscrepancy["agentDocType"]==""? Row(
                                                                        //   children: [
                                                                        //     Expanded(
                                                                        //       flex: 3,
                                                                        //       child: Container(
                                                                        //         decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                        //         height: 50,
                                                                        //         alignment: Alignment.center,
                                                                        //         child: Text(
                                                                        //           "${claimDiscrepancy["agentDocType"]}",
                                                                        //           style: kBlack15Black,
                                                                        //         ),
                                                                        //       ),
                                                                        //     ),
                                                                        //     Expanded(
                                                                        //       flex: 1,
                                                                        //       child: Container(
                                                                        //           decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                        //           height: 50,
                                                                        //           child: claimDiscrepancy["isApproved"] == false && claimDiscrepancy["isVerified"] == false
                                                                        //               ? Icon(Icons.check_circle, color: Colors.blue)
                                                                        //               : claimDiscrepancy["isApproved"] == true && claimDiscrepancy["isVerified"] == true
                                                                        //               ? Icon(Icons.check_circle, color: Colors.green)
                                                                        //               : claimDiscrepancy["isApproved"] == false && claimDiscrepancy["isVerified"] == false
                                                                        //               ? Icon(Icons.check_circle, color: Colors.black12)
                                                                        //               : Icon(Icons.cancel, color: Colors.red)),
                                                                        //     ),
                                                                        //
                                                                        //   ],
                                                                        // ):Row(
                                                                        //   children: [
                                                                        //     Expanded(
                                                                        //       flex: 3,
                                                                        //       child: Container(
                                                                        //         decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                        //         height: 50,
                                                                        //         alignment: Alignment.center,
                                                                        //         child: Text(
                                                                        //           "${claimDiscrepancy["agentDocType"]}",
                                                                        //           style: kBlack15Black,
                                                                        //         ),
                                                                        //       ),
                                                                        //     ),
                                                                        //     Expanded(
                                                                        //       flex: 1,
                                                                        //       child: Container(
                                                                        //           decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                        //           height: 50,
                                                                        //           child: Icon(Icons.cancel, color: Colors.black12)),
                                                                        //     ),
                                                                        //
                                                                        //   ],
                                                                        // ),
                                                                        // claimDiscrepancy["agentDocType"]==""? Row(
                                                                        //   children: [
                                                                        //     Expanded(
                                                                        //       flex: 3,
                                                                        //       child: Container(
                                                                        //         decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                        //         height: 50,
                                                                        //         alignment: Alignment.center,
                                                                        //         child: Text(
                                                                        //           "${claimDiscrepancy["agentDocType"]}",
                                                                        //           style: kBlack15Black,
                                                                        //         ),
                                                                        //       ),
                                                                        //     ),
                                                                        //     Expanded(
                                                                        //       flex: 1,
                                                                        //       child: Container(
                                                                        //           decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                        //           height: 50,
                                                                        //           child: claimDiscrepancy["isApproved"] == false && claimDiscrepancy["isVerified"] == false
                                                                        //               ? Icon(Icons.check_circle, color: Colors.blue)
                                                                        //               : claimDiscrepancy["isApproved"] == true && claimDiscrepancy["isVerified"] == true
                                                                        //               ? Icon(Icons.check_circle, color: Colors.green)
                                                                        //               : claimDiscrepancy["isApproved"] == false && claimDiscrepancy["isVerified"] == false
                                                                        //               ? Icon(Icons.check_circle, color: Colors.black12)
                                                                        //               : Icon(Icons.cancel, color: Colors.red)),
                                                                        //     ),
                                                                        //
                                                                        //   ],
                                                                        // ):Row(
                                                                        //   children: [
                                                                        //     Expanded(
                                                                        //       flex: 3,
                                                                        //       child: Container(
                                                                        //         decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                        //         height: 50,
                                                                        //         alignment: Alignment.center,
                                                                        //         child: Text(
                                                                        //           "${claimDiscrepancy["agentDocType"]}",
                                                                        //           style: kBlack15Black,
                                                                        //         ),
                                                                        //       ),
                                                                        //     ),
                                                                        //     Expanded(
                                                                        //       flex: 1,
                                                                        //       child: Container(
                                                                        //           decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                        //           height: 50,
                                                                        //           child: Icon(Icons.cancel, color: Colors.black12)),
                                                                        //     ),
                                                                        //
                                                                        //   ],
                                                                        // ),

                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              }),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                          },
                                          child: Padding(
                                            padding:
                                            const EdgeInsets
                                                .all(8.0),
                                            child: Center(
                                                child: Text(
                                                  "View Documentation ",
                                                  style: kBlack15Black

                                                      .copyWith(
                                                      fontWeight:
                                                      FontWeight
                                                          .w800,
                                                      color:
                                                      kdarkBlue,
                                                      fontSize:
                                                      12.0),
                                                )),
                                          )),
                                      Spacer(),
                                      GestureDetector(
                                          onTap: () {

                                            Get.defaultDialog(
                                                title: "",
                                                content: SingleChildScrollView(
                                                  //padding: MediaQuery.of(context).size.height *1,
                                                  // physics:
                                                  // NeverScrollableScrollPhysics(),

                                                  child: Container(
                                                    // height: MediaQuery.of(context).size.height ,
                                                    padding:
                                                    EdgeInsets
                                                        .all(
                                                        10.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(
                                                          //width: Get.width,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(7),
                                                              topRight: Radius.circular(7),
                                                            ),
                                                            color: kBlue,
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(
                                                                left: 20, top: 12, bottom: 12),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                    "PunchIn Ref. ID : ${singleData.claimId}",
                                                                    style: kBody14kWhite600)
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 10,),
                                                        // Text("Agent Remark"),
                                                        // SizedBox(height: 4,),
                                                        Container(
                                                          height:
                                                          Get.height *
                                                              0.6,
                                                          //height: Get.height,
                                                          width: Get
                                                              .width,
                                                          margin: const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              3.0,
                                                              vertical:
                                                              10),
                                                          decoration:
                                                          BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10.0)),
                                                          child: ListView.builder(
                                                              shrinkWrap: true,
                                                              //physics: NeverScrollableScrollPhysics(),
                                                              itemCount: singleData.claimsRemarksDTOs?.length,
                                                              itemBuilder: (context, int ind) {
                                                                var claimDiscrepancy =singleData.claimsRemarksDTOs;

                                                                return SingleChildScrollView(
                                                                  child: Container(
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [



                                                                        SizedBox(height: 4,),

                                                                        Text("${dateChange1(claimDiscrepancy?[ind].createdAt)} (${claimDiscrepancy?[ind].role.toString().toLowerCase().capitalizeFirst})",
                                                                          style: k12Body323232Black500.copyWith(color: kLightBlack),
                                                                        ),
                                                                        SizedBox(height: 4,),
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 3,
                                                                              child: Container(
                                                                                //decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                                height: 50,
                                                                                alignment: Alignment.centerLeft,
                                                                                child: Text(
                                                                                  "${claimDiscrepancy?[ind].remark.toString()},",
                                                                                  style: kBlack15Black,
                                                                                ),
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              }),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ));


                                          },
                                          child: Padding(
                                            padding:
                                            const EdgeInsets
                                                .all(8.0),
                                            child: Center(
                                                child: Text(
                                                  "View Comment",
                                                  style: kBlack15Black
                                                      .copyWith(
                                                      fontWeight:
                                                      FontWeight
                                                          .w800,
                                                      color:
                                                      kdarkBlue,
                                                      fontSize:
                                                      12.0),
                                                )),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder:
                            (BuildContext context, int index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
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
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (this.mounted) {
            setState(() {
              // Your state change code goes here
            });
          }
        },
        child: Icon(
          Icons.refresh,
          color: Colors.white,
          size: 29,
        ),
        backgroundColor: kBlue,
        tooltip: 'Refresh',
        elevation: 5,
        splashColor: kBlue,
      ),
    );
  }


  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() => isAlertSet = false);
            isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
  String dateChange(date) {
    var temp = DateTime.fromMillisecondsSinceEpoch(date);
    var currentDate = "${temp.day}/ ${temp.month}/ ${temp.year}";
    return currentDate.toString();
  }

  String dateChange1(date) {
    var temp = DateTime.fromMillisecondsSinceEpoch(date);
    final moonLanding = DateTime.parse('$temp');
    var currentDate = "${moonLanding.day}/ ${moonLanding.month}/ ${moonLanding.year}  ${moonLanding.hour}:${moonLanding.minute}";
    return currentDate.toString();//currentDate.toString();
  }
}
