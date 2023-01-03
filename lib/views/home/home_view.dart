import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/controller/authentication_controller/login_controller.dart';
import 'package:punchin/controller/home_controller/home_controller.dart';
import 'package:punchin/model/home_model/home_count_model.dart';
import 'package:punchin/views/claim_details/details.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> subtitle = [
    "Allocated",
    "Action Pending Cases",
    "WIP",
    "UNDER VERIFICATION"
  ];

  LoginController loginController = Get.put(LoginController());
  HomeController homeController = Get.put(HomeController());

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
      //appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),

                /// app bar
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
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: kBlack,
                              ),
                            ),
                          ),

                          //SvgPicture.asset("assets/icons/search.svg"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text("${GetStorage().read("firstName")} ${GetStorage().read("lastName")}"),
                        Text("${GetStorage().read("userId")} (${GetStorage().read("role")})"),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),

                //search
                // const Padding(
                //   padding: EdgeInsets.only(top: 12, bottom: 2),
                //   child: CustomSearch(
                //     hint: "Search by Name, LAN & Claim id...",
                //     search: true,
                //     //controller: ,
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: homeController.homeTile(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If we got an error
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              '${snapshot.error} occurred',
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                        }
                        // if we got our data
                        else if (snapshot.hasData) {
                          // Extracting data from snapshot object
                          HomeCount? homeCount = snapshot.data as HomeCount;
                          return ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemCount: 1,
                            //homeCount.data.length,
                            itemBuilder: (context, index) {
                              // var singleData = peOrderLine.products?[index];
                              return Column(
                                children: [
                                  // // total case
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     if(homeCount.data!.aGENTALLOCATED.toString()=="0"){
                                  //
                                  //     }
                                  //     else {
                                  //       Get.off(() => Details(title: subtitle[0]));
                                  //     }
                                  //
                                  //   },
                                  //   child: Padding(
                                  //     padding:
                                  //         const EdgeInsets.only(bottom: 8.0),
                                  //     child: Container(
                                  //       width: Get.width,
                                  //       height: 77,
                                  //       decoration: BoxDecoration(
                                  //           gradient: RadialGradient(
                                  //             colors: totalCasseColor,
                                  //           ),
                                  //           color: kLightBlue,
                                  //           borderRadius:
                                  //               BorderRadius.circular(7)),
                                  //       child: Row(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.start,
                                  //         children: [
                                  //           Column(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.start,
                                  //             children: [
                                  //               Stack(
                                  //                 alignment:
                                  //                     AlignmentDirectional
                                  //                         .center,
                                  //                 children: [
                                  //                   SvgPicture.asset(
                                  //                     "assets/icons/book.svg",
                                  //                     color: kWhite,
                                  //                   ),
                                  //                  Positioned(
                                  //                     //left: 18,
                                  //                     // top: 20,
                                  //                     child: Container(
                                  //                       width: 68,
                                  //                       height: 68,
                                  //                       decoration:
                                  //                           BoxDecoration(
                                  //                         shape:
                                  //                             BoxShape.circle,
                                  //                         gradient:
                                  //                             LinearGradient(
                                  //                           colors: circleColor,
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             ],
                                  //           ),
                                  //           // SizedBox(width: 13,),
                                  //           Padding(
                                  //             padding: const EdgeInsets.only(
                                  //                 top: 20),
                                  //             child: Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Text(
                                  //                   homeCount.data!.aGENTALLOCATED
                                  //                       .toString(),
                                  //                   style: kBody20white700,
                                  //                 ),
                                  //                 Text(subtitle[0].toString(),
                                  //                     style: kBody12kWhite500),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),

                                  /// card
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (homeCount.data!.aGENTALLOCATED
                                                    .toString() ==
                                                "0") {
                                            } else {
                                              Get.offAll(() =>
                                                  Details(title: subtitle[0]));
                                            }
                                          },
                                          child: Container(
                                            width: 170,
                                            height: 77,
                                            decoration: BoxDecoration(
                                                gradient: RadialGradient(
                                                  colors: totalCasseColor,
                                                ),
                                                color: Color(
                                                    0xff1dafaf), //kLightBlue,
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Stack(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/icons/book.svg",
                                                          color: kWhite,
                                                        ),
                                                        //SvgPicture.asset("assets/icons/transparentcircle.svg",color: kWhite,),
                                                        Positioned(
                                                          //left: 18,
                                                          // top: 20,
                                                          child: Container(
                                                            width: 68,
                                                            height: 68,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              gradient:
                                                                  LinearGradient(
                                                                colors:
                                                                    circleColor,
                                                              ),

                                                              //borderRadius: BorderRadius.circular(100)
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                //SizedBox(width: 13,),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          homeCount.data!
                                                              .aGENTALLOCATED
                                                              .toString(),
                                                          style:
                                                              kBody20white700,
                                                        ),
                                                        Text(
                                                            subtitle[0]
                                                                .toString(),
                                                            style:
                                                                kBody12kWhite500),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            if (homeCount.data!.iNPROGRESS
                                                    .toString() ==
                                                "0") {
                                            } else {
                                              Get.offAll(() =>
                                                  Details(title: subtitle[2]));
                                            }
                                          },
                                          child: Container(
                                            width: 170,
                                            height: 77,
                                            decoration: BoxDecoration(
                                                color: Color(
                                                    0xff7cb5ec), // kPurpul,
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Stack(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/icons/book.svg",
                                                          color: kWhite,
                                                        ),
                                                        //SvgPicture.asset("assets/icons/transparentcircle.svg",color: kWhite,),
                                                        Positioned(
                                                          //left: 18,
                                                          // top: 20,
                                                          child: Container(
                                                            width: 68,
                                                            height: 68,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              gradient:
                                                                  LinearGradient(
                                                                colors:
                                                                    circleColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                //SizedBox(width: 13,),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        homeCount
                                                            .data!.iNPROGRESS
                                                            .toString(),
                                                        style: kBody20white700,
                                                      ),
                                                      Text(
                                                          subtitle[2]
                                                              .toString(),
                                                          style:
                                                              kBody12kWhite500),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (homeCount.data!.aCTIONPENDING
                                                    .toString() ==
                                                "0") {
                                            } else {
                                              Get.offAll(() =>
                                                  Details(title: subtitle[1]));
                                            }
                                          },
                                          child: Container(
                                            width: 170,
                                            height: 77,
                                            decoration: BoxDecoration(
                                                color: kPurpul,
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Stack(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/icons/book.svg",
                                                          color: kWhite,
                                                        ),
                                                        //SvgPicture.asset("assets/icons/transparentcircle.svg",color: kWhite,),
                                                        Positioned(
                                                          //left: 18,
                                                          // top: 20,
                                                          child: Container(
                                                            width: 68,
                                                            height: 68,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              gradient:
                                                                  LinearGradient(
                                                                colors:
                                                                    circleColor,
                                                              ),

                                                              //borderRadius: BorderRadius.circular(100)
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                //SizedBox(width: 13,),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          homeCount.data!
                                                              .aCTIONPENDING
                                                              .toString(),
                                                          style:
                                                              kBody20white700,
                                                        ),
                                                        Text(
                                                            subtitle[1]
                                                                .toString(),
                                                            style:
                                                                kBody12kWhite500),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            if (homeCount
                                                    .data!.uNDERVERIFICATION
                                                    .toString() ==
                                                "0") {
                                            } else {
                                              Get.offAll(() =>
                                                  Details(title: subtitle[3]));
                                            }
                                          },
                                          child: Container(
                                            width: 170,
                                            height: 77,
                                            decoration: BoxDecoration(
                                                color: kYellowColor,
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Stack(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/icons/book.svg",
                                                          color: kWhite,
                                                        ),
                                                        //SvgPicture.asset("assets/icons/transparentcircle.svg",color: kWhite,),
                                                        Positioned(
                                                          //left: 18,
                                                          // top: 20,
                                                          child: Container(
                                                            width: 68,
                                                            height: 68,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              gradient:
                                                                  LinearGradient(
                                                                colors:
                                                                    circleColor,
                                                              ),

                                                              //borderRadius: BorderRadius.circular(100)
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                //SizedBox(width: 13,),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          homeCount.data!
                                                              .uNDERVERIFICATION
                                                              .toString(),
                                                          style:
                                                              kBody20white700,
                                                        ),
                                                        Text(
                                                            subtitle[3]
                                                                .toString(),
                                                            style:
                                                                kBody12kWhite500),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 1.3,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }),

                const SizedBox(
                  height: 220,
                ),

                Center(
                  child: MaterialButton(
                    height: 30,
                    minWidth: 104,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    color: kdarkBlue,
                    onPressed: () {
                      loginController.postLogout();
                    },
                    child: Text(
                      "Logout",
                      style: CustomFonts.getMultipleStyle(
                          15.0, Colors.white, FontWeight.w400),
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
}
