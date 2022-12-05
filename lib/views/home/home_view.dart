import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/controller/authentication_controller/login_controller.dart';
import 'package:punchin/controller/home_controller/home_controller.dart';
import 'package:punchin/model/home_model/home_count_model.dart';
import 'package:punchin/views/details.dart';
import 'package:punchin/widget/text_widget/search_text_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> title = ["22", "11"];
  List<String> subtitle = ["WIP Cases", "Settled Cases ","Total Cases"];
  //List<String> colorsValue = [Color.fromRGBO(136, 136, 221, 1),Color.fromRGBO(124, 181, 236, 1)];
  LoginController loginController=Get.put(LoginController());
  HomeController homeController=Get.put(HomeController());

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
                /// app bar
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(

                          child:ClipRRect(
                            borderRadius:
                             BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              // height: 150,
                              // width: Get.width,
                              imageUrl:
                              "https://images.freeimages.com/images/large-previews/e56/run-away-1555225.jpg",
                              imageBuilder:
                                  (context, imageProvider) =>
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
                              errorWidget:
                                  (context, url, error) =>
                              const Icon(
                                Icons.error,
                                color: kBlack,
                              ),
                            ),
                          ),

                          //SvgPicture.asset("assets/icons/search.svg"),
                        ),
                      ],
                    ),
                    SizedBox(width: 13,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Anil Kumar"),
                        Text("Id:983821"),


                      ],
                    ),
                    Spacer(),
                    // CircleAvatar(
                    //   backgroundColor: Colors.white10,
                    //
                    //   radius: 17.0,
                    //   child: Container(
                    //
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(100),
                    //         border: Border.all(width: 2,color: Colors.black12),
                    //       ),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(4.0),
                    //         child: Icon(Icons.notifications_outlined,color:Colors.black,),
                    //       )),
                    // ),



                  ],
                ),

                //search
                const Padding(
                  padding:  EdgeInsets.only(top: 12,bottom: 2),
                  child: CustomSearch(
                    hint: "Search by Name, LAN & Claim id...",
                    search: true,
                    //controller: ,
                  ),
                ),


                FutureBuilder(
                    future: homeController.homeCount(),
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
                            itemCount: 1 ,//homeCount.data.length,
                            itemBuilder: (context, index) {
                              // var singleData = peOrderLine.products?[index];
                              return Column(
                                children: [
                                  // total case
                                  GestureDetector(
                                    onTap:(){
                                      Get.off(()=>Details(title: subtitle[0]));

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Container(
                                        width: Get.width,
                                        height: 77,
                                        decoration: BoxDecoration(
                                            gradient: RadialGradient(
                                              colors: totalCasseColor,
                                            ),
                                            color: kLightBlue,
                                            borderRadius: BorderRadius.circular(7)
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  alignment : AlignmentDirectional.center,
                                                  children: [
                                                    SvgPicture.asset("assets/icons/book.svg",color: kWhite,),
                                                    //SvgPicture.asset("assets/icons/transparentcircle.svg",color: kWhite,),
                                                    Positioned(
                                                      //left: 18,
                                                      // top: 20,
                                                      child: Container(
                                                        width: 68,
                                                        height: 68,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          gradient: LinearGradient(
                                                            colors: circleColor,
                                                          ),

                                                          //borderRadius: BorderRadius.circular(100)
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            // SizedBox(width: 13,),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(homeCount.data!.aLL.toString(),style: kBody20white700,),
                                                  Text(subtitle[2].toString(),style: kBody12kWhite500),


                                                ],
                                              ),
                                            ),



                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  /// card
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap:(){
                                          Get.off(()=>Details(title: subtitle[0]));

                                                              },
                                        child: Container(
                                          width: 170,
                                          height: 77,
                                          decoration: BoxDecoration(
                                              color: kPurpul,
                                              borderRadius: BorderRadius.circular(7)
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Stack(
                                                    alignment : AlignmentDirectional.center,
                                                    children: [
                                                      SvgPicture.asset("assets/icons/book.svg",color: kWhite,),
                                                      //SvgPicture.asset("assets/icons/transparentcircle.svg",color: kWhite,),
                                                      Positioned(
                                                        //left: 18,
                                                        // top: 20,
                                                        child: Container(
                                                          width: 68,
                                                          height: 68,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            gradient: LinearGradient(
                                                              colors: circleColor,
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
                                              Padding(
                                                padding: const EdgeInsets.only(top: 20),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(homeCount.data!.iNPROGRESS.toString(),style: kBody20white700,),
                                                    Text(subtitle[0].toString(),style: kBody12kWhite500),


                                                  ],
                                                ),
                                              ),



                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap:(){
                                          Get.off(()=>Details(title: subtitle[1]));

                                        },
                                        child: Container(
                                          width: 170,
                                          height: 77,
                                          decoration: BoxDecoration(
                                              color: kLightBlue,
                                              borderRadius: BorderRadius.circular(7)
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Stack(
                                                    alignment : AlignmentDirectional.center,
                                                    children: [
                                                      SvgPicture.asset("assets/icons/book.svg",color: kWhite,),
                                                      //SvgPicture.asset("assets/icons/transparentcircle.svg",color: kWhite,),
                                                      Positioned(
                                                        //left: 18,
                                                        // top: 20,
                                                        child: Container(
                                                          width: 68,
                                                          height: 68,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            gradient: LinearGradient(
                                                              colors: circleColor,
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
                                              Padding(
                                                padding: const EdgeInsets.only(top: 20),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(homeCount.data!.sETTLED.toString(),style: kBody20white700,),
                                                    Text(subtitle[1].toString(),style: kBody12kWhite500),


                                                  ],
                                                ),
                                              ),



                                            ],
                                          ),
                                        ),
                                      ),


                                    ],
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
                        child:const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }),





             SizedBox(height: 20,),

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


                /// claim settlement card
                //  SizedBox(height: 4,),
                //   Container(
                //   //width: Get.width,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(7),
                //       border: Border.all(width:5,color:kBorder )
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //
                //       Padding(
                //         padding: const EdgeInsets.only(top: 20.12,left: 22.06),
                //         child: Text("Submit Claims and Get Reward",style: k14Body323232black600,),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(top: 16,left: 22,),
                //         child: Row(
                //           children: [
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                const SizedBox(
                //                   width:140.5,
                //                   child:  Text("Submit 5 Claims Today. Get a Surprise Reward.",style: kBody13black400,
                //                    maxLines: 5,
                //                    softWrap: true,
                //                      overflow: TextOverflow.ellipsis,
                //                    ),
                //                 ),
                //                 SizedBox(height: 11,),
                //                 MaterialButton(
                //                   height: 30,
                //                   minWidth: 104,
                //                   shape: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(5.0)),
                //                   color: kdarkBlue,
                //                   onPressed: () {
                //
                //                   },
                //                   child: Text(
                //                     "Claim Now",
                //                     style: CustomFonts.getMultipleStyle(
                //                         15.0, Colors.white, FontWeight.w400),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             const Spacer(),
                //             Padding(
                //               padding: const EdgeInsets.only(right: 8.0),
                //               child: SizedBox(
                //                   width: 142.6,
                //                   height: 106,
                //                   child: Image.asset("assets/icons/cashback_happiness 1.png")),
                //             ),
                //           ],
                //         ),
                //       ),
                //
                //
                //
                //       SizedBox(height: 26,)
                //
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
