import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/controller/claim_controller/claim_controller.dart';
import 'package:punchin/model/claim_model/claim_submitted.dart';
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
  ClaimController controller =Get.put(ClaimController());
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
                  // app bar
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: (){
                                Get.off(()=>CustomNavigation());
                              },
                              child: Icon(Icons.arrow_back_ios_new ,color: Colors.black)),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(widget.title.toString(),style: kBody16black600),


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
                  // search bar
                  const Padding(
                    padding:  EdgeInsets.only(top: 12,bottom: 2),
                    child: CustomSearch(
                      hint: "Search by Name, LAN & Claim id...",
                      search: true,
                      //controller: ,
                    ),
                  ),



                  widget.title.toString()=="Total Cases"?FutureBuilder(
                      future: controller.getClaimSubmitted(),
                      builder: (context,AsyncSnapshot snapshot) {

                        if (snapshot.connectionState ==
                            ConnectionState.done) {
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
                            ClaimSubmitted? claimSubmitted= snapshot
                                .data
                            as ClaimSubmitted; // paymentModelFromJson(snapshot.data);
                            return   ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              //padding: EdgeInsets.symmetric(horizontal: 16,vertical: 3),
                              itemCount: claimSubmitted.data!.content!.length,
                              itemBuilder: (context,index){

                                var singleData=claimSubmitted.data!.content![index];
                                return GestureDetector(
                                  onTap: (){
                                    Get.off(()=>ClaimFormView(),arguments: [widget.title,claimSubmitted.data!.content![index]]);

                                  },
                                  child: Container(
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
                                                Text("Case/Claim ID : ${singleData.policyNumber}", style: kBody14kWhite600)

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
                                                  Text("Nominee Name",style: kBody13black400,),
                                                  SizedBox(height: 4,),
                                                  Text(singleData.nomineeName.toString(),style: kBody14black600,),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Nominee Number",style: kBody13black400,),
                                                  SizedBox(height: 4,),
                                                  Text(singleData.nomineeContactNumber.toString(),style: kBody14black600,),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 16,left: 22,right: 22),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Allocation date",style: kBody13black400,),
                                                  SizedBox(height: 4,),
                                                  Text(singleData.policyStartDate.toString(),style: kBody14black600,),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Borrower Name"),
                                                  SizedBox(height: 4,),
                                                  Text(singleData.borrowerName.toString(),style: kBody14black600,),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 14,left: 22,right: 22,bottom: 16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Address",style: kBody13black400,),
                                              SizedBox(height: 4,),


                                              Text(singleData.borrowerAddress.toString(),style: kBody14black600,),

                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index){
                                return SizedBox( height: 10,);
                              },

                            );
                          }
                        }

                        // Displaying LoadingSpinner to indicate waiting state
                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 1.3,
                          child:const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );

                      }
                  ):Container(),
                  widget.title.toString()=="Settled Cases"?FutureBuilder(
                      future: controller.getClaimSubmitted(),
                      builder: (context,AsyncSnapshot snapshot) {

                        if (snapshot.connectionState ==
                            ConnectionState.done) {
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
                            ClaimSubmitted? claimSubmitted= snapshot
                                .data
                            as ClaimSubmitted; // paymentModelFromJson(snapshot.data);
                            return   ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              //padding: EdgeInsets.symmetric(horizontal: 16,vertical: 3),
                              itemCount: claimSubmitted.data!.content!.length,
                              itemBuilder: (context,index){

                                var singleData=claimSubmitted.data!.content![index];
                                return Container(
                                  //width: Get.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(width:1,color:kBorder )
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // claim id
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
                                              Text("Case/Claim ID : ${singleData.policyNumber}", style: kBody14kWhite600)

                                            ],
                                          ),
                                        ),
                                      ),
                                      // details like name contact and date
                                      Padding(
                                        padding: const EdgeInsets.only(top: 14,left: 22,right: 22),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // claim register date
                                                Text("Claim Registration Date",style: kBody13black400,),
                                                SizedBox(height: 4,),
                                                Text(singleData.createdDate.toString(),style: kBody14black600,),
                                                SizedBox(height: 16,),

                                                // Nominee Name
                                                Text("Nominee Name",style: kBody13black400,),
                                                SizedBox(height: 4,),
                                                Text(singleData.nomineeName.toString(),style: kBody14black600,),
                                                SizedBox(height: 16,),



                                              ],
                                            ),
                                            const Spacer(),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // claim register date
                                                Text("Borrower Name",style: kBody13black400,),
                                                SizedBox(height: 4,),
                                                Text(singleData.borrowerName.toString(),style: kBody14black600,),
                                                SizedBox(height: 16,),

                                                // Nominee Name
                                                Text("Nominee Contact No.",style: kBody13black400,),
                                                SizedBox(height: 4,),
                                                Text(singleData.nomineeContactNumber.toString(),style: kBody14black600,),
                                                SizedBox(height: 16,),
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
                                      Obx(()=>details.value==true?Padding(
                                        padding: const EdgeInsets.only(top: 0,left: 22,right: 22),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    // claim register date
                                                    Text("Nominee Address",style: kBody13black400,),
                                                    SizedBox(height: 4,),
                                                    Container(
                                                        width: Get.width/4,
                                                        child: Text(singleData.nomineeAddress.toString(),
                                                      style: kBody14black600,
                                                      maxLines: 6,
                                                      softWrap: true,
                                                      overflow: TextOverflow.ellipsis,
                                                    )),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    // claim register date
                                                    Text("Date of Doc Completion",style: kBody13black400,),
                                                    SizedBox(height: 4,),
                                                    Text(singleData.claimInwardDate.toString(),style: kBody14black600,),
                                                    SizedBox(height: 16,),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 16,),
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [

                                                    // Nominee Name
                                                    Text("Insurer Submission Date",style: kBody13black400,),
                                                    SizedBox(height: 4,),
                                                    Text(singleData.claimInwardDate.toString(),style: kBody14black600,),
                                                    SizedBox(height: 16,),



                                                  ],
                                                ),
                                                const Spacer(),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [

                                                    // Nominee Name
                                                    Text("Claim Payment Date ",style: kBody13black400,),
                                                    SizedBox(height: 4,),
                                                    Text(singleData.claimStatus.toString(),style: kBody14black600,),
                                                    SizedBox(height: 16,),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // claim register date
                                                Text("Claim Amount ",style: kBody13black400,),
                                                SizedBox(height: 4,),
                                                Text(singleData.policySumAssured.toString(),style: kBody14black600,),
                                                SizedBox(height: 16,),



                                              ],
                                            ),
                                          ],
                                        ),
                                      ):SizedBox()),
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
                              separatorBuilder: (BuildContext context, int index){
                                return SizedBox( height: 10,);
                              },

                            );
                          }
                        }

                        // Displaying LoadingSpinner to indicate waiting state
                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 1.3,
                          child:const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );

                      }
                  ):Container(),

                ],
              ),
            ),
          ),
        ));
  }
}
