import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/controller/claim_controller/claim_controller.dart';
import 'package:punchin/model/claim_model/claim_in_progress_model.dart';
import 'package:punchin/views/claim_details/claim_discrepancy_details.dart';
import 'package:punchin/views/claim_details/wip_tab/wip_discrepency.dart';
import 'package:punchin/views/claim_form_view/claim_form_view.dart';
import 'package:punchin/widget/custom_bottom_bar.dart';
import 'package:punchin/widget/text_widget/search_text_field.dart';

import 'wip_tab/wip_in_progress.dart';

class WIPDetails extends StatefulWidget {
  const WIPDetails({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<WIPDetails> createState() => _WIPDetailsState();
}

class _WIPDetailsState extends State<WIPDetails> {
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



  Future<void> share() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.off(() => CustomNavigation());
                    },
                    child: Icon(Icons.arrow_back_ios_new,
                        color: Colors.black)),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.title.toString(), style: kBody16black600),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
      body:MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          //initialIndex : 1,
            length: 2,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      //width: Get.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(25.0)),
                      child: TabBar(
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: kdarkBlue,
                        unselectedLabelStyle: kBlack15Black
                            .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                        isScrollable: false,
                        indicator: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            color: kdarkBlue),
                        tabs: [
                          Tab(
                            child: Container(
                              //width:172,
                              //padding: const EdgeInsets.only(bottom: 14.0,top: 13,left: 51.0,right: 46),
                                child:const Text("In-Progress")),
                          ),
                          Tab(
                            child: Container(
                              //width:Get.width,
                              padding: const EdgeInsets.only(
                                  bottom: 14.0, top: 13, left: 0, right: 0),
                              child:const Center(
                                child: Text(
                                  "Discrepancy",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 2),
                      height: Get.height,
                      child: TabBarView(
                        viewportFraction: 1,
                        children: [
                          WipInProgress(title: widget.title,),
                          WipDiscrepency(title: widget.title,),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  // Widget tab() => ;

  Widget one() => Scaffold(

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
                                print(controller.causeofDeath.value);
                                print(controller.searchController.value.text);
                                controller.getClaimSearch(
                                    status: widget.title.toString(),
                                    searchKey:
                                    controller.searchController.value.text);
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
                      return claimSubmitted.data!.content!.length == 0
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Center(child: Text("No Data Found"))
                        ],
                      )
                          : ListView.separated(
                        padding: EdgeInsets.only(top: 15.0.h),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        //padding: EdgeInsets.symmetric(horizontal: 16,vertical: 3),
                        itemCount: claimSubmitted.data!.content!.length,
                        itemBuilder: (context, index) {
                          var singleData =
                          claimSubmitted.data!.content![index];
                          return GestureDetector(
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
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      width: 1, color: kBorder)),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  // claim id
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
                                              "View More ",
                                              style: kBlack15Black
                                                  .copyWith(
                                                  fontWeight:
                                                  FontWeight.w800,
                                                  color: kdarkBlue,
                                                  fontSize: 15.0),
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
                                                                physics: NeverScrollableScrollPhysics(),
                                                                itemCount: controller.discrepancyData.value["claimDocuments"].length,
                                                                itemBuilder: (context, int index) {
                                                                  var claimDiscrepancy = controller.discrepancyData.value["claimDocuments"][index];

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
                                                                              "${claimDiscrepancy["agentDocType"]}",
                                                                              style: kBlack15Black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex: 1,
                                                                          child: Container(
                                                                              decoration: BoxDecoration(border: Border.all(color: kGrey)),
                                                                              height: 50,
                                                                              child: claimDiscrepancy["isApproved"] == false && claimDiscrepancy["isVerified"] == false
                                                                                  ? Icon(Icons.check_circle, color: Colors.blue)
                                                                                  : claimDiscrepancy["isApproved"] == true && claimDiscrepancy["isVerified"] == true
                                                                                  ? Icon(Icons.check_circle, color: Colors.green)
                                                                                  : claimDiscrepancy["isApproved"] == false && claimDiscrepancy["isVerified"] == false
                                                                                  ? Icon(Icons.check_circle, color: Colors.black12)
                                                                                  : Icon(Icons.cancel, color: Colors.red)),
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
                                                    "View More ",
                                                    style: kBlack15Black

                                                        .copyWith(
                                                        fontWeight:
                                                        FontWeight
                                                            .w800,
                                                        color:
                                                        kdarkBlue,
                                                        fontSize:
                                                        15.0),
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
                                                        15.0),
                                                  )),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
  Widget two() =>Scaffold(

      body: SingleChildScrollView(
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
                                print(controller.causeofDeath.value);
                                print(controller.searchController.value.text);
                                controller.getClaimSearch(
                                    status: "DISCREPENCY",
                                    searchKey:
                                    controller.searchController.value.text);
                               // setState(() {});
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
                future: controller.getClaimInProgress(status: "DISCREPENCY",searchKey: controller.searchController.value.text),
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
                        padding: EdgeInsets.only(top: 15.0.h),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
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
                                Container(
                                  width: Get.width,
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
                                    child: Text(
                                      (() {
                                        if ("${singleData.claimStatus}" ==
                                            "VERIFIER_DISCREPENCY") {
                                          return "PunchIn Ref. ID : ${singleData.claimId}   (Discrepancy)";
                                        } else if ("${singleData.claimStatus}" ==
                                            "NEW_REQUIREMENT") {
                                          return "PunchIn Ref. ID : ${singleData.claimId}   (New Doc Req.)";
                                        }

                                        return "Packed";
                                      })(),
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: kBody14kWhite600,
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
                                          SizedBox(
                                            height: 16,
                                          ),

                                          // Nominee Name
                                          Text(
                                            "Nominee Contact No.",
                                            style: kBody13black400,
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            singleData
                                                .nomineeContactNumber
                                                .toString(),
                                            style: kBody14black600,
                                          ),
                                          SizedBox(
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
                                      Text(
                                        "Address",
                                        style: kBody13black400,
                                      ),
                                      SizedBox(
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
                                GestureDetector(
                                    onTap: () {
                                      Get.off(() => ClaimDiscrepancy(),
                                          arguments: [
                                            widget.title,
                                            singleData.id
                                          ]);
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text(
                                            "View More ",
                                            style: kBlack15Black
                                                .copyWith(
                                                fontWeight:
                                                FontWeight.w800,
                                                color: kdarkBlue,
                                                fontSize: 15.0),
                                          )),
                                    )),
                              ],
                            ),
                          );
                        },
                        separatorBuilder:
                            (BuildContext context, int index) {
                          return SizedBox(
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
