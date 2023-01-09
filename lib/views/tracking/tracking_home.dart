import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/controller/claim_controller/claim_controller.dart';
import 'package:punchin/model/tracking_model/tracking_model.dart';
import 'package:punchin/widget/text_widget/search_text_field.dart';

class TrackingHome extends StatefulWidget {
  const TrackingHome({
    Key? key,
  }) : super(key: key);

  @override
  State<TrackingHome> createState() => _TrackingHomeState();
}

class _TrackingHomeState extends State<TrackingHome> {
  RxBool details = false.obs;

  RxList array=[].obs;
  ClaimController controller = Get.put(ClaimController());
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

              const SizedBox(
                height: 20,
              ),


              // search bar

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            // height: 150,
                            // width: Get.width,
                            imageUrl:
                                "https://images.freeimages.com/images/large-previews/e56/run-away-1555225.jpg",
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: kBlack,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Claim Tracking",
                        style: kBody16black600,
                      ),
                    ],
                  ),
                  Spacer(),
                  // CircleAvatar(
                  //   backgroundColor: Colors.white10,
                  //   radius: 17.0,
                  //   child: Container(
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(100),
                  //         border: Border.all(width: 2, color: Colors.black12),
                  //       ),
                  //       child: const Padding(
                  //         padding: EdgeInsets.all(4.0),
                  //         child: Icon(
                  //           Icons.notifications_outlined,
                  //           color: Colors.black,
                  //         ),
                  //       )),
                  // ),
                ],
              ),


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
                                hint: "Search by P .Ref id...",
                                search: true,
                                //controller: ,
                              ),
                            ),
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: kBlue,
                            side: BorderSide(width: 2, color: Colors.white),
                          ),
                          onPressed: () {
                            if (controller.searchController.value.text ==null) {
                              Fluttertoast.showToast(
                                  msg: "Search Type cannot be Empty",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              print(controller.searchController.value.text);
                              controller.getClaimTracking(
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
                        )
                      ],
                    ),
                  ),
                ),
              ),



              SizedBox(
                height: 5,
              ),

              //Text("${controller.searchController.value.text.isEmpty}"),

              Obx(()=>controller.searchController.value.text.isEmpty?SizedBox():FutureBuilder(
                  future: controller.getClaimTracking(
                      searchKey: controller.searchController.value.text),
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
                        TrackingModel? trackingModel = snapshot.data
                        as TrackingModel;
                        return Column(
                          children: [
                            trackingModel.data!.startedAt != null?SizedBox(
                              height: 200,
                              child: ListView.separated(
                                shrinkWrap: true,

                                physics: BouncingScrollPhysics(),

                                itemCount:1,
                                itemBuilder: (context, index) {
                                  var singleData =
                                  trackingModel.data!.claimHistoryDTOS![index];
                                  return Container(
                                    //width: Get.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(width: 1, color: kBorder)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                                Text("P Ref.Id : ${controller.searchController.value.text}",
                                                    style: kBody14kWhite600)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(top: 14, left: 22, right: 22),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Days so far",
                                                    style: kBody13black400,
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    "${dateChange(trackingModel.data!.startedAt)}",
                                                    style: kBody14black600,
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Status",
                                                    style: kBody13black400,
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    singleData.claimStatus.toString(),// dateChange(singleData.claimStatus),
                                                    style: kBody14black600,
                                                  ),
                                                ],
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
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 14, left: 22, right: 22, bottom: 16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
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
                                                    array.add(singleData);
                                                    ViewMore(array: singleData);
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
                              ),
                            ):SizedBox(child: Text("No Data Found"),),
                            trackingModel.data!.startedAt != null?Obx(() => details.value == true ?SizedBox(
                              //height: 400,
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:trackingModel.data!.claimHistoryDTOS!.length,
                                itemBuilder: (context, index) {
                                  var singleData = trackingModel.data!.claimHistoryDTOS![index];
                                  return singleData.claimStatus=="IN_PROGRESS"?SizedBox():Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(7)),
                                      child: ListTile(
                                        onTap: () {
                                          // Get.to(()=>Details(title: "Claims Allocated"));
                                        },
                                        leading: CircleAvatar(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                            child: singleData.claimStatus=="CLAIM_INTIMATED" ||singleData.claimStatus=="AGENT_ALLOCATED"?SvgPicture.asset("assets/icons/cards.svg"):SvgPicture.asset("assets/icons/Time Circle.svg"),
                                            // CachedNetworkImage(
                                            //   // height: 150,
                                            //   // width: Get.width,
                                            //   imageUrl:
                                            //   "https://images.freeimages.com/images/large-previews/e56/run-away-1555225.jpg",
                                            //   imageBuilder: (context, imageProvider) =>
                                            //       Container(
                                            //         decoration: BoxDecoration(
                                            //           image: DecorationImage(
                                            //             image: imageProvider,
                                            //             fit: BoxFit.fill,
                                            //           ),
                                            //         ),
                                            //       ),
                                            //   placeholder: (context, url) =>
                                            //   const CircularProgressIndicator(),
                                            //   errorWidget: (context, url, error) =>
                                            //   const Icon(
                                            //     Icons.error,
                                            //     color: kBlack,
                                            //   ),
                                            // ),
                                          ),
                                        ),
                                        title: Text(
                                          "${dateChange(trackingModel.data!.claimHistoryDTOS![index].createdAt)}",
                                          style: k11Body929292LightBlack500.copyWith(fontSize: 14),
                                        ),
                                        subtitle: Text("${singleData.description}",
                                            style: k12Body323232Black500.copyWith(fontSize: 16)),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 5,
                                  );
                                },
                              ),
                            ): SizedBox()):SizedBox(),
                          ],
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
                  })),
              // Container(
              //   //width: Get.width,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(7),
              //       border: Border.all(width: 1, color: kBorder)),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Container(
              //         //width: Get.width,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(7),
              //             topRight: Radius.circular(7),
              //           ),
              //           color: kBlue,
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.only(
              //               left: 20, top: 12, bottom: 12),
              //           child: Row(
              //             children: [
              //               Text("Case/Claim ID : 27193",
              //                   style: kBody14kWhite600)
              //             ],
              //           ),
              //         ),
              //       ),
              //       Padding(
              //         padding:
              //             const EdgeInsets.only(top: 14, left: 22, right: 22),
              //         child: Row(
              //           children: [
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   "Days so far",
              //                   style: kBody13black400,
              //                 ),
              //                 SizedBox(
              //                   height: 4,
              //                 ),
              //                 Text(
              //                   "3 Days",
              //                   style: kBody14black600,
              //                 ),
              //               ],
              //             ),
              //             const Spacer(),
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   "Status",
              //                   style: kBody13black400,
              //                 ),
              //                 SizedBox(
              //                   height: 4,
              //                 ),
              //                 Text(
              //                   "In-Progress",
              //                   style: kBody14black600,
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //       const Padding(
              //         padding: EdgeInsets.only(top: 16, left: 22, right: 22),
              //         child: Divider(
              //           thickness: 2,
              //           height: 2,
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(
              //             top: 14, left: 22, right: 22, bottom: 16),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Obx(() => details.value == false
              //                 ? GestureDetector(
              //                     onTap: () {
              //                       details.value = true;
              //                     },
              //                     child: Center(
              //                         child: Text(
              //                       "View More ",
              //                       style: kBody14black600,
              //                     )))
              //                 : GestureDetector(
              //                     onTap: () {
              //                       details.value = false;
              //                     },
              //                     child: Center(
              //                         child: Text(
              //                       "View less ",
              //                       style: kBody14black600,
              //                     )))),
              //             SizedBox(
              //               height: 4,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),



              // Center(
              //   child: MaterialButton(
              //     height: 30,
              //     minWidth: 104,
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(5.0)),
              //     color: kdarkBlue,
              //     onPressed: () {
              //       loginController.postLogout();
              //     },
              //     child: Text(
              //       "Logout",
              //       style: CustomFonts.getMultipleStyle(
              //           15.0, Colors.white, FontWeight.w400),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    ));
  }
  String dateChange(date) {
    var temp = DateTime.fromMillisecondsSinceEpoch(date);
    var currentDate = "${temp.day}/ ${temp.month}/ ${temp.year} | ${temp.hour}:${temp.minute} ";
    return currentDate.toString();
  }

  Widget ViewMore({array}) =>Obx(() => details.value == true
      ? Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(7)),
          child: ListTile(
            onTap: () {
              // Get.to(()=>Details(title: "Claims Allocated"));
            },
            leading: CircleAvatar(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  // height: 150,
                  // width: Get.width,
                  imageUrl:
                  "https://images.freeimages.com/images/large-previews/e56/run-away-1555225.jpg",
                  imageBuilder: (context, imageProvider) =>
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                  placeholder: (context, url) =>
                  const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                  const Icon(
                    Icons.error,
                    color: kBlack,
                  ),
                ),
              ),

              //SvgPicture.asset("assets/icons/search.svg"),
            ),
            title: Text(
              "06/06/2022 | 05:30 PM",
              style: k11Body929292LightBlack500,
            ),
            subtitle: Text("Claim Intimation",
                style: k12Body323232Black500),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(7)),
          child: ListTile(
            onTap: () {
              // Get.to(()=>Details(title: "Claims Allocated"));
            },
            leading: CircleAvatar(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  // height: 150,
                  // width: Get.width,
                  imageUrl:
                  "https://images.freeimages.com/images/large-previews/e56/run-away-1555225.jpg",
                  imageBuilder: (context, imageProvider) =>
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                  placeholder: (context, url) =>
                  const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                  const Icon(
                    Icons.error,
                    color: kBlack,
                  ),
                ),
              ),

              //SvgPicture.asset("assets/icons/search.svg"),
            ),
            title: Text(
              "06/06/2022 | 05:30 PM",
              style: k11Body929292LightBlack500,
            ),
            subtitle: Text(
                "Claim Registration and Nominee Intimation",
                style: k12Body323232Black500),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(7)),
          child: ListTile(
            onTap: () {
              // Get.to(()=>Details(title: "Claims Allocated"));
            },
            leading: CircleAvatar(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  // height: 150,
                  // width: Get.width,
                  imageUrl:
                  "https://images.freeimages.com/images/large-previews/e56/run-away-1555225.jpg",
                  imageBuilder: (context, imageProvider) =>
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                  placeholder: (context, url) =>
                  const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                  const Icon(
                    Icons.error,
                    color: kBlack,
                  ),
                ),
              ),

              //SvgPicture.asset("assets/icons/search.svg"),
            ),
            title: Text(
              "06/06/2022 | 05:30 PM",
              style: k11Body929292LightBlack500,
            ),
            subtitle: Text("Documentation Upload ",
                style: k12Body323232Black500),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(7)),
          child: ListTile(
            onTap: () {
              // Get.to(()=>Details(title: "Claims Allocated"));
            },
            leading: CircleAvatar(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  // height: 150,
                  // width: Get.width,
                  imageUrl:
                  "https://images.freeimages.com/images/large-previews/e56/run-away-1555225.jpg",
                  imageBuilder: (context, imageProvider) =>
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                  placeholder: (context, url) =>
                  const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                  const Icon(
                    Icons.error,
                    color: kBlack,
                  ),
                ),
              ),

              //SvgPicture.asset("assets/icons/search.svg"),
            ),
            title: Text(
              "06/06/2022 | 05:30 PM",
              style: k11Body929292LightBlack500,
            ),
            subtitle: Text("Documentation Verification",
                style: k12Body323232Black500),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(7)),
          child: ListTile(
            onTap: () {
              // Get.to(()=>Details(title: "Claims Allocated"));
            },
            leading: CircleAvatar(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  // height: 150,
                  // width: Get.width,
                  imageUrl:
                  "https://images.freeimages.com/images/large-previews/e56/run-away-1555225.jpg",
                  imageBuilder: (context, imageProvider) =>
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                  placeholder: (context, url) =>
                  const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                  const Icon(
                    Icons.error,
                    color: kBlack,
                  ),
                ),
              ),

              //SvgPicture.asset("assets/icons/search.svg"),
            ),
            title: Text(
              "06/06/2022 | 05:30 PM",
              style: k11Body929292LightBlack500,
            ),
            subtitle: Text(
                "Insurer Feedback (Discrepancy/AR/FR) ",
                style: k12Body323232Black500),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(7)),
          child: ListTile(
            onTap: () {
              // Get.to(()=>Details(title: "Claims Allocated"));
            },
            leading: CircleAvatar(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  // height: 150,
                  // width: Get.width,
                  imageUrl:
                  "https://images.freeimages.com/images/large-previews/e56/run-away-1555225.jpg",
                  imageBuilder: (context, imageProvider) =>
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                  placeholder: (context, url) =>
                  const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                  const Icon(
                    Icons.error,
                    color: kBlack,
                  ),
                ),
              ),

              //SvgPicture.asset("assets/icons/search.svg"),
            ),
            title: Text(
              "06/06/2022 | 05:30 PM",
              style: k11Body929292LightBlack500,
            ),
            subtitle: Text("Feedback Resolution & Submission",
                style: k12Body323232Black500),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(7)),
          child: ListTile(
            onTap: () {
              // Get.to(()=>Details(title: "Claims Allocated"));
            },
            leading: CircleAvatar(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  // height: 150,
                  // width: Get.width,
                  imageUrl:
                  "https://images.freeimages.com/images/large-previews/e56/run-away-1555225.jpg",
                  imageBuilder: (context, imageProvider) =>
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                  placeholder: (context, url) =>
                  const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                  const Icon(
                    Icons.error,
                    color: kBlack,
                  ),
                ),
              ),

              //SvgPicture.asset("assets/icons/search.svg"),
            ),
            title: Text(
              "06/06/2022 | 05:30 PM",
              style: k11Body929292LightBlack500,
            ),
            subtitle: Text("Claim Settlement",
                style: k12Body323232Black500),
          ),
        ),
      ),
    ],
  )
      : SizedBox());
}
