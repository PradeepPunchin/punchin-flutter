import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/views/details.dart';
import 'package:punchin/widget/text_widget/search_text_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> title = ["22", "11", "01","03","05","07"];
  List<String> subtitle = ["Action Pending", "Claims In-Progress", "Under Verification",
    "Sent to Insurer","Claims Paid","Claims Repudiated"];
  List<String> colorsValue = ["Colors.green", "Colors.green", "Colors.green","Colors.green","Colors.green"];


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
                    CircleAvatar(
                      backgroundColor: Colors.white10,

                      radius: 17.0,
                      child: Container(

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2,color: Colors.black12),
                          ),
                          child: Padding(
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

                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: kBlue,
                      borderRadius: BorderRadius.circular(7)
                    ),
                    child: ListTile(
                      onTap: (){
                        Get.to(()=>Details(title: "Claims Allocated"));
                      },

                      leading: SvgPicture.asset("assets/icons/book.svg",color: kWhite,),
                      title: Text("12",style: kBody20white700,),
                      subtitle: Text("Claims Allocated",style: kBody12kWhite500),
                    ),
                  ),
                ),

                  GridView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {


                      return GridTile(child: Container(
                        width: Get.width,
                        height: 77,
                        padding: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            color: kBlue,
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: ListTile(
                          onTap: (){
                            Get.to(()=>Details(title: "${subtitle[index].toString()}",));
                          },
                          horizontalTitleGap:13,
                          isThreeLine : true,
                          leading: SvgPicture.asset("assets/icons/book.svg",color: kWhite,),
                            minLeadingWidth:13,
                          title:   Text(title[index].toString(),style: kBody20white700,),
                          subtitle:  Text(subtitle[index].toString(),style: kBody12kWhite500),
                        ),
                      ));
                    },

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio:1.75 ,// 2.15 / 2.8, //2 / 3.05,
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                  ),


                  SizedBox(height: 4,),
                  Container(
                  //width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(width:5,color:kBorder )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(top: 20.12,left: 22.06),
                        child: Text("Submit Claims and Get Reward",style: k14Body323232black600,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16,left: 22,),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               const SizedBox(
                                  width:140.5,
                                  child:  Text("Submit 5 Claims Today. Get a Surprise Reward.",style: kBody13black400,
                                   maxLines: 5,
                                   softWrap: true,
                                     overflow: TextOverflow.ellipsis,
                                   ),
                                ),
                                SizedBox(height: 11,),
                                MaterialButton(
                                  height: 30,
                                  minWidth: 104,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  color: kdarkBlue,
                                  onPressed: () {

                                  },
                                  child: Text(
                                    "Claim Now",
                                    style: CustomFonts.getMultipleStyle(
                                        15.0, Colors.white, FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SizedBox(
                                  width: 142.6,
                                  height: 106,
                                  child: Image.asset("assets/icons/cashback_happiness 1.png")),
                            ),
                          ],
                        ),
                      ),



                      SizedBox(height: 26,)

                    ],
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
