import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path/path.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/controller/claim_controller/claim_controller.dart';
import 'package:punchin/views/claim_details/details.dart';
import 'package:punchin/views/claim_details/wip_discrepency.dart';
import 'package:punchin/views/claim_form_view/preview_screen.dart';
import 'package:punchin/widget/text_widget/custom_comment_text_field.dart';

class ClaimFormView extends StatefulWidget {
  const ClaimFormView({Key? key}) : super(key: key);

  @override
  State<ClaimFormView> createState() => _ClaimFormViewState();
}

class _ClaimFormViewState extends State<ClaimFormView> {
  ClaimController controller = Get.put(ClaimController());
  var dataArg = Get.arguments;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  List<String> minorList = [
    'RELATIONSHIP_PROOF',
    'GUARDIAN_ID_PROOF',
    'GUARDIAN_ADD_PROOF',
    'Other Document',
  ];

  List<String> medicialList = <String>[
    'Police FIR Copy *',
    'Medical Records *',
    'Other Document',
  ];

  List<String> accientList = <String>[
    'Police FIR Copy *',
    'Medical Records *',
    'Other Document',
  ];

  List<String> sickList = <String>[
    'Police FIR Copy *',
    'Medical Attendant Certificate *',
    "Medical Records",
    'Other Document',
  ];

  List<String> other = <String>[
    'Police FIR Copy',
    'Postmortem Report',
    'Income Tax Returns',
    'Medical Records',
    'Legal Heir Certificate',
    'Police Investigation Report',
    'Stamped Affidavit',
    'Medical Attendant Certificate',
    'Any utility bill (gas / electricity / rental agreement)',
    'Other Document'
  ];

  bool isRemark = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConnectivity();
    controller.getStepperFormData();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.loadUpload.value = false;
    //controller.causeofDeath.value = controller.claimDetail.value["claimData"]["causeOfDeath"] == null?"":controller.claimDetail.value["claimData"]["causeOfDeath"];

