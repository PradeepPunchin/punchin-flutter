
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/widget/text_widget/search_text_field.dart';

class TrackingHome extends StatefulWidget {
  const TrackingHome({Key? key, }) : super(key: key);

  @override
  State<TrackingHome> createState() => _TrackingHomeState();
}

class _TrackingHomeState extends State<TrackingHome> {

  RxBool details = false.obs;
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
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Column(
                children: [
                  // search bar

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
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:const [
                          SizedBox(height: 8,),
                          Text("Claim Tracking",style: kBody16black600,),



                        ],
                      ),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.white10,

                        radius: 17.0,
                        child: Container(

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 2,color: Colors.black12),
                            ),
                            child:const Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(Icons.notifications_outlined,color:Colors.black,),
                            )),
                      ),



                    ],
                  ),

                  const Padding(
                    padding:  EdgeInsets.only(top: 12,bottom: 2),
                    child: CustomSearch(
                      hint: "Search by Name, LAN & Claim id...",
                      search: true,
                      //controller: ,
                    ),
                  ),

                  SizedBox(height: 5,),
                  Container(
                    //width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(width:1,color:kBorder )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft : Radius.circular(7),
                              topRight : Radius.circular(7),

                            ),
                            color:kBlue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20,top: 12,bottom: 12),
                            child: Row(
                              children: [
                                Text("Case/Claim ID : 27193", style: kBody14kWhite600)

                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 14,left: 22,right: 22),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Days so far",style: kBody13black400,),
                                  SizedBox(height: 4,),
                                  Text("3 Days",style: kBody14black600,),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Status",style: kBody13black400,),
                                  SizedBox(height: 4,),
                                  Text("In-Progress",style: kBody14black600,),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 16,left: 22,right: 22),
                          child: Divider(
                            thickness: 2,
                            height: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 14,left: 22,right: 22,bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Obx(() => details.value== false? GestureDetector(
                                  onTap: (){

                                    details.value=true;
                                  },
                                  child: Center(child: Text("View More ",style: kBody14black600,))): GestureDetector(
            onTap: (){
              details.value=false;
          },
        child: Center(child: Text("View less ",style: kBody14black600,)))),
                              SizedBox(height: 4,),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
