
import 'package:flutter/material.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/widget/text_widget/search_text_field.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Icon(Icons.arrow_back_ios_new ,color: Colors.black),
          title: Text("Claims Allocated",style: TextStyle(
            color: Colors.black,
          ),),
          centerTitle: true,
          actions: <Widget>[
            GestureDetector(
              onTap: () {

              },
              child:Padding(
                padding:  EdgeInsets.all(8),
                child:   CircleAvatar(
                  backgroundColor: Colors.white10,

                  radius: 48.0,
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
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              children: [
                // search bar
                const Padding(
                  padding:  EdgeInsets.only(top: 12,bottom: 2),
                  child: CustomSearch(
                    hint: "Search by Name, LAN & Claim id...",
                    search: true,
                    //controller: ,
                  ),
                ),

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
                                Text("Nominee Name",style: kBody13black400,),
                                SizedBox(height: 4,),
                                Text("Sanjay Prakash",style: kBody14black600,),
                              ],
                            ),
                           const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nominee Number",style: kBody13black400,),
                                SizedBox(height: 4,),
                                Text("9462302854",style: kBody14black600,),
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
                                Text("6/06/2022",style: kBody14black600,),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Borrower Name"),
                                SizedBox(height: 4,),
                                Text("Ram Prakash",style: kBody14black600,),
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


                            Text("H-23, Gali Number 45, Lal bagh Chowk, Prayagraj, UP ",style: kBody14black600,),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}