    return Obx(() => controller.loading.value == true
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: GestureDetector(
                onTap: () async {

                  if(dataArg[0]=="WIP"){
                    Get.off(() => WIPDetails(
                      title: '${dataArg[0]}',
                    ));
                  }
                  else{
                    Get.off(() => Details(
                      title: '${dataArg[0]}',
                    ));
                  }
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
              centerTitle: true,
              title: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: klightBlue,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Obx(
                  () => Text(
                    "P Ref. ID : ${controller.claimDetail.value["claimData"]["punchinClaimId"]}",
                    style: kBlack15Black.copyWith(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            body: customStepperForm(),
          ));
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

  showDialogBox() => showCupertinoDialog<String>(
        context: this.context,
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

  customStepperForm() {
    return Container(
      child: Stack(
        children: [
          Obx(
            () => Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  buildRow(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    flex: 8,
                    child: PageView(
                      controller: controller.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Borrower Details",
                                style: kBlack15Black.copyWith(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 15.0.h,
                              ),
                              smallText(text: "Name"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller.claimDetail
                                      .value["claimData"]["borrowerName"]
                                      .toString()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Date of Birth"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text:
                                      controller.claimDetail.value["claimData"]
                                                  ["borrowerDob"] !=
                                              null
                                          ? dateChange(controller
                                              .claimDetail.value["borrowerDob"])
                                          : ""),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Mobile Number"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text:
                                      controller.claimDetail.value["claimData"]
                                          ["borrowerContactNumber"]),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Email Id"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller.claimDetail
                                      .value["claimData"]["borrowerEmailId"]),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Address"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              addressField(
                                  text: controller.claimDetail
                                      .value["claimData"]["borrowerAddress"])
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Loan Account Details",
                                style: kBlack15Black.copyWith(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 15.0.h,
                              ),
                              smallText(text: "Loan Account Number"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller.claimDetail
                                      .value["claimData"]["loanAccountNumber"]),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Loan Type / Category"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller.claimDetail
                                      .value["claimData"]["loanType"]),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Loan O/S Amt"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller
                                      .claimDetail
                                      .value["claimData"]
                                          ["loanOutstandingAmount"]
                                      .toString()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Lender Name"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller.claimDetail
                                              .value["claimData"]["lenderName"]
                                              .toString() !=
                                          null
                                      ? controller.claimDetail
                                          .value["claimData"]["lenderName"]
                                          .toString()
                                      : ""),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Lender RM Name"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller
                                      .claimDetail
                                      .value["claimData"]
                                          ["loanAccountManagerName"]
                                      .toString()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Lender RM Number"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller
                                      .claimDetail
                                      .value["claimData"]
                                          ["accountManagerContactNumber"]
                                      .toString())
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Insurance Policy Details",
                                style: kBlack15Black.copyWith(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 15.0.h,
                              ),
                              smallText(text: "Insurer Name"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller.claimDetail
                                      .value["claimData"]["insurerName"]),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Borrower Policy Number"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller.claimDetail
                                      .value["claimData"]["policyNumber"]),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Master Policy Number"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller.claimDetail
                                      .value["claimData"]["masterPolNumber"]),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Policy Start Date"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text:
                                      controller.claimDetail.value["claimData"]
                                                  ["policyStartDate"] !=
                                              null
                                          ? dateChange(controller.claimDetail
                                                  .value["claimData"]
                                              ["policyStartDate"])
                                          : ""),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(
                                  text: "Policy Coverage Duration ( In Years)"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller
                                      .claimDetail
                                      .value["claimData"]
                                          ["policyCoverageDuration"]
                                      .toString()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Policy Sum Assured"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller.claimDetail
                                      .value["claimData"]["policySumAssured"]
                                      .toString()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Nominee Name"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller.claimDetail
                                      .value["claimData"]["nomineeName"]
                                      .toString()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Nominee Relationship"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller.claimDetail
                                      .value["claimData"]["nomineeRelationShip"]
                                      .toString()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Contact Number"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller
                                      .claimDetail
                                      .value["claimData"]
                                          ["nomineeContactNumber"]
                                      .toString()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Email Id"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller.claimDetail
                                      .value["claimData"]["nomineeEmailId"])
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // smallText(text: "Insurance Category"),
                                  // const SizedBox(
                                  //   height: 5.0,
                                  // ),
                                  // field(
                                  //     text: controller
                                  //         .claimDetail.value["claimCategory"]),
                                  // const SizedBox(
                                  //   height: 10.0,
                                  // ),

                                  isRemark == true
                                      ? Row(
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  textStyle: const TextStyle(
                                                      fontSize: 20)),
                                              onPressed: () {
                                                // isRemark =true;
                                                // setState(() {
                                                //
                                                // });
                                                // changeScreen();
                                              },
                                              child: Text("Upload Doc"),
                                            ),
                                            Spacer(),
                                            OutlinedButton(
                                              onPressed: () {
                                                // changeScreen();
                                                isRemark = false;
                                                setState(() {});
                                              },
                                              child: Text("Agent-Remark"),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                isRemark = true;
                                                controller
                                                    .agentRemarkDropDownValue
                                                    .value = "";
                                                controller.commentController
                                                    .value.text = "";
                                                setState(() {});
                                              },
                                              child: Text("Upload Doc"),
                                            ),
                                            Spacer(),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  textStyle: const TextStyle(
                                                      fontSize: 20)),
                                              onPressed: () {
                                                // isRemark =true;
                                                // setState(() {
                                                //
                                                // });
                                              },
                                              child: Text("Agent-Remark"),
                                            ),
                                          ],
                                        ),
                                  // Obx(
                                  //   () =>
                                  isRemark == true
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Documentation Upload",
                                              style: kBlack15Black
                                                  .copyWith(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 15.0.h,
                                            ),
                                            controller.claimDetail.value[
                                                            "claimCategory"] ==
                                                        "Life" ||
                                                    controller.claimDetail
                                                                .value[
                                                            "claimCategory"] ==
                                                        "life"
                                                ? Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      smallText(
                                                          text: controller.claimDetail
                                                                              .value[
                                                                          "claimCategory"] ==
                                                                      "Life" ||
                                                                  controller
                                                                          .claimDetail
                                                                          .value["claimCategory"] ==
                                                                      "life"
                                                              ? "Cause of Death (Life Insurance)"
                                                              : ""),
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      controller.claimDetail
                                                                          .value[
                                                                      "claimCategory"] ==
                                                                  "Life" ||
                                                              controller.claimDetail
                                                                          .value[
                                                                      "claimCategory"] ==
                                                                  "life"
                                                          ? Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade100,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              1.0),
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              kGrey)),
                                                              child: Obx(() =>
                                                                  DropdownButton<
                                                                      String>(
                                                                    isExpanded:
                                                                        true,
                                                                    hint:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: controller
                                                                              .causeofDeath
                                                                              .value
                                                                              .isNotEmpty
                                                                          ? Text(
                                                                              controller.causeofDeath.value,
                                                                              style: kBlack15Black.copyWith(fontSize: 14.0),
                                                                            )
                                                                          : Text(
                                                                              "Choose The Cause ",
                                                                              style: kBlack15Black.copyWith(fontSize: 14.0),
                                                                            ),
                                                                    ),
                                                                    underline:
                                                                        const SizedBox(),
                                                                    items: <
                                                                        String>[
                                                                      'Accident',
                                                                      'Natural Death',
                                                                      'Suicide',
                                                                      'Illness &  Medical Reason',
                                                                      'Dealth due to Natural Calamity',
                                                                      'OTHER'
                                                                    ].map((String
                                                                        value) {
                                                                      return DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            value,
                                                                        child: Text(
                                                                            value),
                                                                      );
                                                                    }).toList(),
                                                                    onChanged:
                                                                        (value) {
                                                                      controller
                                                                          .causeofDeath
                                                                          .value = value!;
                                                                    },
                                                                  )),
                                                            )
                                                          : SizedBox()
                                                    ],
                                                  )
                                                : SizedBox(),
                                            controller.claimDetail.value[
                                                            "claimCategory"] ==
                                                        "Health" ||
                                                    controller.claimDetail
                                                                .value[
                                                            "claimCategory"] ==
                                                        "health"
                                                ? Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),

                                                      smallText(
                                                          text: controller.claimDetail
                                                                              .value[
                                                                          "claimCategory"] ==
                                                                      "Health" ||
                                                                  controller
                                                                          .claimDetail
                                                                          .value["claimCategory"] ==
                                                                      "health"
                                                              ? "Claim Purpose (Health Insurance)"
                                                              : ""),
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),

                                                      controller.claimDetail
                                                                          .value[
                                                                      "claimCategory"] ==
                                                                  "Health" ||
                                                              controller.claimDetail
                                                                          .value[
                                                                      "claimCategory"] ==
                                                                  "health"
                                                          ? Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade100,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              1.0),
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              kGrey)),
                                                              child: Obx(() =>
                                                                  DropdownButton<
                                                                      String>(
                                                                    isExpanded:
                                                                        true,
                                                                    hint:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: controller
                                                                              .causeofDeath
                                                                              .value
                                                                              .isNotEmpty
                                                                          ? Text(
                                                                              controller.causeofDeath.value,
                                                                              style: kBlack15Black.copyWith(fontSize: 14.0),
                                                                            )
                                                                          : Text(
                                                                              "Choose Claim Purpose",
                                                                              style: kBlack15Black.copyWith(fontSize: 14.0),
                                                                            ),
                                                                    ),
                                                                    underline:
                                                                        const SizedBox(),
                                                                    items: <
                                                                        String>[
                                                                      'Accident',
                                                                      'Critical illness',
                                                                      'Loss of job',
                                                                      'Disability (Partial / Total)',
                                                                      'OTHER'
                                                                    ].map((String
                                                                        value) {
                                                                      return DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            value,
                                                                        child: Text(
                                                                            value),
                                                                      );
                                                                    }).toList(),
                                                                    onChanged:
                                                                        (value) {
                                                                      controller
                                                                          .causeofDeath
                                                                          .value = value!;
                                                                    },
                                                                  )),
                                                            )
                                                          : SizedBox(),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),

                                                      /// new
                                                    ],
                                                  )
                                                : SizedBox(),
                                            controller.claimDetail.value[
                                                            "claimCategory"] ==
                                                        "General" ||
                                                    controller.claimDetail
                                                                .value[
                                                            "claimCategory"] ==
                                                        "general"
                                                ? Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),

                                                      smallText(
                                                          text: controller.claimDetail
                                                                              .value[
                                                                          "claimCategory"] ==
                                                                      "General" ||
                                                                  controller
                                                                          .claimDetail
                                                                          .value["claimCategory"] ==
                                                                      "general"
                                                              ? "Claim Purpose (General Insurance)"
                                                              : ""),
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),

                                                      controller.claimDetail
                                                                          .value[
                                                                      "claimCategory"] ==
                                                                  "General" ||
                                                              controller.claimDetail
                                                                          .value[
                                                                      "claimCategory"] ==
                                                                  "general"
                                                          ? Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade100,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              1.0),
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              kGrey)),
                                                              child: Obx(() =>
                                                                  DropdownButton<
                                                                      String>(
                                                                    isExpanded:
                                                                        true,
                                                                    hint:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: controller
                                                                              .causeofDeath
                                                                              .value
                                                                              .isNotEmpty
                                                                          ? Text(
                                                                              controller.causeofDeath.value,
                                                                              style: kBlack15Black.copyWith(fontSize: 14.0),
                                                                            )
                                                                          : Text(
                                                                              "Choose Claim Purpose",
                                                                              style: kBlack15Black.copyWith(fontSize: 14.0),
                                                                            ),
                                                                    ),
                                                                    underline:
                                                                        const SizedBox(),
                                                                    items: <
                                                                        String>[
                                                                      'Accident',
                                                                      'Critical illness',
                                                                      'Loss of job',
                                                                      'Disability (Partial / Total)',
                                                                      'OTHER'
                                                                    ].map((String
                                                                        value) {
                                                                      return DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            value,
                                                                        child: Text(
                                                                            value),
                                                                      );
                                                                    }).toList(),
                                                                    onChanged:
                                                                        (value) {
                                                                      controller
                                                                          .causeofDeath
                                                                          .value = value!;
                                                                    },
                                                                  )),
                                                            )
                                                          : SizedBox(),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),

                                                      /// new
                                                    ],
                                                  )
                                                : SizedBox(),
                                            controller.claimDetail.value[
                                                                "claimData"]
                                                            ["claimCategory"] ==
                                                        "General" ||
                                                    controller.claimDetail
                                                                    .value[
                                                                "claimData"]
                                                            ["claimCategory"] ==
                                                        "general"
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(1.0),
                                                        border: Border.all(
                                                            color: kGrey)),
                                                    child: Obx(() =>
                                                        DropdownButton<String>(
                                                          isExpanded: true,
                                                          hint: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: controller
                                                                    .causeofDeath
                                                                    .value
                                                                    .isNotEmpty
                                                                ? Text(
                                                                    controller
                                                                        .causeofDeath
                                                                        .value,
                                                                    style: kBlack15Black
                                                                        .copyWith(
                                                                            fontSize:
                                                                                14.0),
                                                                  )
                                                                : Text(
                                                                    "Choose Claim Purpose",
                                                                    style: kBlack15Black
                                                                        .copyWith(
                                                                            fontSize:
                                                                                14.0),
                                                                  ),
                                                          ),
                                                          underline:
                                                              const SizedBox(),
                                                          items: <String>[
                                                            'Accident',
                                                            'Natural Death',
                                                            'Suicide',
                                                            'Illness &  Medical Reason',
                                                            'Dealth due to Natural Calamity',
                                                            'OTHER'
                                                          ].map((String value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                          onChanged: (value) {
                                                            controller
                                                                .causeofDeath
                                                                .value = value!;
                                                          },
                                                        )),
                                                  )
                                                : SizedBox(),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            smallText(text: "Is Nominee "),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            nominee(),
                                            Obx(() => controller
                                                        .nominee.value ==
                                                    "Minor"
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          "${controller.claimDetail.value["claimDocuments"][0]["relationshipDoc"].toString() == "UPLOADED" ? "Relationship Doc : ${controller.claimDetail.value["claimDocuments"][0]["relationshipDoc"].toString()} " : ""}",
                                                        style: TextStyle(
                                                          color:Colors.red,
                                                        ),),
                                                      Text(
                                                          "${controller.claimDetail.value["claimDocuments"][0]["guardianIdProof"].toString() == "UPLOADED" ? "Guardian Id Prooof : ${controller.claimDetail.value["claimDocuments"][0]["guardianIdProof"].toString()}" : ""}",
                                                        style: TextStyle(
                                                          color:Colors.red,
                                                        ),
                                                          ),
                                                      Text(
                                                          "${controller.claimDetail.value["claimDocuments"][0]["guardianAddressProof"].toString() == "UPLOADED" ? "Guardian Address Prooof : ${controller.claimDetail.value["claimDocuments"][0]["guardianAddressProof"].toString()}" : ""}",
                                                        style: TextStyle(
                                                          color:Colors.red,
                                                        ),
                                                          ),

                                                    ],
                                                  )
                                                : SizedBox()),
                                            Obx(() => controller
                                                        .nominee.value ==
                                                    "Minor"
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(1.0),
                                                        border: Border.all(
                                                            color: kGrey)),
                                                    child: Obx(() =>
                                                        DropdownButton<String>(
                                                          isExpanded: true,
                                                          hint: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: controller
                                                                    .minorDropdown
                                                                    .value
                                                                    .isNotEmpty
                                                                ? Text(
                                                                    controller
                                                                        .minorDropdown
                                                                        .value,
                                                                    style: kBlack15Black
                                                                        .copyWith(
                                                                            fontSize:
                                                                                14.0),
                                                                  )
                                                                : Text(
                                                                    "Select Document Type",
                                                                    style: kBlack15Black
                                                                        .copyWith(
                                                                            fontSize:
                                                                                14.0),
                                                                  ),
                                                          ),
                                                          underline:
                                                              const SizedBox(),
                                                          items: minorList.map(
                                                              (String value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                          onChanged: (value) {
                                                            controller
                                                                .minorDropdown
                                                                .value = value!;
                                                          },
                                                        )),
                                                  )
                                                : SizedBox()),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Obx(
                                                () =>
                                                    controller.nominee.value ==
                                                            "Minor"
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              smallText(
                                                                  text:
                                                                      "Additional Document for Minor"),
                                                              const SizedBox(
                                                                height: 10.0,
                                                              ),
                                                              Container(
                                                                height: 40.0.h,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade50,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              kGrey,
                                                                        )),
                                                                child: Row(
                                                                  children: [
                                                                    Flexible(
                                                                      fit: FlexFit
                                                                          .tight,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: Obx(() =>
                                                                            Text(
                                                                              "${controller.minorProofPath.value}",
                                                                              style: kBlack15Black.copyWith(fontWeight: FontWeight.w600, fontSize: 14.0),
                                                                            )),
                                                                      ),
                                                                    ),
                                                                    const Spacer(),
                                                                    MaterialButton(
                                                                      elevation:
                                                                          1.0,
                                                                      onPressed:
                                                                          () async {
                                                                        Get.defaultDialog(
                                                                            title: "Upload",
                                                                            titleStyle: kBlack15Black.copyWith(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                                                                            content: Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Divider(),
                                                                                GestureDetector(
                                                                                  onTap: () async {
                                                                                    if (controller.minorNominee.contains(controller.minorDropdown.value)) {
                                                                                      Fluttertoast.showToast(msg: "Record Already Exits for Selected Dropdown", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
                                                                                    } else {
                                                                                      var file = await controller.imageFromCamera();

                                                                                      if (controller.minorDropdown.value == "RELATIONSHIP_PROOF") {
                                                                                        controller.minorProof.value = basename(file);
                                                                                        controller.RelationProof.value = file;
                                                                                        Get.back(closeOverlays: true);
                                                                                        controller.addProductLot(selectedValue: controller.minorProof.value, imagePath: controller.RelationProof.value, dropDownValue: controller.minorDropdown.value);
                                                                                      } else if (controller.minorDropdown.value == "GUARDIAN_ID_PROOF") {
                                                                                        controller.minorProof.value = basename(file);
                                                                                        controller.GUARDIAN_ID_PROOF.value = file;
                                                                                        Get.back(closeOverlays: true);
                                                                                        controller.addProductLot(selectedValue: controller.minorProof.value, imagePath: controller.GUARDIAN_ID_PROOF.value, dropDownValue: controller.minorDropdown.value);
                                                                                      } else if (controller.minorDropdown.value == "GUARDIAN_ADD_PROOF") {
                                                                                        controller.minorProof.value = basename(file);
                                                                                        controller.GUARDIAN_ADD_PROOF.value = file;
                                                                                        Get.back(closeOverlays: true);
                                                                                        controller.addProductLot(selectedValue: controller.minorProof.value, imagePath: controller.GUARDIAN_ADD_PROOF.value, dropDownValue: controller.minorDropdown.value);
                                                                                      } else if (controller.minorDropdown.value == "Other Document") {
                                                                                        controller.minorProof.value = basename(file);
                                                                                        controller.minorProofPath.value = file;
                                                                                        Get.back(closeOverlays: true);
                                                                                        controller.addProductLot(selectedValue: controller.minorProof.value, imagePath: controller.minorProofPath.value, dropDownValue: controller.minorDropdown.value);
                                                                                      }
                                                                                    }
                                                                                  },
                                                                                  child: Text(
                                                                                    "Take Photo ...",
                                                                                    style: kBlack15Black.copyWith(color: kdarkBlue, fontWeight: FontWeight.w600, fontSize: 16.0),
                                                                                  ),
                                                                                ),
                                                                                Divider(),
                                                                                GestureDetector(
                                                                                  behavior: HitTestBehavior.opaque,
                                                                                  onTap: () async {
                                                                                    if (controller.minorNominee.contains(controller.minorDropdown.value)) {
                                                                                      Fluttertoast.showToast(msg: "Record Already Exits for Selected Dropdown", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
                                                                                    } else {
                                                                                      var file = await controller.uploadFile();

                                                                                      if (controller.minorDropdown.value == "RELATIONSHIP_PROOF") {
                                                                                        controller.minorProof.value = basename(file);
                                                                                        controller.RelationProof.value = file;
                                                                                        Get.back(closeOverlays: true);
                                                                                        controller.addProductLot(selectedValue: controller.minorProof.value, imagePath: controller.RelationProof.value, dropDownValue: controller.minorDropdown.value);
                                                                                      } else if (controller.minorDropdown.value == "GUARDIAN_ID_PROOF") {
                                                                                        controller.minorProof.value = basename(file);
                                                                                        controller.GUARDIAN_ID_PROOF.value = file;
                                                                                        Get.back(closeOverlays: true);
                                                                                        controller.addProductLot(selectedValue: controller.minorProof.value, imagePath: controller.GUARDIAN_ID_PROOF.value, dropDownValue: controller.minorDropdown.value);
                                                                                      } else if (controller.minorDropdown.value == "GUARDIAN_ADD_PROOF") {
                                                                                        controller.minorProof.value = basename(file);
                                                                                        controller.GUARDIAN_ADD_PROOF.value = file;
                                                                                        Get.back(closeOverlays: true);
                                                                                        controller.addProductLot(selectedValue: controller.minorProof.value, imagePath: controller.GUARDIAN_ADD_PROOF.value, dropDownValue: controller.minorDropdown.value);
                                                                                      } else if (controller.minorDropdown.value == "Other Document") {
                                                                                        controller.minorProof.value = basename(file);
                                                                                        controller.minorProofPath.value = file;
                                                                                        Get.back(closeOverlays: true);
                                                                                        controller.addProductLot(selectedValue: controller.minorProof.value, imagePath: controller.minorProofPath.value, dropDownValue: controller.minorDropdown.value);
                                                                                      }
                                                                                      Get.back(closeOverlays: true);
                                                                                      controller.addProductLot(imagePath: controller.minorProofPath.value, selectedValue: controller.minorProof.value, dropDownValue: controller.minorDropdown.value);
                                                                                    }
                                                                                  },
                                                                                  child: Text(
                                                                                    "Choose Files from Phone",
                                                                                    style: kBlack15Black.copyWith(color: kdarkBlue, fontWeight: FontWeight.w600, fontSize: 16.0),
                                                                                  ),
                                                                                ),
                                                                                Divider(),
                                                                              ],
                                                                            ),
                                                                            cancel: GestureDetector(
                                                                              onTap: () {
                                                                                log("**");
                                                                                Get.back(closeOverlays: true);
                                                                              },
                                                                              behavior: HitTestBehavior.opaque,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(
                                                                                  "Cancel",
                                                                                  style: kBlack15Black.copyWith(color: Colors.red, fontSize: 16),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            onCancel: () => Get.back());
                                                                        // }
                                                                      },
                                                                      shape: RoundedRectangleBorder(
                                                                          side: const BorderSide(
                                                                              color:
                                                                                  kGrey),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5.0)),
                                                                      color: Colors
                                                                          .white,
                                                                      child: Text(
                                                                          "Upload",
                                                                          style: kBlack15Black.copyWith(
                                                                              fontSize: 15.0,
                                                                              fontWeight: FontWeight.w400)),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : const SizedBox()),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: controller
                                                    .minorImage.length,
                                                itemBuilder:
                                                    (context, int index) {
                                                  return Obx(() => controller
                                                              .nominee
                                                              .value
                                                              .isNotEmpty ||
                                                          controller.nominee
                                                                  .value ==
                                                              "Minor"
                                                      ? Row(
                                                          children: [
                                                            GestureDetector(
                                                              child: Text(
                                                                "Preview",
                                                                style: kBlack15Black
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14.0,
                                                                        color:
                                                                            kdarkBlue,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                              ),
                                                              onTap: () =>
                                                                  Get.to(() =>
                                                                      PreviewScreen(
                                                                        filePath: controller
                                                                            .minorImage
                                                                            .value[index],
                                                                      )),
                                                            ),
                                                            const Spacer(),
                                                            GestureDetector(
                                                              onTap: () {
                                                                controller
                                                                    .minorProof
                                                                    .value = "";
                                                                controller
                                                                    .minorProofPath
                                                                    .value = "";
                                                                controller
                                                                    .minorImage
                                                                    .removeAt(
                                                                        index);
                                                                controller.minor
                                                                    .removeAt(
                                                                        index);
                                                                controller
                                                                    .minorNominee
                                                                    .removeAt(
                                                                        index);
                                                              },
                                                              child: const Icon(
                                                                Icons.delete,
                                                                color:
                                                                    klightBlue,
                                                                size: 20,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      : SizedBox());
                                                }),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              children: [
                                                smallText(
                                                    text:
                                                        "Filled & Signed Claim form"),
                                                Text(
                                                  " * ",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${controller.claimDetail.value["claimDocuments"][0]["singnedClaimDocument"].toString() == "UPLOADED" ? controller.claimDetail.value["claimDocuments"][0]["singnedClaimDocument"].toString() : ""}",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 40.0.h,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade50,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  border: Border.all(
                                                    color: kGrey,
                                                  )),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8,
                                                          vertical: 8),
                                                      child: Obx(() => Text(
                                                            "${controller.filled.value}",
                                                            style: kBlack15Black
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14.0),
                                                          )),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  MaterialButton(
                                                    elevation: 1.0,
                                                    onPressed: () async {
                                                      if (controller
                                                              .claimDetail
                                                              .value[
                                                                  "claimDocuments"]
                                                                  [0][
                                                                  "singnedClaimDocument"]
                                                              .toString() ==
                                                          "UPLOADED") {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Already Under Verification",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                      } else {
                                                        Get.defaultDialog(
                                                            title: "Upload",
                                                            titleStyle: kBlack15Black
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        20.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    var file =
                                                                        await controller
                                                                            .imageFromCamera();
                                                                    controller
                                                                            .filled
                                                                            .value =
                                                                        basename(
                                                                            file);
                                                                    controller
                                                                        .filledPath
                                                                        .value = file;
                                                                    Get.back(
                                                                        closeOverlays:
                                                                            true);
                                                                  },
                                                                  child: Text(
                                                                    "Take Photo ...",
                                                                    style: kBlack15Black.copyWith(
                                                                        color:
                                                                            kdarkBlue,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            16.0),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  behavior:
                                                                      HitTestBehavior
                                                                          .opaque,
                                                                  onTap:
                                                                      () async {
                                                                    await controller
                                                                        .uploadFile1();

                                                                    // var file =
                                                                    // await controller
                                                                    //     .uploadFile();
                                                                    // print(file);
                                                                    // controller
                                                                    //     .filled
                                                                    //     .value =
                                                                    //     basename(file);
                                                                    // controller
                                                                    //     .filled
                                                                    //     .value = file;
                                                                    //print(file);
                                                                    // controller.filled
                                                                    //         .value =
                                                                    //     basename(file);
                                                                    // controller.files = file;
                                                                    //
                                                                    // controller.signForm.addAll(
                                                                    //     {file});
                                                                    setState(
                                                                        () {});
                                                                    Get.back(
                                                                        closeOverlays:
                                                                            true);
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child: Text(
                                                                    "Choose Files from Phone",
                                                                    style: kBlack15Black.copyWith(
                                                                        color:
                                                                            kdarkBlue,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            16.0),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                              ],
                                                            ),
                                                            cancel:
                                                                GestureDetector(
                                                              onTap: () {
                                                                log("**");
                                                                Get.back(
                                                                    closeOverlays:
                                                                        true);
                                                              },
                                                              behavior:
                                                                  HitTestBehavior
                                                                      .opaque,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                  "Cancel",
                                                                  style: kBlack15Black
                                                                      .copyWith(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              16),
                                                                ),
                                                              ),
                                                            ),
                                                            onCancel: () =>
                                                                Get.back());
                                                      }
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            side:
                                                                const BorderSide(
                                                                    color:
                                                                        kGrey),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0)),
                                                    color: Colors.white,
                                                    child: Text("Upload",
                                                        style:kBlack15Black
                                                            .copyWith(
                                                                fontSize: 15.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10.0),
                                            controller.files1 != null
                                                ? ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: controller
                                                        .files1!.length,
                                                    itemBuilder:
                                                        (context, int index) {
                                                      return controller.files1!
                                                              .isNotEmpty
                                                          ? Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      GestureDetector(
                                                                          child:
                                                                              Text(
                                                                            "Preview",
                                                                            style: kBlack15Black.copyWith(
                                                                                fontSize: 14.0,
                                                                                color: kdarkBlue,
                                                                                fontWeight: FontWeight.w700),
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                            var filePathinPdf;

                                                                            String
                                                                                s =
                                                                                "${controller.files1![index].toString()}";
                                                                            int idx =
                                                                                s.indexOf(":");
                                                                            List
                                                                                parts =
                                                                                [
                                                                              s.substring(0, idx).trim(),
                                                                              s.substring(idx + 1).trim()
                                                                            ];
                                                                            var str =
                                                                                parts[1];
                                                                            var find =
                                                                                "'";
                                                                            var replaceWith =
                                                                                '';
                                                                            var newString =
                                                                                str.replaceAll(find, replaceWith);
                                                                            // var parts1 = str.split('${str[0]}');
                                                                            filePathinPdf =
                                                                                newString;
                                                                            Get.to(() =>
                                                                                PreviewScreen(
                                                                                  filePath: filePathinPdf,
                                                                                  // filePath:  controller
                                                                                  //     .deathCertificatePath
                                                                                  //     .value,
                                                                                ));
                                                                          }),
                                                                ),
                                                                const Spacer(),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    controller
                                                                        .files1!
                                                                        .removeAt(
                                                                            index);

                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color:
                                                                        klightBlue,
                                                                    size: 20,
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          : SizedBox();
                                                    })
                                                : SizedBox(),
                                            Obx(() => controller
                                                    .filledPath.value.isNotEmpty
                                                ? Row(
                                                    children: [
                                                      GestureDetector(
                                                        child: Text(
                                                          "Preview",
                                                          style: kBlack15Black
                                                              .copyWith(
                                                                  fontSize:
                                                                      14.0,
                                                                  color:
                                                                      kdarkBlue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                        onTap: () => Get.to(
                                                            () => PreviewScreen(
                                                                  filePath:
                                                                      controller
                                                                          .filledPath
                                                                          .value,
                                                                )),
                                                      ),
                                                      const Spacer(),
                                                      GestureDetector(
                                                        onTap: () {
                                                          controller.filled
                                                              .value = "";
                                                          controller.filledPath
                                                              .value = "";
                                                        },
                                                        child: const Icon(
                                                          Icons.delete,
                                                          color: klightBlue,
                                                          size: 20,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                : SizedBox()),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              children: [
                                                smallText(
                                                    text: "Death Certificate"),
                                                Text(
                                                  " * ",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${controller.claimDetail.value["claimDocuments"][0]["deathCertificate"].toString() == "UPLOADED" ? controller.claimDetail.value["claimDocuments"][0]["deathCertificate"].toString() : ""}",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Container(
                                              height: 40.0.h,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade50,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  border: Border.all(
                                                    color: kGrey,
                                                  )),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Obx(() => Text(
                                                            controller
                                                                .dealthCertificate
                                                                .value,
                                                            style:kBlack15Black
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14.0),
                                                          )),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  MaterialButton(
                                                    elevation: 1.0,
                                                    onPressed: () async {
                                                      if (controller
                                                              .claimDetail
                                                              .value[
                                                                  "claimDocuments"]
                                                                  [0][
                                                                  "deathCertificate"]
                                                              .toString() ==
                                                          "UPLOADED") {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Already Under Verification",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                      } else {
                                                        Get.defaultDialog(
                                                            title: "Upload",
                                                            titleStyle: kBlack15Black
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        20.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                const Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    var file =
                                                                        await controller
                                                                            .imageFromCamera();
                                                                    controller
                                                                            .dealthCertificate
                                                                            .value =
                                                                        basename(
                                                                            file);
                                                                    controller
                                                                        .deathCertificatePath
                                                                        .value = file;
                                                                    print(
                                                                        "object ${controller.deathCertificatePath.value}");
                                                                    Get.back(
                                                                        closeOverlays:
                                                                            true);
                                                                  },
                                                                  child: Text(
                                                                    "Take Photo ...",
                                                                    style: kBlack15Black.copyWith(
                                                                        color:
                                                                            kdarkBlue,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            16.0),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  behavior:
                                                                      HitTestBehavior
                                                                          .opaque,
                                                                  onTap:
                                                                      () async {
                                                                    await controller
                                                                        .uploadCertificate();
                                                                    setState(
                                                                        () {});
                                                                    Get.back(
                                                                        closeOverlays:
                                                                            true);
                                                                  },
                                                                  child: Text(
                                                                    "Choose Files from Phone",
                                                                    style: kBlack15Black.copyWith(
                                                                        color:
                                                                            kdarkBlue,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            16.0),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                              ],
                                                            ),
                                                            cancel:
                                                                GestureDetector(
                                                              onTap: () {
                                                                log("**");
                                                                Get.back(
                                                                    closeOverlays:
                                                                        true);
                                                              },
                                                              behavior:
                                                                  HitTestBehavior
                                                                      .opaque,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                  "Cancel",
                                                                  style: kBlack15Black
                                                                      .copyWith(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              16),
                                                                ),
                                                              ),
                                                            ),
                                                            onCancel: () =>
                                                                Get.back());
                                                      }
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            side:
                                                                const BorderSide(
                                                                    color:
                                                                        kGrey),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0)),
                                                    color: Colors.white,
                                                    child: Text("Upload",
                                                        style: kBlack15Black
                                                            .copyWith(
                                                                fontSize: 15.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10.0),
                                            controller.deathCertificate != null
                                                ? ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: controller
                                                        .deathCertificate!
                                                        .length,
                                                    itemBuilder:
                                                        (context, int index) {
                                                      return controller
                                                              .deathCertificate!
                                                              .isNotEmpty
                                                          ? Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      GestureDetector(
                                                                          child:
                                                                              Text(
                                                                            "Preview",
                                                                            style: kBlack15Black.copyWith(
                                                                                fontSize: 14.0,
                                                                                color: kdarkBlue,
                                                                                fontWeight: FontWeight.w700),
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                            var filePathinPdf;

                                                                            String
                                                                                s =
                                                                                "${controller.deathCertificate![index].toString()}";
                                                                            int idx =
                                                                                s.indexOf(":");
                                                                            List
                                                                                parts =
                                                                                [
                                                                              s.substring(0, idx).trim(),
                                                                              s.substring(idx + 1).trim()
                                                                            ];
                                                                            var str =
                                                                                parts[1];
                                                                            var find =
                                                                                "'";
                                                                            var replaceWith =
                                                                                '';
                                                                            var newString =
                                                                                str.replaceAll(find, replaceWith);
                                                                            // var parts1 =
                                                                            // str.split(
                                                                            //     '${str[0]}');
                                                                            filePathinPdf =
                                                                                newString;
                                                                            Get.to(() =>
                                                                                PreviewScreen(
                                                                                  filePath: filePathinPdf,
                                                                                  // filePath:  controller
                                                                                  //     .deathCertificatePath
                                                                                  //     .value,
                                                                                ));
                                                                          }),
                                                                ),
                                                                const Spacer(),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    controller
                                                                        .deathCertificate!
                                                                        .removeAt(
                                                                            index);

                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color:
                                                                        klightBlue,
                                                                    size: 20,
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          : SizedBox();
                                                    })
                                                : SizedBox(),
                                            Obx(() => controller
                                                    .deathCertificatePath
                                                    .value
                                                    .isNotEmpty
                                                ? Row(
                                                    children: [
                                                      GestureDetector(
                                                        child: Text(
                                                          "Preview",
                                                          style: kBlack15Black
                                                              .copyWith(
                                                                  fontSize:
                                                                      14.0,
                                                                  color:
                                                                      kdarkBlue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                        onTap: () => Get.to(
                                                            () => PreviewScreen(
                                                                  filePath:
                                                                      controller
                                                                          .deathCertificatePath
                                                                          .value,
                                                                )),
                                                      ),
                                                      const Spacer(),
                                                      GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .dealthCertificate
                                                              .value = "";
                                                          controller
                                                              .deathCertificatePath
                                                              .value = "";
                                                        },
                                                        child: const Icon(
                                                          Icons.delete,
                                                          color: klightBlue,
                                                          size: 20,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                : SizedBox()),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              "KYC - Proof Borrower",
                                              style: kBlack15Black
                                                  .copyWith(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              children: [
                                                smallText(text: "Id Proof"),
                                                Text(
                                                  " * ",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )
                                              ],
                                            ),
                                            smallText(
                                                text:
                                                    "(atleast one document is mandatory)"),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                    "${controller.claimDetail.value["claimDocuments"][0]["borrowerKycProof"].toString() == "UPLOADED" ? controller.claimDetail.value["claimDocuments"][0]["borrowerKycProof"].toString() : ""}",
                                                  style: TextStyle(
                                                    color:Colors.red,
                                                  ),
                                                    ),
                                              ],
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1.0),
                                                  border:
                                                      Border.all(color: kGrey)),
                                              child: Obx(() =>
                                                  DropdownButton<String>(
                                                    isExpanded: true,
                                                    hint: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: controller
                                                              .borroweridProof
                                                              .value
                                                              .isNotEmpty
                                                          ? Text(
                                                              controller
                                                                  .borroweridProof
                                                                  .value,
                                                              style: kBlack15Black
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14.0),
                                                            )
                                                          : Text(
                                                              "Select Document Type",
                                                              style: kBlack15Black
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14.0),
                                                            ),
                                                    ),
                                                    underline: const SizedBox(),
                                                    items: <String>[
                                                      'Aadhar Card',
                                                      'Passport',
                                                      'Voter card',
                                                      'Driving License',
                                                      "Ration Card ",
                                                      'Pan Card',
                                                      'Any other Govt Id card ',
                                                      'Other',
                                                    ].map((String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      controller.borroweridProof
                                                          .value = value!;
                                                    },
                                                  )),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Container(
                                              height: 40.0.h,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade50,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  border: Border.all(
                                                    color: kGrey,
                                                  )),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Obx(() => Text(
                                                            "${controller.borroweridProofDoc.value}",
                                                            style: kBlack15Black
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14.0),
                                                          )),
                                                    ),
                                                    fit: FlexFit.tight,
                                                  ),
                                                  const Spacer(),
                                                  MaterialButton(
                                                    elevation: 1.0,
                                                    onPressed: () async {
                                                      if (controller
                                                              .claimDetail
                                                              .value[
                                                                  "claimDocuments"]
                                                                  [0][
                                                                  "borrowerKycProof"]
                                                              .toString() ==
                                                          "UPLOADED") {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Already Under Verification",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                      } else {
                                                        Get.defaultDialog(
                                                            title: "Upload",
                                                            titleStyle: kBlack15Black
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        20.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    var file =
                                                                        await controller
                                                                            .imageFromCamera();
                                                                    print(file);
                                                                    controller
                                                                            .borroweridProofDoc
                                                                            .value =
                                                                        basename(
                                                                            file);
                                                                    controller
                                                                        .borrowerIdDocPath
                                                                        .value = file;
                                                                    Get.back(
                                                                        closeOverlays:
                                                                            true);
                                                                  },
                                                                  child: Text(
                                                                    "Take Photo ...",
                                                                    style: kBlack15Black.copyWith(
                                                                        color:
                                                                            kdarkBlue,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            16.0),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                                GestureDetector(
                                                                  behavior:
                                                                      HitTestBehavior
                                                                          .opaque,
                                                                  onTap:
                                                                      () async {

                                                                    await controller
                                                                        .uploadBorrowerProof();
                                                                    setState(
                                                                        () {});
                                                                    Get.back(
                                                                        closeOverlays:
                                                                            true);
                                                                  },
                                                                  child: Text(
                                                                    "Choose Files from Phone",
                                                                    style: kBlack15Black.copyWith(
                                                                        color:
                                                                            kdarkBlue,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            16.0),
                                                                  ),
                                                                ),
                                                                Divider(),
                                                              ],
                                                            ),
                                                            cancel:
                                                                GestureDetector(
                                                              onTap: () {
                                                                Get.back(
                                                                    closeOverlays:
                                                                        true);
                                                              },
                                                              behavior:
                                                                  HitTestBehavior
                                                                      .opaque,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                  "Cancel",
                                                                  style: kBlack15Black
                                                                      .copyWith(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              16),
                                                                ),
                                                              ),
                                                            ),
                                                            onCancel: () =>
                                                                Get.back());
                                                      }
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            side:
                                                                const BorderSide(
                                                                    color:
                                                                        kGrey),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0)),
                                                    color: Colors.white,
                                                    child: Text("Upload",
                                                        style: kBlack15Black
                                                            .copyWith(
                                                                fontSize: 15.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10.0),
                                            controller.borrowerProof != null
                                                ? ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: controller
                                                        .borrowerProof!.length,
                                                    itemBuilder:
                                                        (context, int index) {
                                                      return controller
                                                              .borrowerProof!
                                                              .isNotEmpty
                                                          ? Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      GestureDetector(
                                                                          child:
                                                                              Text(
                                                                            "Preview",
                                                                            style: kBlack15Black.copyWith(
                                                                                fontSize: 14.0,
                                                                                color: kdarkBlue,
                                                                                fontWeight: FontWeight.w700),
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                            var filePathinPdf;

                                                                            String
                                                                                s =
                                                                                "${controller.borrowerProof![index].toString()}";
                                                                            int idx =
                                                                                s.indexOf(":");
                                                                            List
                                                                                parts =
                                                                                [
                                                                              s.substring(0, idx).trim(),
                                                                              s.substring(idx + 1).trim()
                                                                            ];
                                                                            var str =
                                                                                parts[1];
                                                                            var find =
                                                                                "'";
                                                                            var replaceWith =
                                                                                '';
                                                                            var newString =
                                                                                str.replaceAll(find, replaceWith);
                                                                            // var parts1 =
                                                                            // str.split(
                                                                            //     '${str[0]}');
                                                                            filePathinPdf =
                                                                                newString;
                                                                            Get.to(() =>
                                                                                PreviewScreen(
                                                                                  filePath: filePathinPdf,
                                                                                  // filePath:  controller
                                                                                  //     .deathCertificatePath
                                                                                  //     .value,
                                                                                ));
                                                                          }),
                                                                ),
                                                                const Spacer(),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    controller
                                                                        .borrowerProof!
                                                                        .removeAt(
                                                                            index);

                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color:
                                                                        klightBlue,
                                                                    size: 20,
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          : SizedBox();
                                                    })
                                                : SizedBox(),
                                            Obx(() => controller
                                                    .borrowerIdDocPath
                                                    .value
                                                    .isNotEmpty
                                                ? Row(
                                                    children: [
                                                      GestureDetector(
                                                        child: Text(
                                                          "Preview",
                                                          style: kBlack15Black
                                                              .copyWith(
                                                                  fontSize:
                                                                      14.0,
                                                                  color:
                                                                      kdarkBlue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                        onTap: () => Get.to(
                                                            () => PreviewScreen(
                                                                  filePath:
                                                                      controller
                                                                          .borrowerIdDocPath
                                                                          .value,
                                                                )),
                                                      ),
                                                      const Spacer(),
                                                      GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .borroweridProofDoc
                                                              .value = "";
                                                          controller
                                                              .borrowerIdDocPath
                                                              .value = "";
                                                        },
                                                        child: const Icon(
                                                          Icons.delete,
                                                          color: klightBlue,
                                                          size: 20,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                : SizedBox()),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            Text(
                                              "Agent - Remarks",
                                              style: kBlack15Black
                                                  .copyWith(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            smallText(
                                                text: "Choose a valid reason"),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1.0),
                                                  border:
                                                      Border.all(color: kGrey)),
                                              child: Obx(() =>
                                                  DropdownButton<String>(
                                                    isExpanded: true,
                                                    hint: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: controller
                                                              .agentRemarkDropDownValue
                                                              .value
                                                              .isNotEmpty
                                                          ? Text(
                                                              controller
                                                                  .agentRemarkDropDownValue
                                                                  .value,
                                                              style: kBlack15Black
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14.0),
                                                            )
                                                          : Text(
                                                              "Select valid reason",
                                                              style: kBlack15Black
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14.0),
                                                            ),
                                                    ),
                                                    underline: const SizedBox(),
                                                    items: <String>[
                                                      'Mobile number not reachable',
                                                      'Address is not correct',
                                                      'Client not available',
                                                      'Document not available',
                                                      'other'
                                                    ].map((String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      controller
                                                          .agentRemarkDropDownValue
                                                          .value = value!;
                                                    },
                                                  )),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Obx(
                                              () => controller
                                                          .agentRemarkDropDownValue
                                                          .value !=
                                                      null
                                                  ? MaterialButton(
                                                      onPressed: () {
                                                        controller
                                                            .agentRemarkDropDownValue
                                                            .value = "";
                                                      },
                                                      color: kdarkBlue,
                                                      child: Text(
                                                        "Remove Agent Remark",
                                                        style: 
                                                            kBlack15Black
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            smallText(text: "comment box"),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            CustomCommentField(
                                              controller: controller
                                                  .commentController.value,
                                              hint: "comment here",
                                            ),
                                          ],
                                        ),
                                  // ),

                                  ///new changes by sangam
                                  const SizedBox(
                                    height: 40.0,
                                  ),

                                  Center(
                                    child: MaterialButton(
                                      onPressed: () {
                                        if (controller.claimDetail
                                                        .value["claimData"]
                                                    ["causeOfDeath"] !=
                                                null &&
                                            (controller.claimDetail
                                                        .value["claimData"]
                                                    ["causeOfDeath"] ==
                                                controller
                                                    .causeofDeath.value)) {
                                          controller.causeofDeath.value =
                                              controller.claimDetail
                                                      .value["claimData"]
                                                  ["causeOfDeath"];
                                          if (controller
                                                  .claimDetail
                                                  .value["claimData"]
                                                      ["isForwardToVerifier"]
                                                  .toString() ==
                                              "true") {
                                            Fluttertoast.showToast(
                                                msg: "Already send to Verifier",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          } else {
                                            controller.uploadFormData();
                                          }
                                        }
                                        else if (controller
                                            .agentRemarkDropDownValue
                                            .value
                                            .isNotEmpty) {
                                          controller.uploadFormData();
                                        } else if (controller
                                                .claimDetail
                                                .value["claimData"]
                                                    ["isForwardToVerifier"]
                                                .toString() ==
                                            "true") {
                                          Fluttertoast.showToast(
                                              msg: "Already send to Verifier",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        } else {
                                          controller.uploadFormData();
                                        }

                                        //  }
                                      },
                                      color: kdarkBlue,
                                      child: Text(
                                        "Save ",
                                        style: kBlack15Black
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                              Divider(),
                              const SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "KYC - Proof Nominee",
                                style: kBlack15Black.copyWith(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  smallText(text: "Id Proof"),
                                  Text(
                                    " * ",
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                              smallText(
                                  text: "(atleast one document is mandatory)"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                 mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                      "${controller.claimDetail.value["claimDocuments"][0]["nomineeKycProof"].toString() == "UPLOADED" ? controller.claimDetail.value["claimDocuments"][0]["nomineeKycProof"].toString() : ""}",
                                    style: TextStyle(
                                      color:Colors.red,
                                    ),
                                      ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(1.0),
                                    border: Border.all(color: kGrey)),
                                child: Obx(() => DropdownButton<String>(
                                      isExpanded: true,
                                      hint: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: controller
                                                .nomineeIdProof.value.isNotEmpty
                                            ? Text(
                                                controller.nomineeIdProof.value,
                                                style: kBlack15Black
                                                    .copyWith(fontSize: 14.0),
                                              )
                                            : Text(
                                                "Select Document Type",
                                                style: kBlack15Black
                                                    .copyWith(fontSize: 14.0),
                                              ),
                                      ),
                                      underline: const SizedBox(),
                                      items: <String>[
                                        'Aadhar Card',
                                        'Passport',
                                        'Voter card',
                                        'Driving License',
                                        "Ration Card ",
                                        'Pan Card',
                                        'Any other Govt Id card ',
                                        'Other',
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.nomineeIdProof.value =
                                            value!;
                                      },
                                    )),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                height: 40.0.h,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                      color: kGrey,
                                    )),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Obx(() => Text(
                                              "${controller.nomineeIdProofDoc.value}",
                                              style: kBlack15Black
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14.0),
                                            )),
                                      ),
                                      fit: FlexFit.tight,
                                    ),
                                    const Spacer(),
                                    MaterialButton(
                                      elevation: 1.0,
                                      onPressed: () async {
                                        if (controller
                                                .claimDetail
                                                .value["claimDocuments"][0]
                                                    ["nomineeKycProof"]
                                                .toString() ==
                                            "UPLOADED") {
                                          Fluttertoast.showToast(
                                              msg: "Already Under Verification",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        } else {
                                          Get.defaultDialog(
                                              title: "Upload",
                                              titleStyle: 
                                                  kBlack15Black
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Divider(),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      var file = await controller
                                                          .imageFromCamera();
                                                      print(file);
                                                      controller
                                                              .nomineeIdProofDoc
                                                              .value =
                                                          basename(file);
                                                      controller
                                                          .nomineeIdDocPath
                                                          .value = file;
                                                      Get.back(
                                                          closeOverlays: true);
                                                    },
                                                    child: Text(
                                                      "Take Photo ...",
                                                      style: 
                                                          kBlack15Black
                                                          .copyWith(
                                                              color: kdarkBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16.0),
                                                    ),
                                                  ),
                                                  Divider(),
                                                  GestureDetector(
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    onTap: () async {
                                                      // var file =
                                                      //     await controller
                                                      //         .uploadFile();
                                                      // print(file);
                                                      // controller
                                                      //         .nomineeIdProofDoc
                                                      //         .value =
                                                      //     basename(file);
                                                      // controller
                                                      //     .nomineeIdDocPath
                                                      //     .value = file;

                                                      await controller
                                                          .uploadNomineeProof();
                                                      setState(() {});
                                                      Get.back(
                                                          closeOverlays: true);
                                                    },
                                                    child: Text(
                                                      "Choose Files from Phone",
                                                      style: 
                                                          kBlack15Black
                                                          .copyWith(
                                                              color: kdarkBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16.0),
                                                    ),
                                                  ),
                                                  Divider(),
                                                ],
                                              ),
                                              cancel: GestureDetector(
                                                onTap: () {
                                                  log("**");
                                                  Get.back(closeOverlays: true);
                                                },
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Cancel",
                                                    style: 
                                                        kBlack15Black
                                                        .copyWith(
                                                            color: Colors.red,
                                                            fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                              onCancel: () => Get.back());
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: kGrey),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      color: Colors.white,
                                      child: Text("Upload",
                                          style: kBlack15Black
                                              .copyWith(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w400)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              controller.nomineeProof != null
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          controller.nomineeProof!.length,
                                      itemBuilder: (context, int index) {
                                        return controller
                                                .nomineeProof!.isNotEmpty
                                            ? Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                        child: Text(
                                                          "Preview",
                                                          style: 
                                                              kBlack15Black
                                                              .copyWith(
                                                                  fontSize:
                                                                      14.0,
                                                                  color:
                                                                      kdarkBlue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                        onTap: () {
                                                          var filePathinPdf;

                                                          String s =
                                                              "${controller.nomineeProof![index].toString()}";
                                                          int idx =
                                                              s.indexOf(":");
                                                          List parts = [
                                                            s
                                                                .substring(
                                                                    0, idx)
                                                                .trim(),
                                                            s
                                                                .substring(
                                                                    idx + 1)
                                                                .trim()
                                                          ];
                                                          var str = parts[1];
                                                          var find = "'";
                                                          var replaceWith = '';
                                                          var newString =
                                                              str.replaceAll(
                                                                  find,
                                                                  replaceWith);
                                                          // var parts1 =
                                                          //     str.split(
                                                          //         '${str[0]}');
                                                          filePathinPdf =
                                                              newString;
                                                          Get.to(() =>
                                                              PreviewScreen(
                                                                filePath:
                                                                    filePathinPdf,
                                                                // filePath:  controller
                                                                //     .deathCertificatePath
                                                                //     .value,
                                                              ));
                                                        }),
                                                  ),
                                                  const Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller.nomineeProof!
                                                          .removeAt(index);

                                                      setState(() {});
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: klightBlue,
                                                      size: 20,
                                                    ),
                                                  )
                                                ],
                                              )
                                            : SizedBox();
                                      })
                                  : SizedBox(),

                              Obx(() => controller
                                      .nomineeIdDocPath.value.isNotEmpty
                                  ? Row(
                                      children: [
                                        GestureDetector(
                                          child: Text(
                                            "Preview",
                                            style: kBlack15Black
                                                .copyWith(
                                                    fontSize: 14.0,
                                                    color: kdarkBlue,
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                          onTap: () =>
                                              Get.to(() => PreviewScreen(
                                                    filePath: controller
                                                        .nomineeIdDocPath.value,
                                                  )),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            controller.nomineeIdProofDoc.value =
                                                "";
                                            controller.nomineeIdDocPath.value =
                                                "";
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: klightBlue,
                                            size: 20,
                                          ),
                                        )
                                      ],
                                    )
                                  : SizedBox()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  smallText(text: "Bank A/C Proof"),
                                  const Text(
                                    " * ",
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                              smallText(
                                  text: "(atleast one  document is mandatory)"),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                      "${controller.claimDetail.value["claimDocuments"][0]["bankAccountProof"].toString() == "UPLOADED" ? controller.claimDetail.value["claimDocuments"][0]["bankAccountProof"].toString() : ""}",
                                    style: TextStyle(
                                      color:Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(1.0),
                                    border: Border.all(color: kGrey)),
                                child: Obx(() => DropdownButton<String>(
                                      isExpanded: true,
                                      hint: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: controller
                                                .bankProof.value.isNotEmpty
                                            ? Text(
                                                controller.bankProof.value,
                                                style: kBlack15Black
                                                    .copyWith(fontSize: 14.0),
                                              )
                                            : Text(
                                                "Select Document Type",
                                                style: kBlack15Black
                                                    .copyWith(fontSize: 14.0),
                                              ),
                                      ),
                                      underline: const SizedBox(),
                                      items: <String>[
                                        'Bank account cheque leaf',
                                        'NEFT Form',
                                        'Bank pass book',
                                        'Bank account statement',
                                        'Other Document',
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.bankProof.value = value!;
                                      },
                                    )),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                height: 40.0.h,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                      color: kGrey,
                                    )),
                                child: Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Obx(() => Text(
                                              "${controller.bankProofDoc.value}",
                                              style: kBlack15Black
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14.0),
                                            )),
                                      ),
                                    ),
                                    const Spacer(),
                                    MaterialButton(
                                      elevation: 1.0,
                                      onPressed: () async {
                                        if (controller
                                                .claimDetail
                                                .value["claimDocuments"][0]
                                                    ["bankAccountProof"]
                                                .toString() ==
                                            "UPLOADED") {
                                          Fluttertoast.showToast(
                                              msg: "Already Under Verification",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        } else {
                                          Get.defaultDialog(
                                              title: "Upload",
                                              titleStyle: 
                                                  kBlack15Black
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Divider(),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      var file = await controller
                                                          .imageFromCamera();
                                                      print(file);
                                                      controller
                                                              .nomineeIdProofDoc
                                                              .value =
                                                          basename(file);
                                                      controller
                                                          .nomineeIdDocPath
                                                          .value = file;
                                                      Get.back(
                                                          closeOverlays: true);
                                                    },
                                                    child: Text(
                                                      "Take Photo ...",
                                                      style: 
                                                          kBlack15Black
                                                          .copyWith(
                                                              color: kdarkBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16.0),
                                                    ),
                                                  ),
                                                  Divider(),
                                                  GestureDetector(
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    onTap: () async {
                                                      // var file =
                                                      // await controller.uploadFile();
                                                      // print(file);
                                                      // controller.bankProofDoc.value =
                                                      //     basename(file);
                                                      // controller.bankAccountDocPath.value =
                                                      //     file;

                                                      await controller
                                                          .uploadBankProof();
                                                      setState(() {});
                                                      Get.back(
                                                          closeOverlays: true);
                                                    },
                                                    child: Text(
                                                      "Choose Files from Phone",
                                                      style: 
                                                          kBlack15Black
                                                          .copyWith(
                                                              color: kdarkBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16.0),
                                                    ),
                                                  ),
                                                  Divider(),
                                                ],
                                              ),
                                              cancel: GestureDetector(
                                                onTap: () {
                                                  log("**");
                                                  Get.back(closeOverlays: true);
                                                },
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Cancel",
                                                    style: 
                                                        kBlack15Black
                                                        .copyWith(
                                                            color: Colors.red,
                                                            fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                              onCancel: () => Get.back());
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: kGrey),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      color: Colors.white,
                                      child: Text("Upload",
                                          style: kBlack15Black
                                              .copyWith(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w400)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              controller.bankACProof != null
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: controller.bankACProof!.length,
                                      itemBuilder: (context, int index) {
                                        return controller
                                                .bankACProof!.isNotEmpty
                                            ? Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                        child: Text(
                                                          "Preview",
                                                          style: 
                                                              kBlack15Black
                                                              .copyWith(
                                                                  fontSize:
                                                                      14.0,
                                                                  color:
                                                                      kdarkBlue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                        onTap: () {
                                                          var filePathinPdf;

                                                          String s =
                                                              "${controller.bankACProof![index].toString()}";
                                                          int idx =
                                                              s.indexOf(":");
                                                          List parts = [
                                                            s
                                                                .substring(
                                                                    0, idx)
                                                                .trim(),
                                                            s
                                                                .substring(
                                                                    idx + 1)
                                                                .trim()
                                                          ];
                                                          var str = parts[1];
                                                          var find = "'";
                                                          var replaceWith = '';
                                                          var newString =
                                                              str.replaceAll(
                                                                  find,
                                                                  replaceWith);
                                                          // var parts1 =
                                                          //     str.split(
                                                          //         '${str[0]}');
                                                          filePathinPdf =
                                                              newString;
                                                          Get.to(() =>
                                                              PreviewScreen(
                                                                filePath:
                                                                    filePathinPdf,
                                                                // filePath:  controller
                                                                //     .deathCertificatePath
                                                                //     .value,
                                                              ));
                                                        }),
                                                  ),
                                                  const Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller.bankACProof!
                                                          .removeAt(index);

                                                      setState(() {});
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: klightBlue,
                                                      size: 20,
                                                    ),
                                                  )
                                                ],
                                              )
                                            : SizedBox();
                                      })
                                  : SizedBox(),

                              Obx(() =>
                                  controller.bankAccountDocPath.value.isNotEmpty
                                      ? Row(
                                          children: [
                                            GestureDetector(
                                              child: Text(
                                                "Preview",
                                                style: kBlack15Black
                                                    .copyWith(
                                                        fontSize: 14.0,
                                                        color: kdarkBlue,
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                              onTap: () =>
                                                  Get.to(() => PreviewScreen(
                                                        filePath: controller
                                                            .bankAccountDocPath
                                                            .value,
                                                      )),
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                controller.bankProofDoc.value =
                                                    "";
                                                controller.bankAccountDocPath
                                                    .value = "";
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: klightBlue,
                                                size: 20,
                                              ),
                                            )
                                          ],
                                        )
                                      : SizedBox()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Additional Document"),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(
                                  text:
                                      "Document Required for ${controller.claimDetail.value["claimData"]["causeOfDeath"] != null ? controller.claimDetail.value["claimData"]["causeOfDeath"] : ""}"),
                              const SizedBox(
                                height: 10.0,
                              ),
                              if ((controller.claimDetail.value["claimData"]
                                              ["causeOfDeath"] ==
                                          "ACCIDENT" ||
                                      controller.claimDetail.value["claimData"]
                                              ["causeOfDeath"] ==
                                          "NATURAL_DEATH" ||
                                      controller.claimDetail.value["claimData"]
                                              ["causeOfDeath"] ==
                                          "SUICIDE") &&
                                  (controller.claimDetail
                                              .value["claimCategory"] ==
                                          "Life" ||
                                      controller.claimDetail
                                              .value["claimCategory"] ==
                                          "life"))
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(1.0),
                                      border: Border.all(color: kGrey)),
                                  child: Obx(() => DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: controller.additionalProof
                                                  .value.isNotEmpty
                                              ? Text(
                                                  controller
                                                      .additionalProof.value,
                                                  style: 
                                                      kBlack15Black
                                                      .copyWith(fontSize: 14.0),
                                                )
                                              : Text(
                                                  "Select Document Type",
                                                  style: 
                                                      kBlack15Black
                                                      .copyWith(fontSize: 14.0),
                                                ),
                                        ),
                                        underline: const SizedBox(),
                                        items: accientList.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          controller.additionalProof.value =
                                              value!;
                                        },
                                      )),
                                ),
                              if ((controller.claimDetail.value["claimData"]
                                              ["causeOfDeath"] ==
                                          "ILLNESS_MEDICAL_REASON" ||
                                      controller.claimDetail.value["claimData"]
                                              ["causeOfDeath"] ==
                                          "DUE_TO_NATURAL_CALAMITY") &&
                                  (controller.claimDetail
                                              .value["claimCategory"] ==
                                          "Life" ||
                                      controller.claimDetail
                                              .value["claimCategory"] ==
                                          "life"))
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(1.0),
                                      border: Border.all(color: kGrey)),
                                  child: Obx(() => DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: controller.additionalProof
                                                  .value.isNotEmpty
                                              ? Text(
                                                  controller
                                                      .additionalProof.value,
                                                  style: 
                                                      kBlack15Black
                                                      .copyWith(fontSize: 14.0),
                                                )
                                              : Text(
                                                  "Select Document Type",
                                                  style: 
                                                      kBlack15Black
                                                      .copyWith(fontSize: 14.0),
                                                ),
                                        ),
                                        underline: const SizedBox(),
                                        items: sickList.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          controller.additionalProof.value =
                                              value!;
                                        },
                                      )),
                                ),
                              if (controller.claimDetail
                                      .value["claimData"]["causeOfDeath"]
                                      .toString()
                                      .isNotEmpty &&
                                  (controller.claimDetail
                                              .value["claimCategory"] ==
                                          "General" ||
                                      controller.claimDetail
                                              .value["claimCategory"] ==
                                          "general" ||
                                      controller.claimDetail
                                              .value["claimCategory"] ==
                                          "Health" ||
                                      controller.claimDetail
                                              .value["claimCategory"] ==
                                          "health" ||
                                      controller.claimDetail.value["claimData"]
                                              ["causeOfDeath"] ==
                                          "DUE_TO_NATURAL_CALAMITY"))
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(1.0),
                                      border: Border.all(color: kGrey)),
                                  child: Obx(() => DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: controller.additionalProof
                                                  .value.isNotEmpty
                                              ? Text(
                                                  controller
                                                      .additionalProof.value,
                                                  style: 
                                                      kBlack15Black
                                                      .copyWith(fontSize: 14.0),
                                                )
                                              : Text(
                                                  "Select Document Type",
                                                  style: 
                                                      kBlack15Black
                                                      .copyWith(fontSize: 14.0),
                                                ),
                                        ),
                                        underline: const SizedBox(),
                                        items: other.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          controller.additionalProof.value =
                                              value!;
                                        },
                                      )),
                                ),
                              // if (controller.claimDetail.value["claimData"]
                              //             ["causeOfDeath"] ==
                              //         "ACCIDENT" ||
                              //     controller.claimDetail.value["claimData"]
                              //             ["causeOfDeath"] ==
                              //         "NATURAL_DEATH" ||
                              //     controller.claimDetail.value["claimData"]
                              //             ["causeOfDeath"] ==
                              //         "SUICIDE")
                              //   Container(
                              //     decoration: BoxDecoration(
                              //         color: Colors.grey.shade100,
                              //         borderRadius: BorderRadius.circular(1.0),
                              //         border: Border.all(color: kGrey)),
                              //     child: Obx(() => DropdownButton<String>(
                              //           isExpanded: true,
                              //           hint: Padding(
                              //             padding: const EdgeInsets.all(8.0),
                              //             child: controller.additionalProof
                              //                     .value.isNotEmpty
                              //                 ? Text(
                              //                     controller
                              //                         .additionalProof.value,
                              //                     style: 
                              //                         kBlack15Black
                              //                         .copyWith(fontSize: 14.0),
                              //                   )
                              //                 : Text(
                              //                     "Select Document Type",
                              //                     style: 
                              //                         kBlack15Black
                              //                         .copyWith(fontSize: 14.0),
                              //                   ),
                              //           ),
                              //           underline: const SizedBox(),
                              //           items: accientList.map((String value) {
                              //             return DropdownMenuItem<String>(
                              //               value: value,
                              //               child: Text(value),
                              //             );
                              //           }).toList(),
                              //           onChanged: (value) {
                              //             controller.additionalProof.value =
                              //                 value!;
                              //           },
                              //         )),
                              //   ),
                              // if (controller.claimDetail.value["claimData"]
                              //             ["causeOfDeath"] ==
                              //         "ILLNESS_MEDICAL_REASON" ||
                              //     controller.claimDetail.value["claimData"]
                              //             ["causeOfDeath"] ==
                              //         "DUE_TO_NATURAL_CALAMITY")
                              //   Container(
                              //     decoration: BoxDecoration(
                              //         color: Colors.grey.shade100,
                              //         borderRadius: BorderRadius.circular(1.0),
                              //         border: Border.all(color: kGrey)),
                              //     child: Obx(() => DropdownButton<String>(
                              //           isExpanded: true,
                              //           hint: Padding(
                              //             padding: const EdgeInsets.all(8.0),
                              //             child: controller.additionalProof
                              //                     .value.isNotEmpty
                              //                 ? Text(
                              //                     controller
                              //                         .additionalProof.value,
                              //                     style: 
                              //                         kBlack15Black
                              //                         .copyWith(fontSize: 14.0),
                              //                   )
                              //                 : Text(
                              //                     "Select Document Type",
                              //                     style: 
                              //                         kBlack15Black
                              //                         .copyWith(fontSize: 14.0),
                              //                   ),
                              //           ),
                              //           underline: const SizedBox(),
                              //           items: sickList.map((String value) {
                              //             return DropdownMenuItem<String>(
                              //               value: value,
                              //               child: Text(value),
                              //             );
                              //           }).toList(),
                              //           onChanged: (value) {
                              //             controller.additionalProof.value =
                              //                 value!;
                              //           },
                              //         )),
                              //   ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                height: 40.0.h,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                      color: kGrey,
                                    )),
                                child: Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Obx(() => Text(
                                              controller
                                                  .additionalProofDoc.value,
                                              style: kBlack15Black
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14.0),
                                            )),
                                      ),
                                    ),
                                    const Spacer(),
                                    MaterialButton(
                                      elevation: 1.0,
                                      onPressed: () async {
                                        if (controller.claimDetail
                                                .value["claimStatus"]
                                                .toString() ==
                                            "UNDER_VERIFICATION") {
                                          Fluttertoast.showToast(
                                              msg: "Already Under Verification",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        } else {
                                          Get.defaultDialog(
                                              title: "Upload",
                                              titleStyle: 
                                                  kBlack15Black
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Divider(),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      // if (controller
                                                      //     .additionalDropDownList
                                                      //     .contains(controller
                                                      //         .additionalProofDoc
                                                      //         .value)) {
                                                      //   Fluttertoast.showToast(
                                                      //       msg:
                                                      //           "Already Exit Record for Selected Dropdown",
                                                      //       toastLength: Toast
                                                      //           .LENGTH_SHORT,
                                                      //       gravity:
                                                      //           ToastGravity
                                                      //               .BOTTOM,
                                                      //       timeInSecForIosWeb:
                                                      //           1,
                                                      //       backgroundColor:
                                                      //           Colors.red,
                                                      //       textColor:
                                                      //           Colors.white,
                                                      //       fontSize: 16.0);
                                                      // } else {
                                                      var file = await controller
                                                          .imageFromCamera();

                                                      controller
                                                              .additionalProofDoc
                                                              .value =
                                                          basename(file);
                                                      controller
                                                          .additionalDocpath
                                                          .value = file;

                                                      Get.back(
                                                          closeOverlays: true);
                                                      controller.additionalDocumentList(
                                                          dropDownValue:
                                                              controller
                                                                  .additionalProof
                                                                  .value,
                                                          imagePath: controller
                                                              .additionalDocpath
                                                              .value,
                                                          selectedValue:
                                                              controller
                                                                  .additionalProof
                                                                  .value);
                                                      // }
                                                    },
                                                    child: Text(
                                                      "Take Photo ...",
                                                      style: 
                                                          kBlack15Black
                                                          .copyWith(
                                                              color: kdarkBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16.0),
                                                    ),
                                                  ),
                                                  const Divider(),
                                                  GestureDetector(
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    onTap: () async {
                                                      if (controller
                                                          .additionalDropDownList
                                                          .contains(controller
                                                              .additionalProofDoc
                                                              .value)) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Record Already Exits for Selected Dropdown",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                      } else {
                                                        var file =
                                                            await controller
                                                                .uploadFile();

                                                        controller
                                                                .additionalProofDoc
                                                                .value =
                                                            basename(file);
                                                        controller
                                                            .additionalDocpath
                                                            .value = file;
                                                        Get.back(
                                                            closeOverlays:
                                                                true);
                                                        controller.additionalDocumentList(
                                                            dropDownValue:
                                                                controller
                                                                    .additionalProof
                                                                    .value,
                                                            imagePath: controller
                                                                .additionalDocpath
                                                                .value,
                                                            selectedValue:
                                                                controller
                                                                    .additionalProof
                                                                    .value);
                                                      }
                                                    },
                                                    child: Text(
                                                      "Choose Files from Phone",
                                                      style: 
                                                          kBlack15Black
                                                          .copyWith(
                                                              color: kdarkBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16.0),
                                                    ),
                                                  ),
                                                  const Divider(),
                                                ],
                                              ),
                                              cancel: GestureDetector(
                                                onTap: () {
                                                  Get.back(closeOverlays: true);
                                                },
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Cancel",
                                                    style: kBlack15Black
                                                        .copyWith(
                                                            color: Colors.red,
                                                            fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                              onCancel: () => Get.back());
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: kGrey),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      color: Colors.white,
                                      child: Text("Upload",
                                          style: kBlack15Black
                                              .copyWith(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w400)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Obx(() =>
                                  controller.additionalDocpath.value.isNotEmpty
                                      ? Row(
                                          children: [
                                            GestureDetector(
                                              child: Text(
                                                "Preview",
                                                style: kBlack15Black
                                                    .copyWith(
                                                        fontSize: 14.0,
                                                        color: kdarkBlue,
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                              onTap: () =>
                                                  Get.to(() => PreviewScreen(
                                                        filePath: controller
                                                            .additionalDocpath
                                                            .value,
                                                      )),
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                controller.additionalProofDoc
                                                    .value = "";
                                                controller.additionalDocpath
                                                    .value = "";
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: klightBlue,
                                                size: 20,
                                              ),
                                            )
                                          ],
                                        )
                                      : SizedBox()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Center(
                                child: Container(
                                  width: Get.width,
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (controller
                                              .claimDetail
                                              .value["claimData"]
                                                  ["isForwardToVerifier"]
                                              .toString() ==
                                          "true") {
                                        Fluttertoast.showToast(
                                            msg: "Already send to Verifier",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      } else {
                                        controller.uploadFormData2();
                                        setState(() {});
                                      }
                                      //controller.uploadFormData2();
                                      //setState(() {});
                                    },
                                    child: Text(
                                      "Upload Additional Document",
                                      style: kBlack15Black
                                          .copyWith(color: Colors.white),
                                    ),
                                    color: kdarkBlue,
                                  ),
                                ),
                              ),
                              Center(
                                child: MaterialButton(
                                  onPressed: () {
                                    if (controller
                                            .claimDetail
                                            .value["claimData"]
                                                ["isForwardToVerifier"]
                                            .toString() ==
                                        "true") {
                                      Fluttertoast.showToast(
                                          msg: "Already send to Verifier",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      controller.uploadFormData2();
                                      setState(() {});
                                    }
                                  },
                                  child: Text(
                                    "Save",
                                    style: kBlack15Black
                                        .copyWith(color: Colors.white),
                                  ),
                                  color: kdarkBlue,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                log(controller.currentIndex.value.toString());
                                if (controller.currentIndex.value > 0) {
                                  controller.pageController.animateToPage(
                                      controller.currentIndex.value - 1,
                                      duration:
                                          const Duration(milliseconds: 100),
                                      curve: Curves.ease);
                                  controller.currentIndex.value =
                                      controller.currentIndex.value - 1;
                                  
                                  controller.causeofDeath.value = controller
                                                  .claimDetail
                                                  .value["claimData"]
                                              ["causeOfDeath"] ==
                                          null
                                      ? ""
                                      : controller.claimDetail
                                          .value["claimData"]["causeOfDeath"];
                                }
                                else if(controller.currentIndex.value <= 0){

                               if(dataArg[0]=="WIP"){
                               Get.off(() => WIPDetails(
                                title: '${dataArg[0]}',
                                 ));
                                 }
                               else{
                                  Get.off(() => Details(
                                  title: '${dataArg[0]}',
                                     ));
                                }}

                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: const Center(child: Text("Back")),
                              ),
                            )),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                              onTap: () {
                                log(controller.currentIndex.value.toString());
                                if (controller.currentIndex.value < 4) {
                                  controller.pageController.animateToPage(
                                      controller.currentIndex.value + 1,
                                      duration:
                                          const Duration(milliseconds: 100),
                                      curve: Curves.ease);
                                  controller.currentIndex.value =
                                      controller.currentIndex.value + 1;
                                  controller.causeofDeath.value = controller
                                                  .claimDetail
                                                  .value["claimData"]
                                              ["causeOfDeath"] ==
                                          null
                                      ? ""
                                      : controller.claimDetail
                                          .value["claimData"]["causeOfDeath"];
                                } else {
                                  log("--");
                                  controller.causeofDeath.value = controller
                                                  .claimDetail
                                                  .value["claimData"]
                                              ["causeOfDeath"] ==
                                          null
                                      ? ""
                                      : controller.claimDetail
                                          .value["claimData"]["causeOfDeath"];

                                  if (controller
                                              .claimDetail
                                              .value["claimDocuments"][0]
                                                  ["singnedClaimDocument"]
                                              .toString() !=
                                          "UPLOADED" ||
                                      controller
                                              .claimDetail
                                              .value["claimDocuments"][0]
                                                  ["deathCertificate"]
                                              .toString() !=
                                          "UPLOADED" ||
                                      controller
                                              .claimDetail
                                              .value["claimDocuments"][0]
                                                  ["borrowerKycProof"]
                                              .toString() !=
                                          "UPLOADED" ||
                                      controller
                                              .claimDetail
                                              .value["claimDocuments"][0]
                                                  ["nomineeKycProof"]
                                              .toString() !=
                                          "UPLOADED" ||
                                      controller
                                              .claimDetail
                                              .value["claimDocuments"][0]
                                                  ["bankAccountProof"]
                                              .toString() !=
                                          "UPLOADED") {
                                    Fluttertoast.showToast(
                                        msg: "Upload all required Document",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else if (controller
                                          .claimDetail
                                          .value["claimData"]
                                              ["isForwardToVerifier"]
                                          .toString() ==
                                      "true") {
                                    Fluttertoast.showToast(
                                        msg: "Already send to Verifier",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else {
                                    log("rrr");

                                    controller.sendToVerifier();
                                    Fluttertoast.showToast(
                                        msg: "Form send to Verifier",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                }
                              },
                              child: Obx(
                                () => controller.currentIndex.value < 4
                                    ? Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff134E85),
                                            border: Border.all(
                                                color: const Color(0xff134E85)),
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: Center(
                                          child: Text(
                                            "Next",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    : controller
                                                    .claimDetail
                                                    .value["claimDocuments"][0]
                                                        ["singnedClaimDocument"]
                                                    .toString() ==
                                                "UPLOADED" &&
                                            controller
                                                    .claimDetail
                                                    .value["claimDocuments"][0]
                                                        ["deathCertificate"]
                                                    .toString() ==
                                                "UPLOADED" &&
                                            controller
                                                    .claimDetail
                                                    .value["claimDocuments"][0]
                                                        ["bankAccountProof"]
                                                    .toString() ==
                                                "UPLOADED" &&
                                            controller
                                                    .claimDetail
                                                    .value["claimDocuments"][0]
                                                        ["borrowerKycProof"]
                                                    .toString() ==
                                                "UPLOADED" &&
                                            controller
                                                    .claimDetail
                                                    .value["claimDocuments"][0]
                                                        ["nomineeKycProof"]
                                                    .toString() ==
                                                "UPLOADED"
                                        ? Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff134E85),
                                                border: Border.all(
                                                    color: const Color(
                                                        0xff134E85)),
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            child: Center(
                                              child: Obx(
                                                () => controller.currentIndex
                                                            .value <
                                                        4
                                                    ? Text(
                                                        "Next",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    : Text(
                                                        "Submit",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    19, 78, 133, 0.6),
                                                border: Border.all(
                                                    color: const Color(
                                                        0xff134E85)),
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            child: Center(
                                              child: Obx(
                                                () => controller.currentIndex
                                                            .value <
                                                        3
                                                    ? Text(
                                                        "Next",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    : Text(
                                                        "Submit",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                              ),
                                            ),
                                          ),
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(() => controller.loadUpload.value
              ? Container(
                  height: Get.height - kToolbarHeight,
                  width: Get.width,
                  color: Colors.grey.shade300.withOpacity(0.7),
                  child: Center(child: CircularProgressIndicator()),
                )
              : SizedBox())
        ],
      ),
    );
  }

  buildRow() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
      child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 0; i < 5; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: controller.currentIndex.value != i &&
                                  controller.currentIndex.value <= i
                              ? Colors.white
                              : Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: controller.currentIndex.value != i &&
                                      controller.currentIndex.value <= i
                                  ? Colors.grey
                                  : Colors.green)),
                      height: 15.0.h,
                      width: 15.0.w,
                    ),
                    i != 4
                        ? Container(
                            width: Get.width * 0.15,
                            height: 2.0,
                            color: controller.currentIndex.value != i &&
                                    controller.currentIndex.value <= i
                                ? Colors.grey
                                : Colors.green,
                          )
                        : SizedBox()
                  ],
                ),
            ],
          )),
    );
  }

  static Widget field({text}) => Container(
        child: TextFormField(
          enabled: false,
          decoration: InputDecoration(
              hintText: text,
              hintStyle: kBlack15Black,
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.grey.shade300))),
        ),
      );

  static Widget addressField({text}) => Container(
        child: TextFormField(
          maxLines: 4,
          enabled: false,
          decoration: InputDecoration(
              hintText: text,
              hintStyle: kBlack15Black,
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.grey.shade300))),
        ),
      );

  static Widget smallText({text}) => Container(
        child: Text(
          text,
          style: kBlack15Black.copyWith(
              fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      );

  Widget nominee() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 2,
          child: RadioListTile(
            title: const Text("Major"),
            value: "Major",
            groupValue: controller.nominee.value,
            activeColor: kdarkBlue,
            onChanged: (value) {
              log(value.toString());
              setState(() {
                controller.nominee.value = value.toString();
                controller.RelationProof.value = '';
                controller.GUARDIAN_ID_PROOF.value = '';
                controller.GUARDIAN_ADD_PROOF.value = '';
                controller.minor.clear();
                controller.minorImage.clear();
                controller.minorNominee.clear();
              });
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: RadioListTile(
            title: const Text("Minor"),
            value: "Minor",
            groupValue: controller.nominee.value,
            activeColor: kdarkBlue,
            onChanged: (value) {
              log(value.toString());
              setState(() {
                controller.nominee.value = value.toString();
              });
            },
          ),
        ),
        const Expanded(
          child: SizedBox(),
          flex: 1,
        )
      ],
    );
  }

  Widget imagePick({certificate, type}) => Container(
        height: 40.0.h,
        decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: kGrey,
            )),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$certificate",
                style: kBlack15Black
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 14.0),
              ),
            ),
            const Spacer(),
            MaterialButton(
              elevation: 1.0,
              onPressed: () async {
                var file = await controller.uploadFile();
                print(file);
                if (type == "1") {
                  controller.filled.value = file;
                }
              },
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: kGrey),
                  borderRadius: BorderRadius.circular(5.0)),
              color: Colors.white,
              child: Text("Upload",
                  style: kBlack15Black
                      .copyWith(fontSize: 15.0, fontWeight: FontWeight.w400)),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      );

  String dateChange(date) {
    var temp = DateTime.fromMillisecondsSinceEpoch(date);
    var currentDate = "${temp.day}/ ${temp.month}/ ${temp.year}";
    return currentDate.toString();
  }

  validation() {
    // Condition for non-empty documents if type is selected

    if (controller.dealthCertificate.value.isNotEmpty) {
      if (controller.deathCertificatePath.value.isNotEmpty) {
        ///Api call krni h yha se
      } else {
        showMessage(message: "Please Select Death Certificate");
      }
    }

    if (controller.borroweridProof.value.isNotEmpty) {
      if (controller.borrowerIdDocPath.isNotEmpty) {
        ///Api call krni h yha se
      } else {
        showMessage(message: "Please Select KYC ID Proof");
      }
    }
    if (controller.nomineeIdProof.value.isNotEmpty) {
      if (controller.nomineeIdDocPath.isNotEmpty) {
        ///Api call krni h yha se
      } else {
        showMessage(message: "Please Select Nominee ID Proof");
      }
    }

    if (controller.bankProof.value.isNotEmpty) {
      if (controller.bankAccountDocPath.isNotEmpty) {
        ///Api call krni h yha se
      } else {
        showMessage(message: "Please Select Bank Proof");
      }
    }
    if (controller.additionalProof.value.isNotEmpty) {
      if (controller.additionalDocpath.isNotEmpty) {
        ///Api call krni h yha se
      } else {
        showMessage(message: "Please Select Additional Proof");
      }
    }
    if (controller.causeofDeath.value != "Natural Death") {
      if (controller.firOrPostmortemReportPath.isNotEmpty) {
        ///Api call krni h yha se
      } else {
        showMessage(message: "Please Select FIR Document");
      }
    }

    //condition for non empty type if document is uploaded

    if (controller.borrowerIdDocPath.value.isNotEmpty) {
      if (controller.borroweridProof.isNotEmpty) {
        ///Api call krni h yha se
      } else {
        showMessage(message: "Please Select KYC ID Proof Type");
      }
    }

    if (controller.nomineeIdDocPath.value.isNotEmpty) {
      if (controller.nomineeIdProof.isNotEmpty) {
        ///Api call krni h yha se
      } else {
        showMessage(message: "Please Select Nominee ID Proof");
      }
    }

    if (controller.bankAccountDocPath.value.isNotEmpty) {
      if (controller.bankProof.isNotEmpty) {
        ///Api call krni h yha se
      } else {
        showMessage(message: "Please Select Bank Proof");
      }
    }
    if (controller.additionalDocpath.value.isNotEmpty) {
      if (controller.additionalProof.isNotEmpty) {
        ///Api call krni h yha se
      } else {
        showMessage(message: "Please Select Additional Proof");
      }
    }
  }

  showMessage({required String message}) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}





