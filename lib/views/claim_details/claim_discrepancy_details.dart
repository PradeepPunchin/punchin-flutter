import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/controller/claim_controller/claim_controller.dart';

class ClaimDiscrepancy extends StatefulWidget {
  const ClaimDiscrepancy({Key? key}) : super(key: key);

  @override
  State<ClaimDiscrepancy> createState() => _ClaimDiscrepancyState();
}

class _ClaimDiscrepancyState extends State<ClaimDiscrepancy> {
  ClaimController controller = Get.put(ClaimController());
  List Data=["","","","","","","","","",""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                             // Get.off(() => CustomNavigation());
                            },
                            child: Icon(Icons.arrow_back_ios_new,
                                color: Colors.black)),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Discrepancy/New Requirements", style: kBody16black600),
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
                SizedBox(height: 16,),
                
                Text("Document Uploaded"),
                // FutureBuilder(
                //    future: controller.getClaimSubmitted(status: "DISCREPENCY"),
                //     builder: (context, AsyncSnapshot snapshot) {
                //       if (snapshot.connectionState == ConnectionState.done) {
                //         // If we got an error
                //
                //         if (snapshot.hasError) {
                //           return Center(
                //             child: Text(
                //               '${snapshot.error} occurred',
                //               style: const TextStyle(fontSize: 18),
                //             ),
                //           );
                //
                //           // if we got our data
                //         } else if (snapshot.hasData) {
                //           // Extracting data from snapshot object
                //           // ClaimSubmitted? claimSubmitted = snapshot.data
                //           // as ClaimSubmitted; // paymentModelFromJson(snapshot.data);
                //           return ListView.separated(
                //             shrinkWrap: true,
                //             scrollDirection: Axis.vertical,
                //             physics: BouncingScrollPhysics(),
                //             //padding: EdgeInsets.symmetric(horizontal: 16,vertical: 3),
                //             itemCount: 1,// claimSubmitted.data!.content!.length,
                //             itemBuilder: (context, index) {
                //               // var singleData =
                //               // claimSubmitted.data!.content![index];
                //               return Center(
                //                   child: Column(children: <Widget>[
                //                     Container(
                //                       margin: EdgeInsets.all(20),
                //                       decoration: BoxDecoration(
                //                           borderRadius: BorderRadius.circular(5)
                //                       ),
                //                       child: Table(
                //                         defaultColumnWidth: FixedColumnWidth(120.0),
                //                         border: TableBorder.all(
                //                             color: Colors.black,
                //                             style: BorderStyle.solid,
                //                             width: 2),
                //                         children: [
                //                           TableRow( children: [
                //                             Column(children:[Text('Website', style: TextStyle(fontSize: 20.0))]),
                //                             Column(children:[Text('Tutorial', style: TextStyle(fontSize: 20.0))]),
                //                             Column(children:[Text('Review', style: TextStyle(fontSize: 20.0))]),
                //                           ]),
                //                           TableRow( children: [
                //                             Column(children:[Text('Javatpoint')]),
                //                             Column(children:[Text('Flutter')]),
                //                             Column(children:[Text('5*')]),
                //                           ]),
                //                           TableRow( children: [
                //                             Column(children:[Text('Javatpoint')]),
                //                             Column(children:[Text('MySQL')]),
                //                             Column(children:[Text('5*')]),
                //                           ]),
                //                           TableRow( children: [
                //                             Column(children:[Text('Javatpoint')]),
                //                             Column(children:[Text('ReactJS')]),
                //                             Column(children:[Text('5*')]),
                //                           ]),
                //                         ],
                //                       ),
                //                     ),
                //                   ])
                //               );
                //             },
                //             separatorBuilder:
                //                 (BuildContext context, int index) {
                //               return SizedBox(
                //                 height: 10,
                //               );
                //             },
                //           );
                //         }
                //       }
                //
                //       // Displaying LoadingSpinner to indicate waiting state
                //       return SizedBox(
                //         height: MediaQuery.of(context).size.height / 1.3,
                //         child: const Center(
                //           child: CircularProgressIndicator(),
                //         ),
                //       );
                //     }),

                TextButton(onPressed: (){

                  showDialog(context: context, builder: (BuildContext context){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          border: Border.all(width: .5,color: kBorderColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const  Padding(
                                  padding: const EdgeInsets.only(top: 18.96),
                                  child: Text("Document Uploaded",style: kBody13black700,),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 10.96),
                                  child: Container(
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                      border: Border.all(width: .5,color: kBorderColor),
                                    ),
                                    child:const Padding(
                                      padding:  EdgeInsets.only(left: 15,top: 12,bottom: 12),
                                      child: Text("Application Status : Application Status",style: kBody13black700,),
                                    ),
                                  ),
                                ),

                                Container(
                                  padding:  EdgeInsets.only(top: 12,bottom: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,


                                  ),
                                  child: Table(
                                    defaultVerticalAlignment : TableCellVerticalAlignment.middle,
                                    defaultColumnWidth: const FlexColumnWidth(),
                                    border: TableBorder.all(
                                        color: kBorderColor,
                                        style: BorderStyle.solid,
                                        borderRadius : BorderRadius.circular(5),
                                        width: .5),
                                    children: [
                                      TableRow( children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(children:[Text('Nominee Signed Claim Form', style: k12Body323232Black500)]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(children:[CircleAvatar(
                                              radius:16.67,
                                              child: Icon(Icons.check))]),
                                        ),
                                      ]),
                                      TableRow( children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(children:[Text('Nominee Signed Claim Form', style: k12Body323232Black500)]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(children:[CircleAvatar(
                                              radius:16.67,
                                              child: Icon(Icons.check))]),
                                        ),
                                      ]),
                                      TableRow( children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(children:[Text('Nominee Signed Claim Form', style: k12Body323232Black500)]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(children:[CircleAvatar(
                                              radius:16.67,
                                              child: Icon(Icons.check))]),
                                        ),
                                      ]),
                                      TableRow( children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(children:[Text('Nominee Signed Claim Form', style: k12Body323232Black500)]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(children:[CircleAvatar(
                                              radius:16.67,
                                              child: Icon(Icons.check))]),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    );
                  });


                },child: Text("show dialog")),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  border: Border.all(width: .5,color: kBorderColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const  Padding(
                          padding: const EdgeInsets.only(top: 18.96),
                          child: Text("Document Uploaded",style: kBody13black700,),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 10.96),
                          child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(width: .5,color: kBorderColor),
                            ),
                            child:const Padding(
                              padding:  EdgeInsets.only(left: 15,top: 12,bottom: 12),
                              child: Text("Application Status : Application Status",style: kBody13black700,),
                            ),
                          ),
                        ),

                        Container(
                          padding:  EdgeInsets.only(top: 12,bottom: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,


                          ),
                          child: Table(
                           defaultVerticalAlignment : TableCellVerticalAlignment.middle,
                            defaultColumnWidth: const FlexColumnWidth(),
                            border: TableBorder.all(
                                color: kBorderColor,
                                style: BorderStyle.solid,
                                borderRadius : BorderRadius.circular(5),
                                width: .5),
                            children: [
                              TableRow( children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children:[Text('Nominee Signed Claim Form', style: k12Body323232Black500)]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children:[CircleAvatar(
                                   radius:16.67,
                                      child: Icon(Icons.check))]),
                                ),
                              ]),
                              TableRow( children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children:[Text('Nominee Signed Claim Form', style: k12Body323232Black500)]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children:[CircleAvatar(
                                      radius:16.67,
                                      child: Icon(Icons.check))]),
                                ),
                              ]),
                              TableRow( children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children:[Text('Nominee Signed Claim Form', style: k12Body323232Black500)]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children:[CircleAvatar(
                                      radius:16.67,
                                      child: Icon(Icons.check))]),
                                ),
                              ]),
                              TableRow( children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children:[Text('Nominee Signed Claim Form', style: k12Body323232Black500)]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children:[CircleAvatar(
                                      radius:16.67,
                                      child: Icon(Icons.check))]),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ]),
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
}
