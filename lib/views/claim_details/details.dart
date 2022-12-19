import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/controller/claim_controller/claim_controller.dart';
import 'package:punchin/model/claim_model/claim_in_progress_model.dart';
import 'package:punchin/model/claim_model/claim_submitted.dart';
import 'package:punchin/views/claim_details/claim_discrepancy_details.dart';
import 'package:punchin/views/claim_form_view/claim_form_view.dart';
import 'package:punchin/widget/custom_bottom_bar.dart';
import 'package:punchin/widget/text_widget/search_text_field.dart';

class Details extends StatefulWidget {
  const Details({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
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
              // search bar
              const Padding(
                padding: EdgeInsets.only(top: 12, bottom: 2),
                child: CustomSearch(
                  hint: "Search by Name, LAN & Claim id...",
                  search: true,
                  //controller: ,
                ),
              ),

              // Allocated
              widget.title.toString() == "Allocated"
                  ? FutureBuilder(
                      future: controller.getClaimSubmitted(status: "ALLOCATED"),
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
                            ClaimSubmitted? claimSubmitted = snapshot.data
                                as ClaimSubmitted; // paymentModelFromJson(snapshot.data);
                            return ListView.separated(
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
                                    Get.off(() => ClaimFormView(), arguments: [
                                      widget.title,
                                      claimSubmitted.data!.content![index]
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
                                                    "Case/Claim ID : ${singleData.punchinClaimId}",
                                                    style: kBody14kWhite600)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 14, left: 22, right: 22),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Nominee Name",
                                                    style: kBody13black400,
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    singleData.nomineeName
                                                        .toString(),
                                                    style: kBody14black600,
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Nominee Number",
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
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 16, left: 22, right: 22),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Allocation date",
                                                    style: kBody13black400,
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    "${dateChange(singleData.allocationDate)}",
                                                    style: kBody14black600,
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Borrower Name"),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    singleData.borrowerName
                                                        .toString(),
                                                    style: kBody14black600,
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
                                      ],
                                    ),
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
                      })
                  : Container(),

              widget.title.toString() == "Action Pending Cases"
                  ? FutureBuilder(
                      future: controller.getClaimSubmitted(
                          status: "ACTION_PENDING"),
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
                        ClaimSubmitted? claimSubmitted = snapshot.data
                        as ClaimSubmitted; // paymentModelFromJson(snapshot.data);
                        return ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          //padding: EdgeInsets.symmetric(horizontal: 16,vertical: 3),
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
                                              "Case/Claim ID : ${singleData.punchinClaimId}",
                                              style: kBody14kWhite600)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14, left: 22, right: 22),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Nominee Name",
                                              style: kBody13black400,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              singleData.nomineeName
                                                  .toString(),
                                              style: kBody14black600,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Nominee Number",
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
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16, left: 22, right: 22),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Allocation date",
                                              style: kBody13black400,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              "${dateChange(singleData.allocationDate)}",
                                              style: kBody14black600,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text("Borrower Name"),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              singleData.borrowerName
                                                  .toString(),
                                              style: kBody14black600,
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
                                  const  Padding(
                                    padding:
                                    EdgeInsets.only(top: 16, left: 22, right: 22),
                                    child: Divider(
                                      thickness: 2,
                                      height: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14, left: 22, right: 22, bottom: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Get.off(() => ClaimFormView(), arguments: [
                                                widget.title,
                                                claimSubmitted.data!.content![index]
                                              ]);
                                            },
                                            child:const Center(
                                                child: Text(
                                                  "Act Now",
                                                  style: kBody14black600,
                                                ))),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                      ],
                                    ),
                                  ),
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
                  })
                  : Container(),

              // WIP
              widget.title.toString() == "WIP" ? tab() : Container(),

              widget.title.toString() == "UNDER VERIFICATION"
                  ? FutureBuilder(

                  future: controller.getClaimUnderVerification(
                      status: "UNDER_VERIFICATION"),
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
                        return ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          //padding: EdgeInsets.symmetric(horizontal: 16,vertical: 3),
                          itemCount: claimSubmitted.data!.content!.length,
                          itemBuilder: (context, index) {
                            var singleData =
                            claimSubmitted.data!.content![index];
                            return Container(
                              //width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border:
                                  Border.all(width: 1, color: kBorder)),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  // claim id
                                  Container(
                                    //width: Get.width,
                                    decoration:const BoxDecoration(
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
                                              "Case/Claim ID : ${singleData.claimId}",
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
                                            Text(
                                              "Claim Registration Date",
                                              style: kBody13black400,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              "${dateChange(singleData.claimDate)}",
                                              style: kBody14black600,
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),

                                            // Nominee Name
                                            Text(
                                              "Nominee Name",
                                              style: kBody13black400,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              singleData.nomineeName
                                                  .toString(),
                                              style: kBody14black600,
                                            ),
                                            SizedBox(
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
                                            Text(
                                              "Borrower Name",
                                              style: kBody13black400,
                                            ),
                                            SizedBox(
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

                                  // address

                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 14,left: 22,right: 22,bottom: 16),
                                  //   child: Column(
                                  //     crossAxisAlignment: CrossAxisAlignment.start,
                                  //     children: [
                                  //       Text("Address",style: kBody13black400,),
                                  //       SizedBox(height: 4,),
                                  //
                                  //
                                  //       Text(singleData.borrowerAddress.toString(),style: kBody14black600,),
                                  //
                                  //     ],
                                  //   ),
                                  // ),
                                  Obx(() => details.value == true
                                      ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, left: 22, right: 22),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                // claim register date
                                                Text(
                                                  "Nominee Address",
                                                  style:
                                                  kBody13black400,
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Container(
                                                    width:
                                                    Get.width / 4,
                                                    child: Text(
                                                      singleData
                                                          .borrowerAddress
                                                          .toString(),
                                                      style:
                                                      kBody14black600,
                                                      maxLines: 6,
                                                      softWrap: true,
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                    )),
                                              ],
                                            ),
                                            const Spacer(),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                // claim register date
                                                Text(
                                                  "Date of Doc Completion",
                                                  style:
                                                  kBody13black400,
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text("${dateChange(singleData.claimDate)}",
                                                  style:
                                                  kBody14black600,
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                // Nominee Name
                                                // Text(
                                                //   "Insurer Submission Date",
                                                //   style:
                                                //   kBody13black400,
                                                // ),
                                                Text(
                                                  "Submission Date",
                                                  style:
                                                  kBody13black400,
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  "${dateChange(singleData.claimDate)}",
                                                  style:
                                                  kBody14black600,
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                // Nominee Name
                                                Text(
                                                  "Verifier Name",
                                                  style:
                                                  kBody13black400,
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  singleData
                                                      .borrowerName
                                                      .toString(),
                                                  softWrap: true,
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,

                                                  style:
                                                  kBody14black600.copyWith(fontSize: 14),
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Column(
                                        //   crossAxisAlignment:
                                        //   CrossAxisAlignment
                                        //       .start,
                                        //   children: [
                                        //     // claim register date
                                        //     Text(
                                        //       "Claim Amount ",
                                        //       style: kBody13black400,
                                        //     ),
                                        //     SizedBox(
                                        //       height: 4,
                                        //     ),
                                        //     Text(
                                        //       singleData
                                        //           .id
                                        //           .toString(),
                                        //       style: kBody14black600,
                                        //     ),
                                        //     SizedBox(
                                        //       height: 16,
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  )
                                      : SizedBox()),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 16, left: 22, right: 22),
                                    child: Divider(
                                      thickness: 2,
                                      height: 2,
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
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Obx(() => details.value == false
                                            ? GestureDetector(
                                            onTap: () {
                                              details.value = true;
                                            },
                                            child: Center(
                                                child: Text(
                                                  "View More ",
                                                  style: kBody14black600,
                                                )))
                                            : GestureDetector(
                                            onTap: () {
                                              details.value = false;
                                            },
                                            child: Center(
                                                child: Text(
                                                  "View less ",
                                                  style: kBody14black600,
                                                )))),
                                        SizedBox(
                                          height: 4,
                                        ),
                                      ],
                                    ),
                                  ),
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
                  })
                  : Container(),

            ],
          ),
        ),
      ),
    ));
  }

  Widget tab() => DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
             // width: Get.width,

              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(25.0)),
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: kdarkBlue,
                unselectedLabelStyle: CustomFonts.kBlack15Black
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
                        child: Text("In-Progress")),
                  ),
                  Tab(
                    child: Container(
                      //width:Get.width,
                      padding: const EdgeInsets.only(bottom: 14.0,top: 13,left: 0,right: 0),
                      child: Center(
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
          Container(
            padding: EdgeInsets.only(top: 16),


            height: Get.height,
            child: TabBarView(
              viewportFraction : 1.0,
              children: [one(), two()],
            ),
          )
        ],
      ));

  Widget one() => SafeArea(
    child: SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
              future: controller.getClaimInProgress(status: "WIP"),
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
                    return claimSubmitted.data!.content!.length ==0 ?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: 100,),

                        Center(child: Text("No Data Found"))
                      ],
                    ):
                    ListView.separated(
                      padding: EdgeInsets.only(top: 15.0.h),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      //padding: EdgeInsets.symmetric(horizontal: 16,vertical: 3),
                      itemCount: claimSubmitted.data!.content!.length,
                      itemBuilder: (context, index) {
                        var singleData = claimSubmitted.data!.content![index];
                        return  Container(
                          //width: Get.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(width: 1, color: kBorder)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                      Text("Case/Claim ID : ${singleData.claimId}",
                                          style: kBody14kWhite600)
                                    ],
                                  ),
                                ),
                              ),
                              // details like name contact and date
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 14, left: 22, right: 22),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // claim register date
                                        Text(
                                          "Claim Registration Date",
                                          style: kBody13black400,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                            "${dateChange(singleData.claimDate)}",
                                          style: kBody14black600,
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),

                                        // Nominee Name
                                        Text(
                                          "Nominee Name",
                                          style: kBody13black400,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          singleData.nomineeName.toString(),
                                          style: kBody14black600,
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // claim register date
                                        Text(
                                          "Borrower Name",
                                          style: kBody13black400,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          singleData.borrowerName.toString(),
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
                                          singleData.nomineeContactNumber.toString(),
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
                                padding: EdgeInsets.only(top: 16, left: 22, right: 22),
                                child: Divider(
                                  thickness: 2,
                                  height: 2,
                                ),
                              ),

                              GestureDetector(
                                  onTap: () {
                                    controller.getClaimDiscrepeancy(id: singleData.id
                                    );
                                    Get.defaultDialog(
                                        title: "",
                                        content: controller.discrepancyData.value["claimDocuments"].length ==0 ?Container(
                                          child: Column(
                                            children:const [
                                              Icon(Icons.hourglass_empty),
                                              Text("No Data Found"),
                                            ],
                                          ),
                                        ):Container(
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
                                                //height: Get.height * 0.6,
                                                width: Get.width,
                                                margin: const EdgeInsets.symmetric(
                                                    horizontal: 3.0, vertical: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(10.0)),
                                                child: ListView.builder(
                                                    itemCount: controller.discrepancyData.value["claimDocuments"].length,
                                                    itemBuilder: (context, int index) {
                                                      var claimDiscrepancy= controller.discrepancyData.value["claimDocuments"][index];

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
                                                                child:claimDiscrepancy["isApproved"]==false && claimDiscrepancy["isVerified"] ==false
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
                                        ));


                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                      "View More ",
                                      style: CustomFonts.kBlack15Black.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: kdarkBlue,
                                          fontSize: 15.0),
                                    )),
                                  )),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
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
  );
  Widget two() => SafeArea(
    child: SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
              future: controller.getClaimInProgress(status: "DISCREPENCY"),
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
                    return  claimSubmitted.data!.content!.length ==0 ?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: 100,),

                        Center(child: Text("No Data Found"))
                      ],
                    ): ListView.separated(
                      padding: EdgeInsets.only(top: 15.0.h),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      //padding: EdgeInsets.symmetric(horizontal: 16,vertical: 3),
                      itemCount: claimSubmitted.data!.content!.length,
                      itemBuilder: (context, index) {
                        var singleData = claimSubmitted.data!.content![index];
                        return Container(
                          //width: Get.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(width: 1, color: kBorder)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                      Text("Case/Claim ID : ${singleData.claimId}",
                                          style: kBody14kWhite600)
                                    ],
                                  ),
                                ),
                              ),
                              // details like name contact and date
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 14, left: 22, right: 22),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                      const  SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          singleData.nomineeName.toString(),
                                          style: kBody14black600,
                                        ),
                                       const SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // claim register date
                                      const  Text(
                                          "Borrower Name",
                                          style: kBody13black400,
                                        ),
                                      const  SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          singleData.borrowerName.toString(),
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
                                          singleData.nomineeContactNumber.toString(),
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
                              // address

                              // Padding(
                              //   padding: const EdgeInsets.only(top: 14,left: 22,right: 22,bottom: 16),
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text("Address",style: kBody13black400,),
                              //       SizedBox(height: 4,),
                              //
                              //
                              //       Text(singleData.borrowerAddress.toString(),style: kBody14black600,),
                              //
                              //     ],
                              //   ),
                              // ),

                              const Padding(
                                padding: EdgeInsets.only(top: 16, left: 22, right: 22),
                                child: Divider(
                                  thickness: 2,
                                  height: 2,
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Get.off(()=>ClaimDiscrepancy(),arguments: [widget.title,singleData.id]);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                          "View More ",
                                          style: CustomFonts.kBlack15Black.copyWith(
                                              fontWeight: FontWeight.w800,
                                              color: kdarkBlue,
                                              fontSize: 15.0),
                                        )),
                                  )),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
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
    var currentDate= "${temp.day}/ ${temp.month}/ ${temp.year}";
    return currentDate.toString();
  }
}
