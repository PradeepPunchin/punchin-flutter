import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/controller/claim_controller/claim_controller.dart';
import 'package:punchin/model/claim_model/claim_in_progress_model.dart';
import 'package:punchin/model/claim_model/claim_submitted.dart';
import 'package:punchin/views/claim_form_view/claim_form_view.dart';
import 'package:punchin/views/discrepency_view_screen.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
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
              widget.title.toString() == "WIP" ? tab() : Container()
            ],
          ),
        ),
      ),
    ));
  }

  Widget tab() => DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
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
                    child: Text("In-Progress"),
                  ),
                  Tab(
                    child: Text(
                      "Discrepancy",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: Get.height,
            child: TabBarView(
              children: [one(), two()],
            ),
          )
        ],
      ));

  Widget one() => FutureBuilder(
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
            return ListView.separated(
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
                                Text(
                                  "Claim Registration Date",
                                  style: kBody13black400,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  singleData.claimDate.toString(),
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
                            Get.defaultDialog(
                                title: "",
                                content: Container(
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
                                        height: Get.height * 0.6,
                                        width: Get.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 3.0, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
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
                                                                color: kGrey)
                                                            : Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color: Colors
                                                                    .green),
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
      });
  Widget two() => FutureBuilder(
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
            return ListView.separated(
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
                                  singleData.claimDate.toString(),
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
                            Get.defaultDialog(
                                title: "",
                                content: Container(
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
                                        height: Get.height * 0.6,
                                        width: Get.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 3.0, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10.0)),
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
                                                            color: kGrey)
                                                            : Icon(
                                                            Icons
                                                                .check_circle,
                                                            color: Colors
                                                                .green),
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
      });

  String dateChange(date) {
    var temp = DateTime.fromMillisecondsSinceEpoch(date);
    return temp.toString();
  }
}