// SingleChildScrollView(
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: <Widget>[
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             "Documentation Upload",
//             style: kBlack15Black.copyWith(
//                 fontSize: 15.0,
//                 fontWeight: FontWeight.w900,
//                 color: Colors.black),
//           ),
//           SizedBox(
//             height: 15.0.h,
//           ),
//           smallText(
//               text: "Insurance Category"),
//           const SizedBox(
//             height: 5.0,
//           ),
//           field(
//               text: controller.claimDetail
//                   .value["claimData"]
//               ["claimCategory"]),
//           const SizedBox(
//             height: 10.0,
//           ),
//           smallText(
//               text: "Cause of Death (Life Insurance)"),
//           const SizedBox(
//             height: 5.0,
//           ),
//           controller.claimDetail.value["claimData"]
//                       ["causeOfDeath"] !=
//                   null
//               ? field(
//                   text: controller.claimDetail
//                           .value["claimData"]
//                       ["causeOfDeath"])
//               : Container(
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade100,
//                       borderRadius:
//                           BorderRadius.circular(1.0),
//                       border: Border.all(color: kGrey)),
//                   child:
//                       Obx(() => DropdownButton<String>(
//                             isExpanded: true,
//                             hint: Padding(
//                               padding:
//                                   const EdgeInsets.all(
//                                       8.0),
//                               child: controller
//                                       .causeofDeath
//                                       .value
//                                       .isNotEmpty
//                                   ? Text(
//                                       controller
//                                           .causeofDeath
//                                           .value,
//                                       style: 
//                                           kBlack15Black
//                                           .copyWith(
//                                               fontSize:
//                                                   14.0),
//                                     )
//                                   : Text(
//                                       "Choose The Cause ",
//                                       style: 
//                                           kBlack15Black
//                                           .copyWith(
//                                               fontSize:
//                                                   14.0),
//                                     ),
//                             ),
//                             underline: const SizedBox(),
//                             items: <String>[
//                               'Accident',
//                               'Natural Death',
//                               'Suicide',
//                               'Illness &  Medical Reason',
//                               'Dealth due to Natural Calamity'
//                             ].map((String value) {
//                               return DropdownMenuItem<
//                                   String>(
//                                 value: value,
//                                 child: Text(value),
//                               );
//                             }).toList(),
//                             onChanged: (value) {
//                               controller.causeofDeath
//                                   .value = value!;
//                             },
//                           )),
//                 ),
//           const SizedBox(
//             height: 10.0,
//           ),
//           smallText(text: "Is Nominee "),
//           const SizedBox(
//             height: 5.0,
//           ),
//           nominee(),
//           Obx(() => controller.nominee.value == "Minor"
//               ? Container(
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade100,
//                       borderRadius:
//                           BorderRadius.circular(1.0),
//                       border: Border.all(color: kGrey)),
//                   child:
//                       Obx(() => DropdownButton<String>(
//                             isExpanded: true,
//                             hint: Padding(
//                               padding:
//                                   const EdgeInsets.all(
//                                       8.0),
//                               child: controller
//                                       .minorDropdown
//                                       .value
//                                       .isNotEmpty
//                                   ? Text(
//                                       controller
//                                           .minorDropdown
//                                           .value,
//                                       style: 
//                                           kBlack15Black
//                                           .copyWith(
//                                               fontSize:
//                                                   14.0),
//                                     )
//                                   : Text(
//                                       "Select Document Type",
//                                       style: 
//                                           kBlack15Black
//                                           .copyWith(
//                                               fontSize:
//                                                   14.0),
//                                     ),
//                             ),
//                             underline: const SizedBox(),
//                             items: minorList
//                                 .map((String value) {
//                               return DropdownMenuItem<
//                                   String>(
//                                 value: value,
//                                 child: Text(value),
//                               );
//                             }).toList(),
//                             onChanged: (value) {
//                               controller.minorDropdown
//                                   .value = value!;
//                             },
//                           )),
//                 )
//               : SizedBox()),
//           SizedBox(
//             height: 10,
//           ),
//           Obx(() => controller.nominee.value == "Minor"
//               ? Column(
//                   crossAxisAlignment:
//                       CrossAxisAlignment.start,
//                   mainAxisAlignment:
//                       MainAxisAlignment.start,
//                   children: [
//                     smallText(
//                         text:
//                             "Additional Document for Minor"),
//                     const SizedBox(
//                       height: 10.0,
//                     ),
//                     Container(
//                       height: 40.0.h,
//                       decoration: BoxDecoration(
//                           color: Colors.grey.shade50,
//                           borderRadius:
//                               BorderRadius.circular(
//                                   5.0),
//                           border: Border.all(
//                             color: kGrey,
//                           )),
//                       child: Row(
//                         children: [
//                           Flexible(
//                             fit: FlexFit.tight,
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.all(
//                                       8.0),
//                               child: Obx(() => Text(
//                                     "${controller.minorProofPath.value}",
//                                     style: 
//                                         kBlack15Black
//                                         .copyWith(
//                                             fontWeight:
//                                                 FontWeight
//                                                     .w600,
//                                             fontSize:
//                                                 14.0),
//                                   )),
//                             ),
//                           ),
//                           const Spacer(),
//                           MaterialButton(
//                             elevation: 1.0,
//                             onPressed: () async {
//                               // if (controller.minor.value
//                               //     .contains(controller
//                               //         .minorNominee
//                               //         .value)) {
//                               //   Fluttertoast.showToast(
//                               //       msg:
//                               //           "File Already Exists ! Please Choose Another",
//                               //       toastLength: Toast
//                               //           .LENGTH_SHORT,
//                               //       gravity:
//                               //           ToastGravity
//                               //               .BOTTOM,
//                               //       timeInSecForIosWeb:
//                               //           1,
//                               //       backgroundColor:
//                               //           Colors.red,
//                               //       textColor:
//                               //           Colors.white,
//                               //       fontSize: 16.0);
//                               // } else if (controller
//                               //         .minor.value
//                               //         .contains(
//                               //             controller
//                               //                 .minorProof
//                               //                 .value) &&
//                               //     controller.minor.value
//                               //             .length <
//                               //         3) {
//                               //   Fluttertoast.showToast(
//                               //       msg:
//                               //           "Add Mandatory Documents",
//                               //       toastLength: Toast
//                               //           .LENGTH_SHORT,
//                               //       gravity:
//                               //           ToastGravity
//                               //               .BOTTOM,
//                               //       timeInSecForIosWeb:
//                               //           1,
//                               //       backgroundColor:
//                               //           Colors.red,
//                               //       textColor:
//                               //           Colors.white,
//                               //       fontSize: 16.0);
//                               // } else if (controller
//                               //         .claimDetail
//                               //         .value["claimDocuments"][
//                               //             "claimStatus"]
//                               //         .toString() ==
//                               //     "UNDER_VERIFICATION1") {
//                               //   Fluttertoast.showToast(
//                               //       msg:
//                               //           "Already Under Verification",
//                               //       toastLength: Toast
//                               //           .LENGTH_SHORT,
//                               //       gravity:
//                               //           ToastGravity
//                               //               .BOTTOM,
//                               //       timeInSecForIosWeb:
//                               //           1,
//                               //       backgroundColor:
//                               //           Colors.red,
//                               //       textColor:
//                               //           Colors.white,
//                               //       fontSize: 16.0);
//                               // } else {
//                               Get.defaultDialog(
//                                   title: "Upload",
//                                   titleStyle: 
//                                       kBlack15Black
//                                       .copyWith(
//                                           color: Colors
//                                               .black,
//                                           fontSize:
//                                               20.0,
//                                           fontWeight:
//                                               FontWeight
//                                                   .bold),
//                                   content: Column(
//                                     mainAxisSize:
//                                         MainAxisSize
//                                             .min,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment
//                                             .center,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment
//                                             .center,
//                                     children: [
//                                       Divider(),
//                                       GestureDetector(
//                                         onTap:
//                                             () async {
//                                           if (controller
//                                               .minorNominee
//                                               .contains(controller
//                                                   .minorDropdown
//                                                   .value)) {
//                                             Fluttertoast.showToast(
//                                                 msg:
//                                                     "Already Exit Record for Selected Dropdown",
//                                                 toastLength:
//                                                     Toast
//                                                         .LENGTH_SHORT,
//                                                 gravity:
//                                                     ToastGravity
//                                                         .BOTTOM,
//                                                 timeInSecForIosWeb:
//                                                     1,
//                                                 backgroundColor:
//                                                     Colors
//                                                         .red,
//                                                 textColor:
//                                                     Colors
//                                                         .white,
//                                                 fontSize:
//                                                     16.0);
//                                           } else {
//                                             var file =
//                                                 await controller
//                                                     .imageFromCamera();
//
//                                             if (controller
//                                                     .minorDropdown
//                                                     .value ==
//                                                 "RELATIONSHIP_PROOF") {
//                                               controller
//                                                       .minorProof
//                                                       .value =
//                                                   basename(
//                                                       file);
//                                               controller
//                                                   .RelationProof
//                                                   .value = file;
//                                               Get.back(
//                                                   closeOverlays:
//                                                       true);
//                                               controller.addProductLot(
//                                                   selectedValue: controller
//                                                       .minorProof
//                                                       .value,
//                                                   imagePath: controller
//                                                       .RelationProof
//                                                       .value,
//                                                   dropDownValue: controller
//                                                       .minorDropdown
//                                                       .value);
//                                             } else if (controller
//                                                     .minorDropdown
//                                                     .value ==
//                                                 "GUARDIAN_ID_PROOF") {
//                                               controller
//                                                       .minorProof
//                                                       .value =
//                                                   basename(
//                                                       file);
//                                               controller
//                                                   .GUARDIAN_ID_PROOF
//                                                   .value = file;
//                                               Get.back(
//                                                   closeOverlays:
//                                                       true);
//                                               controller.addProductLot(
//                                                   selectedValue: controller
//                                                       .minorProof
//                                                       .value,
//                                                   imagePath: controller
//                                                       .GUARDIAN_ID_PROOF
//                                                       .value,
//                                                   dropDownValue: controller
//                                                       .minorDropdown
//                                                       .value);
//                                             } else if (controller
//                                                     .minorDropdown
//                                                     .value ==
//                                                 "GUARDIAN_ADD_PROOF") {
//                                               controller
//                                                       .minorProof
//                                                       .value =
//                                                   basename(
//                                                       file);
//                                               controller
//                                                   .GUARDIAN_ADD_PROOF
//                                                   .value = file;
//                                               Get.back(
//                                                   closeOverlays:
//                                                       true);
//                                               controller.addProductLot(
//                                                   selectedValue: controller
//                                                       .minorProof
//                                                       .value,
//                                                   imagePath: controller
//                                                       .GUARDIAN_ADD_PROOF
//                                                       .value,
//                                                   dropDownValue: controller
//                                                       .minorDropdown
//                                                       .value);
//                                             } else if (controller
//                                                     .minorDropdown
//                                                     .value ==
//                                                 "Other Document") {
//                                               controller
//                                                       .minorProof
//                                                       .value =
//                                                   basename(
//                                                       file);
//                                               controller
//                                                   .minorProofPath
//                                                   .value = file;
//                                               Get.back(
//                                                   closeOverlays:
//                                                       true);
//                                               controller.addProductLot(
//                                                   selectedValue: controller
//                                                       .minorProof
//                                                       .value,
//                                                   imagePath: controller
//                                                       .minorProofPath
//                                                       .value,
//                                                   dropDownValue: controller
//                                                       .minorDropdown
//                                                       .value);
//                                             }
//                                           }
//                                         },
//                                         child: Text(
//                                           "Take Photo ...",
//                                           style: kBlack15Black.copyWith(
//                                               color:
//                                                   kdarkBlue,
//                                               fontWeight:
//                                                   FontWeight
//                                                       .w600,
//                                               fontSize:
//                                                   16.0),
//                                         ),
//                                       ),
//                                       Divider(),
//                                       GestureDetector(
//                                         behavior:
//                                             HitTestBehavior
//                                                 .opaque,
//                                         onTap:
//                                             () async {
//                                           if (controller
//                                               .minorNominee
//                                               .contains(controller
//                                                   .minorDropdown
//                                                   .value)) {
//                                             Fluttertoast.showToast(
//                                                 msg:
//                                                     "Already Exit Record for Selected Dropdown",
//                                                 toastLength:
//                                                     Toast
//                                                         .LENGTH_SHORT,
//                                                 gravity:
//                                                     ToastGravity
//                                                         .BOTTOM,
//                                                 timeInSecForIosWeb:
//                                                     1,
//                                                 backgroundColor:
//                                                     Colors
//                                                         .red,
//                                                 textColor:
//                                                     Colors
//                                                         .white,
//                                                 fontSize:
//                                                     16.0);
//                                           } else {
//                                             var file =
//                                                 await controller
//                                                     .uploadFile();
//
//                                             controller
//                                                     .minorProof
//                                                     .value =
//                                                 basename(
//                                                     file);
//                                             controller
//                                                 .minorProofPath
//                                                 .value = file;
//
//                                             Get.back(
//                                                 closeOverlays:
//                                                     true);
//                                             controller.addProductLot(
//                                                 imagePath: controller
//                                                     .minorProofPath
//                                                     .value,
//                                                 selectedValue: controller
//                                                     .minorProof
//                                                     .value,
//                                                 dropDownValue: controller
//                                                     .minorDropdown
//                                                     .value);
//                                           }
//                                         },
//                                         child: Text(
//                                           "Choose Files from Phone",
//                                           style: kBlack15Black.copyWith(
//                                               color:
//                                                   kdarkBlue,
//                                               fontWeight:
//                                                   FontWeight
//                                                       .w600,
//                                               fontSize:
//                                                   16.0),
//                                         ),
//                                       ),
//                                       Divider(),
//                                     ],
//                                   ),
//                                   cancel:
//                                       GestureDetector(
//                                     onTap: () {
//                                       log("**");
//                                       Get.back(
//                                           closeOverlays:
//                                               true);
//                                     },
//                                     behavior:
//                                         HitTestBehavior
//                                             .opaque,
//                                     child: Padding(
//                                       padding:
//                                           const EdgeInsets
//                                               .all(8.0),
//                                       child: Text(
//                                         "Cancel",
//                                         style: 
//                                             kBlack15Black
//                                             .copyWith(
//                                                 color: Colors
//                                                     .red,
//                                                 fontSize:
//                                                     16),
//                                       ),
//                                     ),
//                                   ),
//                                   onCancel: () =>
//                                       Get.back());
//                               // }
//                             },
//                             shape:
//                                 RoundedRectangleBorder(
//                                     side:
//                                         const BorderSide(
//                                             color:
//                                                 kGrey),
//                                     borderRadius:
//                                         BorderRadius
//                                             .circular(
//                                                 5.0)),
//                             color: Colors.white,
//                             child: Text("Upload",
//                                 style: 
//                                     kBlack15Black
//                                     .copyWith(
//                                         fontSize: 15.0,
//                                         fontWeight:
//                                             FontWeight
//                                                 .w400)),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 )
//               : const SizedBox()),
//           const SizedBox(
//             height: 10.0,
//           ),
//           ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: controller.minorImage.length,
//               itemBuilder: (context, int index) {
//                 return Obx(() => controller
//                             .nominee.value.isNotEmpty ||
//                         controller.nominee.value ==
//                             "Minor"
//                     ? Row(
//                         children: [
//                           GestureDetector(
//                             child: Text(
//                               "Preview",
//                               style: 
//                                   kBlack15Black
//                                   .copyWith(
//                                       fontSize: 14.0,
//                                       color: kdarkBlue,
//                                       fontWeight:
//                                           FontWeight
//                                               .w700),
//                             ),
//                             onTap: () => Get.to(
//                                 () => PreviewScreen(
//                                       filePath: controller
//                                           .minorImage
//                                           .value[index],
//                                     )),
//                           ),
//                           const Spacer(),
//                           GestureDetector(
//                             onTap: () {
//                               controller
//                                   .minorProof
//                                   .value= "";
//                               controller
//                                   .minorProofPath
//                                   .value = "";
//                               controller
//                                   .minorImage
//                                   .removeAt(index);
//                               controller.minor.removeAt(index);
//                               controller.minorNominee.removeAt(index);
//
//                             },
//                             child: const Icon(
//                               Icons.delete,
//                               color: klightBlue,
//                               size: 20,
//                             ),
//                           )
//                         ],
//                       )
//                     : SizedBox());
//               }),
//           const SizedBox(
//             height: 10.0,
//           ),
//           const SizedBox(
//             height: 10.0,
//           ),
//           Row(
//             children: [
//               smallText(
//                   text: "Filled & Signed Claim form"),
//               Text(
//                 " * ",
//                 style: TextStyle(color: Colors.red),
//               )
//             ],
//           ),
//           const SizedBox(
//             height: 5.0,
//           ),
//           Text(
//               "${controller.claimDetail.value["claimDocuments"][0]["singnedClaimDocument"].toString() == "UPLOADED" ? controller.claimDetail.value["claimDocuments"][0]["singnedClaimDocument"].toString() : ""}"),
//           Container(
//             height: 40.0.h,
//             decoration: BoxDecoration(
//                 color: Colors.grey.shade50,
//                 borderRadius:
//                     BorderRadius.circular(5.0),
//                 border: Border.all(
//                   color: kGrey,
//                 )),
//             child: Row(
//               children: [
//                 Flexible(
//                   fit: FlexFit.tight,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 8, vertical: 8),
//                     child: Obx(() => Text(
//                           "${controller.filled.value}",
//                           style: 
//                               kBlack15Black
//                               .copyWith(
//                                   fontWeight:
//                                       FontWeight.w600,
//                                   fontSize: 14.0),
//                         )),
//                   ),
//                 ),
//                 const Spacer(),
//                 MaterialButton(
//                   elevation: 1.0,
//                   onPressed: () async {
//                     if (controller
//                             .claimDetail
//                             .value["claimDocuments"][0]
//                                 ["singnedClaimDocument"]
//                             .toString() ==
//                         "UPLOADED") {
//                       Fluttertoast.showToast(
//                           msg:
//                               "Already Under Verification",
//                           toastLength:
//                               Toast.LENGTH_SHORT,
//                           gravity: ToastGravity.BOTTOM,
//                           timeInSecForIosWeb: 1,
//                           backgroundColor: Colors.red,
//                           textColor: Colors.white,
//                           fontSize: 16.0);
//                     } else {
//                       Get.defaultDialog(
//                           title: "Upload",
//                           titleStyle: 
//                               kBlack15Black
//                               .copyWith(
//                                   color: Colors.black,
//                                   fontSize: 20.0,
//                                   fontWeight:
//                                       FontWeight.bold),
//                           content: Column(
//                             mainAxisSize:
//                                 MainAxisSize.min,
//                             crossAxisAlignment:
//                                 CrossAxisAlignment
//                                     .center,
//                             mainAxisAlignment:
//                                 MainAxisAlignment
//                                     .center,
//                             children: [
//                               Divider(),
//                               GestureDetector(
//                                 onTap: () async {
//                                   var file =
//                                       await controller
//                                           .imageFromCamera();
//                                   controller.filled
//                                           .value =
//                                       basename(file);
//                                   controller.filledPath
//                                       .value = file;
//                                   Get.back(
//                                       closeOverlays:
//                                           true);
//                                 },
//                                 child: Text(
//                                   "Take Photo ...",
//                                   style: 
//                                       kBlack15Black
//                                       .copyWith(
//                                           color:
//                                               kdarkBlue,
//                                           fontWeight:
//                                               FontWeight
//                                                   .w600,
//                                           fontSize:
//                                               16.0),
//                                 ),
//                               ),
//                               Divider(),
//                               GestureDetector(
//                                 behavior:
//                                     HitTestBehavior
//                                         .opaque,
//                                 onTap: () async {
//                                   await controller
//                                       .uploadFile1();
//
//                                   // var file =
//                                   // await controller
//                                   //     .uploadFile();
//                                   // print(file);
//                                   // controller
//                                   //     .filled
//                                   //     .value =
//                                   //     basename(file);
//                                   // controller
//                                   //     .filled
//                                   //     .value = file;
//                                   //print(file);
//                                   // controller.filled
//                                   //         .value =
//                                   //     basename(file);
//                                   // controller.files = file;
//                                   //
//                                   // controller.signForm.addAll(
//                                   //     {file});
//                                   setState(() {});
//                                   Get.back(
//                                       closeOverlays:
//                                           true);
//                                   setState(() {});
//                                 },
//                                 child: Text(
//                                   "Choose Files from Phone",
//                                   style: 
//                                       kBlack15Black
//                                       .copyWith(
//                                           color:
//                                               kdarkBlue,
//                                           fontWeight:
//                                               FontWeight
//                                                   .w600,
//                                           fontSize:
//                                               16.0),
//                                 ),
//                               ),
//                               Divider(),
//                             ],
//                           ),
//                           cancel: GestureDetector(
//                             onTap: () {
//                               log("**");
//                               Get.back(
//                                   closeOverlays: true);
//                             },
//                             behavior:
//                                 HitTestBehavior.opaque,
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.all(
//                                       8.0),
//                               child: Text(
//                                 "Cancel",
//                                 style: 
//                                     kBlack15Black
//                                     .copyWith(
//                                         color:
//                                             Colors.red,
//                                         fontSize: 16),
//                               ),
//                             ),
//                           ),
//                           onCancel: () => Get.back());
//                     }
//                   },
//                   shape: RoundedRectangleBorder(
//                       side: const BorderSide(
//                           color: kGrey),
//                       borderRadius:
//                           BorderRadius.circular(5.0)),
//                   color: Colors.white,
//                   child: Text("Upload",
//                       style: kBlack15Black
//                           .copyWith(
//                               fontSize: 15.0,
//                               fontWeight:
//                                   FontWeight.w400)),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(height: 10.0),
//           controller.files1 != null
//               ? ListView.builder(
//                   shrinkWrap: true,
//                   physics:
//                       NeverScrollableScrollPhysics(),
//                   itemCount: controller.files1!.length,
//                   itemBuilder: (context, int index) {
//                     return controller.files1!.isNotEmpty
//                         ? Row(
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets
//                                         .all(8.0),
//                                 child: GestureDetector(
//                                     child: Text(
//                                       "Preview",
//                                       style: 
//                                           kBlack15Black
//                                           .copyWith(
//                                               fontSize:
//                                                   14.0,
//                                               color:
//                                                   kdarkBlue,
//                                               fontWeight:
//                                                   FontWeight
//                                                       .w700),
//                                     ),
//                                     onTap: () {
//                                       var filePathinPdf;
//
//                                       String s =
//                                           "${controller.files1![index].toString()}";
//                                       int idx = s
//                                           .indexOf(":");
//                                       List parts = [
//                                         s
//                                             .substring(
//                                                 0, idx)
//                                             .trim(),
//                                         s
//                                             .substring(
//                                                 idx + 1)
//                                             .trim()
//                                       ];
//                                       var str =
//                                           parts[1];
//                                       var find = "'";
//                                       var replaceWith =
//                                           '';
//                                       var newString =
//                                           str.replaceAll(
//                                               find,
//                                               replaceWith);
//                                       var parts1 =
//                                           str.split(
//                                               '${str[0]}');
//                                       filePathinPdf =
//                                           newString;
//                                       //controller.filled.value=controller.files1![index].toString();
//                                       // print(controller.files1![index].toString());
//                                       // print(controller.deathCertificatePath.value.toString());
//                                       // print(filePathinPdf==controller.deathCertificatePath.value.toString());
//                                       Get.to(() =>
//                                           PreviewScreen(
//                                             filePath:
//                                                 filePathinPdf,
//                                             // filePath:  controller
//                                             //     .deathCertificatePath
//                                             //     .value,
//                                           ));
//                                     }),
//                               ),
//                               const Spacer(),
//                               GestureDetector(
//                                 onTap: () {
//                                   controller.files1!
//                                       .removeAt(index);
//
//                                   setState(() {});
//                                 },
//                                 child: const Icon(
//                                   Icons.delete,
//                                   color: klightBlue,
//                                   size: 20,
//                                 ),
//                               )
//                             ],
//                           )
//                         : SizedBox();
//                   })
//               : SizedBox(),
//
//           Obx(() => controller
//                   .filledPath.value.isNotEmpty
//               ? Row(
//                   children: [
//                     GestureDetector(
//                       child: Text(
//                         "Preview",
//                         style: kBlack15Black
//                             .copyWith(
//                                 fontSize: 14.0,
//                                 color: kdarkBlue,
//                                 fontWeight:
//                                     FontWeight.w700),
//                       ),
//                       onTap: () =>
//                           Get.to(() => PreviewScreen(
//                                 filePath: controller
//                                     .filledPath.value,
//                               )),
//                     ),
//                     const Spacer(),
//                     GestureDetector(
//                       onTap: () {
//                         controller.filled.value = "";
//                         controller.filledPath.value =
//                             "";
//                       },
//                       child: const Icon(
//                         Icons.delete,
//                         color: klightBlue,
//                         size: 20,
//                       ),
//                     )
//                   ],
//                 )
//               : SizedBox()),
//           const SizedBox(
//             height: 10.0,
//           ),
//           Row(
//             children: [
//               smallText(text: "Death Certificate"),
//               Text(
//                 " * ",
//                 style: TextStyle(color: Colors.red),
//               )
//             ],
//           ),
//           Text(
//               "${controller.claimDetail.value["claimDocuments"][0]["deathCertificate"].toString() == "UPLOADED" ? controller.claimDetail.value["claimDocuments"][0]["deathCertificate"].toString() : ""}"),
//           const SizedBox(
//             height: 5.0,
//           ),
//           Container(
//             height: 40.0.h,
//             decoration: BoxDecoration(
//                 color: Colors.grey.shade50,
//                 borderRadius:
//                     BorderRadius.circular(5.0),
//                 border: Border.all(
//                   color: kGrey,
//                 )),
//             child: Row(
//               children: [
//                 Flexible(
//                   fit: FlexFit.tight,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Obx(() => Text(
//                           controller
//                               .dealthCertificate.value,
//                           style: 
//                               kBlack15Black
//                               .copyWith(
//                                   fontWeight:
//                                       FontWeight.w600,
//                                   fontSize: 14.0),
//                         )),
//                   ),
//                 ),
//                 const Spacer(),
//                 MaterialButton(
//                   elevation: 1.0,
//                   onPressed: () async {
//                     if (controller
//                             .claimDetail
//                             .value["claimDocuments"][0]
//                                 ["deathCertificate"]
//                             .toString() ==
//                         "UPLOADED") {
//                       Fluttertoast.showToast(
//                           msg:
//                               "Already Under Verification",
//                           toastLength:
//                               Toast.LENGTH_SHORT,
//                           gravity: ToastGravity.BOTTOM,
//                           timeInSecForIosWeb: 1,
//                           backgroundColor: Colors.red,
//                           textColor: Colors.white,
//                           fontSize: 16.0);
//                     } else {
//                       Get.defaultDialog(
//                           title: "Upload",
//                           titleStyle: 
//                               kBlack15Black
//                               .copyWith(
//                                   color: Colors.black,
//                                   fontSize: 20.0,
//                                   fontWeight:
//                                       FontWeight.bold),
//                           content: Column(
//                             mainAxisSize:
//                                 MainAxisSize.min,
//                             crossAxisAlignment:
//                                 CrossAxisAlignment
//                                     .center,
//                             mainAxisAlignment:
//                                 MainAxisAlignment
//                                     .center,
//                             children: [
//                               const Divider(),
//                               GestureDetector(
//                                 onTap: () async {
//                                   var file =
//                                       await controller
//                                           .imageFromCamera();
//                                   controller
//                                           .dealthCertificate
//                                           .value =
//                                       basename(file);
//                                   controller
//                                       .deathCertificatePath
//                                       .value = file;
//                                   print(
//                                       "object ${controller.deathCertificatePath.value}");
//                                   Get.back(
//                                       closeOverlays:
//                                           true);
//                                 },
//                                 child: Text(
//                                   "Take Photo ...",
//                                   style: 
//                                       kBlack15Black
//                                       .copyWith(
//                                           color:
//                                               kdarkBlue,
//                                           fontWeight:
//                                               FontWeight
//                                                   .w600,
//                                           fontSize:
//                                               16.0),
//                                 ),
//                               ),
//                               Divider(),
//                               GestureDetector(
//                                 behavior:
//                                     HitTestBehavior
//                                         .opaque,
//                                 onTap: () async {
//                                   await controller
//                                       .uploadCertificate();
//                                   setState(() {});
//                                   Get.back(
//                                       closeOverlays:
//                                           true);
//                                 },
//                                 child: Text(
//                                   "Choose Files from Phone",
//                                   style: 
//                                       kBlack15Black
//                                       .copyWith(
//                                           color:
//                                               kdarkBlue,
//                                           fontWeight:
//                                               FontWeight
//                                                   .w600,
//                                           fontSize:
//                                               16.0),
//                                 ),
//                               ),
//                               Divider(),
//                             ],
//                           ),
//                           cancel: GestureDetector(
//                             onTap: () {
//                               log("**");
//                               Get.back(
//                                   closeOverlays: true);
//                             },
//                             behavior:
//                                 HitTestBehavior.opaque,
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.all(
//                                       8.0),
//                               child: Text(
//                                 "Cancel",
//                                 style: 
//                                     kBlack15Black
//                                     .copyWith(
//                                         color:
//                                             Colors.red,
//                                         fontSize: 16),
//                               ),
//                             ),
//                           ),
//                           onCancel: () => Get.back());
//                     }
//                   },
//                   shape: RoundedRectangleBorder(
//                       side: const BorderSide(
//                           color: kGrey),
//                       borderRadius:
//                           BorderRadius.circular(5.0)),
//                   color: Colors.white,
//                   child: Text("Upload",
//                       style: kBlack15Black
//                           .copyWith(
//                               fontSize: 15.0,
//                               fontWeight:
//                                   FontWeight.w400)),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(height: 10.0),
//           controller.deathCertificate != null
//               ? ListView.builder(
//                   shrinkWrap: true,
//                   physics:
//                       NeverScrollableScrollPhysics(),
//                   itemCount: controller
//                       .deathCertificate!.length,
//                   itemBuilder: (context, int index) {
//                     return controller.deathCertificate!
//                             .isNotEmpty
//                         ? Row(
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets
//                                         .all(8.0),
//                                 child: GestureDetector(
//                                     child: Text(
//                                       "Preview",
//                                       style: 
//                                           kBlack15Black
//                                           .copyWith(
//                                               fontSize:
//                                                   14.0,
//                                               color:
//                                                   kdarkBlue,
//                                               fontWeight:
//                                                   FontWeight
//                                                       .w700),
//                                     ),
//                                     onTap: () {
//                                       var filePathinPdf;
//
//                                       String s =
//                                           "${controller.deathCertificate![index].toString()}";
//                                       int idx = s
//                                           .indexOf(":");
//                                       List parts = [
//                                         s
//                                             .substring(
//                                                 0, idx)
//                                             .trim(),
//                                         s
//                                             .substring(
//                                                 idx + 1)
//                                             .trim()
//                                       ];
//                                       var str =
//                                           parts[1];
//                                       var find = "'";
//                                       var replaceWith =
//                                           '';
//                                       var newString =
//                                           str.replaceAll(
//                                               find,
//                                               replaceWith);
//                                       var parts1 =
//                                           str.split(
//                                               '${str[0]}');
//                                       filePathinPdf =
//                                           newString;
//                                       Get.to(() =>
//                                           PreviewScreen(
//                                             filePath:
//                                                 filePathinPdf,
//                                             // filePath:  controller
//                                             //     .deathCertificatePath
//                                             //     .value,
//                                           ));
//                                     }),
//                               ),
//                               const Spacer(),
//                               GestureDetector(
//                                 onTap: () {
//                                   controller
//                                       .deathCertificate!
//                                       .removeAt(index);
//
//                                   setState(() {});
//                                 },
//                                 child: const Icon(
//                                   Icons.delete,
//                                   color: klightBlue,
//                                   size: 20,
//                                 ),
//                               )
//                             ],
//                           )
//                         : SizedBox();
//                   })
//               : SizedBox(),
//           Obx(() => controller
//                   .deathCertificatePath.value.isNotEmpty
//               ? Row(
//                   children: [
//                     GestureDetector(
//                       child: Text(
//                         "Preview",
//                         style: kBlack15Black
//                             .copyWith(
//                                 fontSize: 14.0,
//                                 color: kdarkBlue,
//                                 fontWeight:
//                                     FontWeight.w700),
//                       ),
//                       onTap: () =>
//                           Get.to(() => PreviewScreen(
//                                 filePath: controller
//                                     .deathCertificatePath
//                                     .value,
//                               )),
//                     ),
//                     const Spacer(),
//                     GestureDetector(
//                       onTap: () {
//                         controller.dealthCertificate
//                             .value = "";
//                         controller.deathCertificatePath
//                             .value = "";
//                       },
//                       child: const Icon(
//                         Icons.delete,
//                         color: klightBlue,
//                         size: 20,
//                       ),
//                     )
//                   ],
//                 )
//               : SizedBox()),
//           const SizedBox(
//             height: 10.0,
//           ),
//           Text(
//             "KYC - Proof Borrower",
//             style: kBlack15Black.copyWith(
//                 fontSize: 15.0,
//                 fontWeight: FontWeight.w900,
//                 color: Colors.black),
//           ),
//           const SizedBox(
//             height: 10.0,
//           ),
//           Row(
//             children: [
//               smallText(text: "Id Proof"),
//               Text(
//                 " * ",
//                 style: TextStyle(color: Colors.red),
//               )
//             ],
//           ),
//           smallText(
//               text:
//                   "(atleast one document is mandatory)"),
//           Text(
//               "${controller.claimDetail.value["claimDocuments"][0]["borrowerKycProof"].toString() == "UPLOADED" ? controller.claimDetail.value["claimDocuments"][0]["borrowerKycProof"].toString() : ""}"),
//           Container(
//             decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius:
//                     BorderRadius.circular(1.0),
//                 border: Border.all(color: kGrey)),
//             child: Obx(() => DropdownButton<String>(
//                   isExpanded: true,
//                   hint: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: controller.borroweridProof
//                             .value.isNotEmpty
//                         ? Text(
//                             controller
//                                 .borroweridProof.value,
//                             style: 
//                                 kBlack15Black
//                                 .copyWith(
//                                     fontSize: 14.0),
//                           )
//                         : Text(
//                             "Select Document Type",
//                             style: 
//                                 kBlack15Black
//                                 .copyWith(
//                                     fontSize: 14.0),
//                           ),
//                   ),
//                   underline: const SizedBox(),
//                   items: <String>[
//                     'Aadhar Card',
//                     'Passport',
//                     'Voter card',
//                     'Driving License',
//                     "Ration Card ",
//                     'Pan Card',
//                     'Any other Govt Id card ',
//                     'Other',
//                   ].map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     controller.borroweridProof.value =
//                         value!;
//                   },
//                 )),
//           ),
//           const SizedBox(
//             height: 10.0,
//           ),
//           Container(
//             height: 40.0.h,
//             decoration: BoxDecoration(
//                 color: Colors.grey.shade50,
//                 borderRadius:
//                     BorderRadius.circular(5.0),
//                 border: Border.all(
//                   color: kGrey,
//                 )),
//             child: Row(
//               children: [
//                 Flexible(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Obx(() => Text(
//                           "${controller.borroweridProofDoc.value}",
//                           style: 
//                               kBlack15Black
//                               .copyWith(
//                                   fontWeight:
//                                       FontWeight.w600,
//                                   fontSize: 14.0),
//                         )),
//                   ),
//                   fit: FlexFit.tight,
//                 ),
//                 const Spacer(),
//                 MaterialButton(
//                   elevation: 1.0,
//                   onPressed: () async {
//                     if (controller
//                             .claimDetail
//                             .value["claimDocuments"][0]
//                                 ["borrowerKycProof"]
//                             .toString() ==
//                         "UPLOADED") {
//                       Fluttertoast.showToast(
//                           msg:
//                               "Already Under Verification",
//                           toastLength:
//                               Toast.LENGTH_SHORT,
//                           gravity: ToastGravity.BOTTOM,
//                           timeInSecForIosWeb: 1,
//                           backgroundColor: Colors.red,
//                           textColor: Colors.white,
//                           fontSize: 16.0);
//                     } else {
//                       Get.defaultDialog(
//                           title: "Upload",
//                           titleStyle: 
//                               kBlack15Black
//                               .copyWith(
//                                   color: Colors.black,
//                                   fontSize: 20.0,
//                                   fontWeight:
//                                       FontWeight.bold),
//                           content: Column(
//                             mainAxisSize:
//                                 MainAxisSize.min,
//                             crossAxisAlignment:
//                                 CrossAxisAlignment
//                                     .center,
//                             mainAxisAlignment:
//                                 MainAxisAlignment
//                                     .center,
//                             children: [
//                               Divider(),
//                               GestureDetector(
//                                 onTap: () async {
//                                   var file =
//                                       await controller
//                                           .imageFromCamera();
//                                   print(file);
//                                   controller
//                                           .borroweridProofDoc
//                                           .value =
//                                       basename(file);
//                                   controller
//                                       .borrowerIdDocPath
//                                       .value = file;
//                                   Get.back(
//                                       closeOverlays:
//                                           true);
//                                 },
//                                 child: Text(
//                                   "Take Photo ...",
//                                   style: 
//                                       kBlack15Black
//                                       .copyWith(
//                                           color:
//                                               kdarkBlue,
//                                           fontWeight:
//                                               FontWeight
//                                                   .w600,
//                                           fontSize:
//                                               16.0),
//                                 ),
//                               ),
//                               Divider(),
//                               GestureDetector(
//                                 behavior:
//                                     HitTestBehavior
//                                         .opaque,
//                                 onTap: () async {
//                                   // var file =
//                                   //     await controller
//                                   //         .uploadFile();
//                                   // controller
//                                   //         .borroweridProofDoc
//                                   //         .value =
//                                   //     basename(file);
//                                   // controller
//                                   //     .borrowerIdDocPath
//                                   //     .value = file;
//
//                                   await controller
//                                       .uploadBorrowerProof();
//                                   setState(() {});
//                                   Get.back(
//                                       closeOverlays:
//                                           true);
//                                 },
//                                 child: Text(
//                                   "Choose Files from Phone",
//                                   style: 
//                                       kBlack15Black
//                                       .copyWith(
//                                           color:
//                                               kdarkBlue,
//                                           fontWeight:
//                                               FontWeight
//                                                   .w600,
//                                           fontSize:
//                                               16.0),
//                                 ),
//                               ),
//                               Divider(),
//                             ],
//                           ),
//                           cancel: GestureDetector(
//                             onTap: () {
//                               Get.back(
//                                   closeOverlays: true);
//                             },
//                             behavior:
//                                 HitTestBehavior.opaque,
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.all(
//                                       8.0),
//                               child: Text(
//                                 "Cancel",
//                                 style: 
//                                     kBlack15Black
//                                     .copyWith(
//                                         color:
//                                             Colors.red,
//                                         fontSize: 16),
//                               ),
//                             ),
//                           ),
//                           onCancel: () => Get.back());
//                     }
//                   },
//                   shape: RoundedRectangleBorder(
//                       side: const BorderSide(
//                           color: kGrey),
//                       borderRadius:
//                           BorderRadius.circular(5.0)),
//                   color: Colors.white,
//                   child: Text("Upload",
//                       style: kBlack15Black
//                           .copyWith(
//                               fontSize: 15.0,
//                               fontWeight:
//                                   FontWeight.w400)),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(height: 10.0),
//           controller.borrowerProof != null
//               ? ListView.builder(
//                   shrinkWrap: true,
//                   physics:
//                       NeverScrollableScrollPhysics(),
//                   itemCount:
//                       controller.borrowerProof!.length,
//                   itemBuilder: (context, int index) {
//                     return controller
//                             .borrowerProof!.isNotEmpty
//                         ? Row(
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets
//                                         .all(8.0),
//                                 child: GestureDetector(
//                                     child: Text(
//                                       "Preview",
//                                       style: 
//                                           kBlack15Black
//                                           .copyWith(
//                                               fontSize:
//                                                   14.0,
//                                               color:
//                                                   kdarkBlue,
//                                               fontWeight:
//                                                   FontWeight
//                                                       .w700),
//                                     ),
//                                     onTap: () {
//                                       var filePathinPdf;
//
//                                       String s =
//                                           "${controller.borrowerProof![index].toString()}";
//                                       int idx = s
//                                           .indexOf(":");
//                                       List parts = [
//                                         s
//                                             .substring(
//                                                 0, idx)
//                                             .trim(),
//                                         s
//                                             .substring(
//                                                 idx + 1)
//                                             .trim()
//                                       ];
//                                       var str =
//                                           parts[1];
//                                       var find = "'";
//                                       var replaceWith =
//                                           '';
//                                       var newString =
//                                           str.replaceAll(
//                                               find,
//                                               replaceWith);
//                                       var parts1 =
//                                           str.split(
//                                               '${str[0]}');
//                                       filePathinPdf =
//                                           newString;
//                                       Get.to(() =>
//                                           PreviewScreen(
//                                             filePath:
//                                                 filePathinPdf,
//                                             // filePath:  controller
//                                             //     .deathCertificatePath
//                                             //     .value,
//                                           ));
//                                     }),
//                               ),
//                               const Spacer(),
//                               GestureDetector(
//                                 onTap: () {
//                                   controller
//                                       .borrowerProof!
//                                       .removeAt(index);
//
//                                   setState(() {});
//                                 },
//                                 child: const Icon(
//                                   Icons.delete,
//                                   color: klightBlue,
//                                   size: 20,
//                                 ),
//                               )
//                             ],
//                           )
//                         : SizedBox();
//                   })
//               : SizedBox(),
//           Obx(() => controller
//                   .borrowerIdDocPath.value.isNotEmpty
//               ? Row(
//                   children: [
//                     GestureDetector(
//                       child: Text(
//                         "Preview",
//                         style: kBlack15Black
//                             .copyWith(
//                                 fontSize: 14.0,
//                                 color: kdarkBlue,
//                                 fontWeight:
//                                     FontWeight.w700),
//                       ),
//                       onTap: () =>
//                           Get.to(() => PreviewScreen(
//                                 filePath: controller
//                                     .borrowerIdDocPath
//                                     .value,
//                               )),
//                     ),
//                     const Spacer(),
//                     GestureDetector(
//                       onTap: () {
//                         controller.borroweridProofDoc
//                             .value = "";
//                         controller.borrowerIdDocPath
//                             .value = "";
//                       },
//                       child: const Icon(
//                         Icons.delete,
//                         color: klightBlue,
//                         size: 20,
//                       ),
//                     )
//                   ],
//                 )
//               : SizedBox()),
//           const SizedBox(
//             height: 10.0,
//           ),
//
//           ///new changes by sangam
//
//           Text(
//             "Agent - Remarks",
//             style: kBlack15Black.copyWith(
//                 fontSize: 15.0,
//                 fontWeight: FontWeight.w900,
//                 color: Colors.black),
//           ),
//           const SizedBox(
//             height: 10.0,
//           ),
//
//           smallText(text: "Choose a valid reason"),
//
//           Container(
//             decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius:
//                     BorderRadius.circular(1.0),
//                 border: Border.all(color: kGrey)),
//             child: Obx(() => DropdownButton<String>(
//                   isExpanded: true,
//                   hint: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: controller
//                             .agentRemarkDropDownValue
//                             .value
//                             .isNotEmpty
//                         ? Text(
//                             controller
//                                 .agentRemarkDropDownValue
//                                 .value,
//                             style: 
//                                 kBlack15Black
//                                 .copyWith(
//                                     fontSize: 14.0),
//                           )
//                         : Text(
//                             "Select valid reason",
//                             style: 
//                                 kBlack15Black
//                                 .copyWith(
//                                     fontSize: 14.0),
//                           ),
//                   ),
//                   underline: const SizedBox(),
//                   items: <String>[
//                     'Mobile number not reachable',
//                     'Address is not correct',
//                     'Client not available',
//                     'Document not available',
//                   ].map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     controller.agentRemarkDropDownValue
//                         .value = value!;
//                   },
//                 )),
//           ),
//           const SizedBox(
//             height: 10.0,
//           ),
//
//           Obx(()=>controller.agentRemarkDropDownValue.value!=null?MaterialButton(
//             onPressed: () {
//               controller.agentRemarkDropDownValue.value = "";
//             },
//             color: kdarkBlue,
//             child: Text(
//               "Remove agent remark",
//               style: kBlack15Black
//                   .copyWith(color: Colors.white),
//             ),
//           ):SizedBox(),),
//
//
//
//           Center(
//             child: MaterialButton(
//               onPressed: () {
//                 //if (controller.nominee.value ==
//                 //     "Minor") {
//                 //   if (controller.minor.length >= 3) {
//                 //     if (controller.causeofDeath.value
//                 //             .isNotEmpty &&
//                 //         controller
//                 //             .filledPath.value.isNotEmpty &&
//                 //         controller.dealthCertificate
//                 //             .value.isNotEmpty &&
//                 //         controller.borroweridProofDoc
//                 //             .value.isNotEmpty &&
//                 //         controller.borrowerIdDocPath
//                 //             .value.isNotEmpty) {
//                 //       controller.uploadFormData();
//                 //     } else {
//                 //       log("${controller.borroweridProofDoc.value.isNotEmpty && controller.borrowerIdDocPath.value.isNotEmpty}");
//                 //       Fluttertoast.showToast(
//                 //           msg:
//                 //               "Please update all mandatory fields",
//                 //           toastLength:
//                 //               Toast.LENGTH_SHORT,
//                 //           gravity: ToastGravity.BOTTOM,
//                 //           timeInSecForIosWeb: 1,
//                 //           backgroundColor: Colors.red,
//                 //           textColor: Colors.white,
//                 //           fontSize: 16.0);
//                 //     }
//                 //   } else {
//                 //     Fluttertoast.showToast(
//                 //         msg:
//                 //             "Please update atleast 3 documents for minor",
//                 //         toastLength: Toast.LENGTH_SHORT,
//                 //         gravity: ToastGravity.BOTTOM,
//                 //         timeInSecForIosWeb: 1,
//                 //         backgroundColor: Colors.red,
//                 //         textColor: Colors.white,
//                 //         fontSize: 16.0);
//                 //   }
//                 // } else if (controller.causeofDeath.value
//                 //         .isNotEmpty ||
//                 //     controller
//                 //         .filledPath.value.isNotEmpty ||
//                 //     controller.dealthCertificate.value
//                 //         .isNotEmpty ||
//                 //     controller.borroweridProof.value
//                 //         .isNotEmpty ||
//                 //     controller.borrowerIdDocPath.value
//                 //         .isNotEmpty) {
//                 if (controller.claimDetail
//                             .value["claimData"]
//                         ["causeOfDeath"] !=
//                     null) {
//                   controller.causeofDeath.value =
//                       controller.claimDetail
//                               .value["claimData"]
//                           ["causeOfDeath"];
//                   controller.uploadFormData();
//                 }
//                else if (controller.causeofDeath.value ==
//                     null || controller.causeofDeath.value ==
//                     "null" ||controller.causeofDeath.value =="") {
//
//                   Fluttertoast.showToast(
//                       msg: "Cause of Death can't be Empty",
//                       toastLength: Toast.LENGTH_SHORT,
//                       gravity: ToastGravity.BOTTOM,
//                       timeInSecForIosWeb: 1,
//                       backgroundColor: Colors.red,
//                       textColor: Colors.white,
//                       fontSize: 16.0);
//                 }
//               else   if (controller.agentRemarkDropDownValue
//                     .value.isNotEmpty) {
//                   controller.uploadFormData();
//                 }
//                 else{
//                   print("Object !");
//                   controller.uploadFormData();
//                 }
//
//
//                 //  }
//               },
//               color: kdarkBlue,
//               child: Text(
//                 "Save ",
//                 style: kBlack15Black
//                     .copyWith(color: Colors.white),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10.0,
//           ),
//         ],
//       ),
//       Divider(),
//       const SizedBox(
//         height: 10.0,
//       ),
//     ],
//   ),
// ),