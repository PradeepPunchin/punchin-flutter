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
import 'package:punchin/views/claim_form_view/preview_screen.dart';

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
    'Relationship Proof *',
    'Guardian - Id proof *',
    'Guardian - Add proof *',
    'Other Document',
  ];

  List<String> medicialList = <String>[
    'Medical Records *',
    'Other Document',
  ];

  List<String> accientList = <String>[
    'Police FIR Copy *',
    'Other Document',
  ];

  List<String> sickList = <String>[
    'Medical Attendant Certificate *',
    'Other Document',
  ];

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
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () async {
              Get.off(() => Details(
                    title: '${dataArg[0]}',
                  ));
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
                "Case/Claim ID : ${controller.claimDetail.value["punchinClaimId"]} ",
                style: CustomFonts.kBlack15Black.copyWith(
                    color: Colors.white,
                    fontSize: 8.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          actions: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white10,
              radius: 48.0,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: kLightGrey,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Icon(
                      Icons.notifications_none,
                      color: Colors.grey,
                    ),
                  )),
            ),
          ]),
      body: customStepperForm(),
    );
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
                  SizedBox(
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
                                style: CustomFonts.kBlack15Black.copyWith(
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
                                  text: controller
                                      .claimDetail.value["borrowerName"]
                                      .toString()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Date of Birth"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller.claimDetail
                                              .value["borrowerDob"] !=
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
                                  text: controller.claimDetail
                                      .value["borrowerContactNumber"]),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Email Id"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller
                                      .claimDetail.value["borrowerEmailId"]),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Address"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              addressField(
                                  text: controller
                                      .claimDetail.value["borrowerAddress"])
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
                                style: CustomFonts.kBlack15Black.copyWith(
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
                                  text: controller
                                      .claimDetail.value["loanAccountNumber"]),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Loan Type / Category"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text:
                                      controller.claimDetail.value["loanType"]),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Loan O/S Amt"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller
                                      .claimDetail.value["loanAmount"]
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
                                      .value["loanAccountManagerName"]
                                      .toString()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Lender RM Name"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller.claimDetail
                                      .value["loanAccountManagerName"]
                                      .toString()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Lender RM Number"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller.claimDetail
                                      .value["accountManagerContactNumber"]
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
                                style: CustomFonts.kBlack15Black.copyWith(
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
                                  text: controller
                                      .claimDetail.value["insurerName"]),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Borrower Policy Number"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller
                                      .claimDetail.value["policyNumber"]),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Master Policy Number"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller
                                      .claimDetail.value["masterPolNumber"]),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Policy Start Date"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller.claimDetail
                                              .value["policyStartDate"] !=
                                          null
                                      ? dateChange(controller
                                          .claimDetail.value["policyStartDate"])
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
                                  text: controller.claimDetail
                                      .value["policyCoverageDuration"]
                                      .toString()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Policy Sum Assured"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller
                                      .claimDetail.value["policySumAssured"]
                                      .toString()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Nominee Name"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller
                                      .claimDetail.value["nomineeName"]
                                      .toString()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Nominee Relationship"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller
                                      .claimDetail.value["nomineeRelationShip"]
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
                                      .claimDetail.value["nomineeContactNumber"]
                                      .toString()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              smallText(text: "Email Id"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              field(
                                  text: controller
                                      .claimDetail.value["nomineeEmailId"])
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
                                  Text(
                                    "Documentation Upload",
                                    style: CustomFonts.kBlack15Black.copyWith(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 15.0.h,
                                  ),
                                  smallText(
                                      text: "Cause of Death (Life Insurance)"),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius:
                                            BorderRadius.circular(1.0),
                                        border: Border.all(color: kGrey)),
                                    child: Obx(() => DropdownButton<String>(
                                          isExpanded: true,
                                          hint: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: controller.causeofDeath.value
                                                    .isNotEmpty
                                                ? Text(
                                                    controller
                                                        .causeofDeath.value,
                                                    style: CustomFonts
                                                        .kBlack15Black
                                                        .copyWith(
                                                            fontSize: 14.0),
                                                  )
                                                : Text(
                                                    "Choose The Cause ",
                                                    style: CustomFonts
                                                        .kBlack15Black
                                                        .copyWith(
                                                            fontSize: 14.0),
                                                  ),
                                          ),
                                          underline: const SizedBox(),
                                          items: <String>[
                                            'Accident',
                                            'Natural Death',
                                            'Suicide',
                                            'Illness &  Medical Reason',
                                            'Dealth due to Natural Calamity'
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            controller.causeofDeath.value =
                                                value!;
                                          },
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  smallText(text: "Is Nominee "),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  nominee(),
                                  Obx(() => controller.nominee.value == "Minor"
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(1.0),
                                              border: Border.all(color: kGrey)),
                                          child:
                                              Obx(() => DropdownButton<String>(
                                                    isExpanded: true,
                                                    hint: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: controller
                                                              .minorDropdown
                                                              .value
                                                              .isNotEmpty
                                                          ? Text(
                                                              controller
                                                                  .minorDropdown
                                                                  .value,
                                                              style: CustomFonts
                                                                  .kBlack15Black
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14.0),
                                                            )
                                                          : Text(
                                                              "Select Document Type",
                                                              style: CustomFonts
                                                                  .kBlack15Black
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14.0),
                                                            ),
                                                    ),
                                                    underline: const SizedBox(),
                                                    items: minorList
                                                        // <String>[
                                                        //   'Police FIR Copy',
                                                        //   'Postmortem Report',
                                                        //   'Income Tax Returns',
                                                        //   'Medical Records',
                                                        //   'Legal Heir Certificate',
                                                        //   'Police Investigation Report',
                                                        //   'Relationship Proof',
                                                        //   'Stamped Affidavit',
                                                        //   'Medical Attendant Certificate',
                                                        //   'Guardian - Id proof',
                                                        //   'Guardian - Add proof',
                                                        //   'Any utility bill (gas / electricity / rental agreement)',
                                                        //   'Other Document',
                                                        //   // 'Income Tax Return',
                                                        //   // 'Medical Records',
                                                        //   // 'Legal Heir Certificate',
                                                        //   // 'Police Investigation Report',
                                                        //   // 'Other',
                                                        // ]
                                                        .map((String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      controller.minorDropdown
                                                          .value = value!;
                                                    },
                                                  )),
                                        )
                                      : SizedBox()),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Obx(() => controller.nominee.value == "Minor"
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            smallText(
                                                text:
                                                    "Additional Document for Minor"),
                                            Text(controller.minor.value.length
                                                .toString()),
                                            Text(controller.minorNominee.value
                                                .toString()),
                                            Text(controller.minorImage.value
                                                .toString()),
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
                                                    fit: FlexFit.tight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Obx(() => Text(
                                                            "${controller.minorProofPath.value}",
                                                            style: CustomFonts
                                                                .kBlack15Black
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
                                                      if (controller.minor.value
                                                          .contains(controller
                                                              .minorNominee
                                                              .value)) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "File Already Exists ! Please Choose Another",
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
                                                      } else if (controller
                                                              .minor.value
                                                              .contains(
                                                                  controller
                                                                      .minorProof
                                                                      .value) &&
                                                          controller.minor.value
                                                                  .length <
                                                              3) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Add Mandatory Documents",
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
                                                      } else if (controller
                                                              .claimDetail
                                                              .value[
                                                                  "claimStatus"]
                                                              .toString() ==
                                                          "UNDER_VERIFICATION") {
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
                                                            titleStyle: CustomFonts
                                                                .kBlack15Black
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
                                                                    if (controller
                                                                        .minorNominee
                                                                        .contains(controller
                                                                            .minorDropdown
                                                                            .value)) {
                                                                      Fluttertoast.showToast(
                                                                          msg:
                                                                              "Already Exit Record for Selected Dropdown",
                                                                          toastLength: Toast
                                                                              .LENGTH_SHORT,
                                                                          gravity: ToastGravity
                                                                              .BOTTOM,
                                                                          timeInSecForIosWeb:
                                                                              1,
                                                                          backgroundColor: Colors
                                                                              .red,
                                                                          textColor: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16.0);
                                                                    } else {
                                                                      var file =
                                                                          await controller
                                                                              .imageFromCamera();

                                                                      if (controller
                                                                              .minorDropdown
                                                                              .value ==
                                                                          "Relationship Proof *") {
                                                                        controller
                                                                            .minorProof
                                                                            .value = basename(file);
                                                                        controller
                                                                            .RelationProof
                                                                            .value = file;
                                                                        Get.back(
                                                                            closeOverlays:
                                                                                true);
                                                                        controller.addProductLot(
                                                                            selectedValue:
                                                                                controller.minorProof.value,
                                                                            imagePath: controller.RelationProof.value,
                                                                            dropDownValue: controller.minorDropdown.value);
                                                                      } else if (controller
                                                                              .minorDropdown
                                                                              .value ==
                                                                          "Guardian - Id proof *") {
                                                                        controller
                                                                            .minorProof
                                                                            .value = basename(file);
                                                                        controller
                                                                            .GUARDIAN_ID_PROOF
                                                                            .value = file;
                                                                        Get.back(
                                                                            closeOverlays:
                                                                                true);
                                                                        controller.addProductLot(
                                                                            selectedValue:
                                                                                controller.minorProof.value,
                                                                            imagePath: controller.GUARDIAN_ID_PROOF.value,
                                                                            dropDownValue: controller.minorDropdown.value);
                                                                      } else if (controller
                                                                              .minorDropdown
                                                                              .value ==
                                                                          "Guardian - Add proof *") {
                                                                        controller
                                                                            .minorProof
                                                                            .value = basename(file);
                                                                        controller
                                                                            .GUARDIAN_ADD_PROOF
                                                                            .value = file;
                                                                        Get.back(
                                                                            closeOverlays:
                                                                                true);
                                                                        controller.addProductLot(
                                                                            selectedValue:
                                                                                controller.minorProof.value,
                                                                            imagePath: controller.GUARDIAN_ADD_PROOF.value,
                                                                            dropDownValue: controller.minorDropdown.value);
                                                                      } else if (controller
                                                                              .minorDropdown
                                                                              .value ==
                                                                          "Other Document") {
                                                                        controller
                                                                            .minorProof
                                                                            .value = basename(file);
                                                                        controller
                                                                            .minorProofPath
                                                                            .value = file;
                                                                        Get.back(
                                                                            closeOverlays:
                                                                                true);
                                                                        controller.addProductLot(
                                                                            selectedValue:
                                                                                controller.minorProof.value,
                                                                            imagePath: controller.minorProofPath.value,
                                                                            dropDownValue: controller.minorDropdown.value);
                                                                      }
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                    "Take Photo ...",
                                                                    style: CustomFonts.kBlack15Black.copyWith(
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
                                                                    if (controller
                                                                        .minorNominee
                                                                        .contains(controller
                                                                            .minorDropdown
                                                                            .value)) {
                                                                      Fluttertoast.showToast(
                                                                          msg:
                                                                              "Already Exit Record for Selected Dropdown",
                                                                          toastLength: Toast
                                                                              .LENGTH_SHORT,
                                                                          gravity: ToastGravity
                                                                              .BOTTOM,
                                                                          timeInSecForIosWeb:
                                                                              1,
                                                                          backgroundColor: Colors
                                                                              .red,
                                                                          textColor: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16.0);
                                                                    } else {
                                                                      var file =
                                                                          await controller
                                                                              .uploadFile();

                                                                      controller
                                                                              .minorProof
                                                                              .value =
                                                                          basename(
                                                                              file);
                                                                      controller
                                                                          .minorProofPath
                                                                          .value = file;

                                                                      Get.back(
                                                                          closeOverlays:
                                                                              true);
                                                                      controller.addProductLot(
                                                                          imagePath: controller
                                                                              .minorProofPath
                                                                              .value,
                                                                          selectedValue: controller
                                                                              .minorProof
                                                                              .value,
                                                                          dropDownValue: controller
                                                                              .minorDropdown
                                                                              .value);
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                    "Choose Files from Phone",
                                                                    style: CustomFonts.kBlack15Black.copyWith(
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
                                                                  style: CustomFonts
                                                                      .kBlack15Black
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
                                                        style: CustomFonts
                                                            .kBlack15Black
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
                                          ],
                                        )
                                      : const SizedBox()),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: controller.minorImage.length,
                                      itemBuilder: (context, int index) {
                                        return Obx(() => controller
                                                    .nominee.value.isNotEmpty ||
                                                controller.nominee.value ==
                                                    "Minor"
                                            ? Row(
                                                children: [
                                                  GestureDetector(
                                                    child: Text(
                                                      "Preview",
                                                      style: CustomFonts
                                                          .kBlack15Black
                                                          .copyWith(
                                                              fontSize: 14.0,
                                                              color: kdarkBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                    onTap: () => Get.to(
                                                        () => PreviewScreen(
                                                              filePath: controller
                                                                  .minorImage
                                                                  .value[index],
                                                            )),
                                                  ),
                                                  const Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller
                                                          .firProof.value = "";
                                                      controller
                                                          .firOrPostmortemReportPath
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
                                          text: "Filled & Signed Claim form"),
                                      Text(
                                        " * ",
                                        style: TextStyle(color: Colors.red),
                                      )
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
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color: kGrey,
                                        )),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 8),
                                            child: Obx(() => Text(
                                                  "${controller.filled.value}",
                                                  style: CustomFonts
                                                      .kBlack15Black
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
                                                  msg:
                                                      "Already Under Verification",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else {
                                              Get.defaultDialog(
                                                  title: "Upload",
                                                  titleStyle: CustomFonts
                                                      .kBlack15Black
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Divider(),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          var file =
                                                              await controller
                                                                  .imageFromCamera();
                                                          controller.filled
                                                                  .value =
                                                              basename(file);
                                                          controller.filledPath
                                                              .value = file;
                                                          Get.back(
                                                              closeOverlays:
                                                                  true);
                                                        },
                                                        child: Text(
                                                          "Take Photo ...",
                                                          style: CustomFonts
                                                              .kBlack15Black
                                                              .copyWith(
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
                                                        onTap: () async {
                                                          var file =
                                                              await controller
                                                                  .uploadFile();
                                                          print(file);
                                                          controller.filled
                                                                  .value =
                                                              basename(file);
                                                          controller.filledPath
                                                              .value = file;
                                                          Get.back(
                                                              closeOverlays:
                                                                  true);
                                                        },
                                                        child: Text(
                                                          "Choose Files from Phone",
                                                          style: CustomFonts
                                                              .kBlack15Black
                                                              .copyWith(
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
                                                  cancel: GestureDetector(
                                                    onTap: () {
                                                      log("**");
                                                      Get.back(
                                                          closeOverlays: true);
                                                    },
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Cancel",
                                                        style: CustomFonts
                                                            .kBlack15Black
                                                            .copyWith(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                  onCancel: () => Get.back());
                                            }
                                          },
                                          shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: kGrey),
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          color: Colors.white,
                                          child: Text("Upload",
                                              style: CustomFonts.kBlack15Black
                                                  .copyWith(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Obx(() => controller
                                          .filledPath.value.isNotEmpty
                                      ? Row(
                                          children: [
                                            GestureDetector(
                                              child: Text(
                                                "Preview",
                                                style: CustomFonts.kBlack15Black
                                                    .copyWith(
                                                        fontSize: 14.0,
                                                        color: kdarkBlue,
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                              onTap: () {
                                                print("Resting " +
                                                    controller
                                                        .filledPath.value);

                                                Get.to(
                                                  () => PreviewScreen(
                                                    filePath: controller
                                                        .filledPath.value,
                                                  ),
                                                );
                                              },
                                            ),
                                            Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                controller.filled.value = "";
                                                controller.filledPath.value =
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
                                  Row(
                                    children: [
                                      smallText(text: "Death Certificate"),
                                      Text(
                                        " * ",
                                        style: TextStyle(color: Colors.red),
                                      )
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
                                            BorderRadius.circular(5.0),
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
                                                      .dealthCertificate.value,
                                                  style: CustomFonts
                                                      .kBlack15Black
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
                                                  msg:
                                                      "Already Under Verification",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else {
                                              Get.defaultDialog(
                                                  title: "Upload",
                                                  titleStyle: CustomFonts
                                                      .kBlack15Black
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Divider(),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          var file =
                                                              await controller
                                                                  .imageFromCamera();
                                                          controller
                                                                  .dealthCertificate
                                                                  .value =
                                                              basename(file);
                                                          controller
                                                              .deathCertificatePath
                                                              .value = file;
                                                          Get.back(
                                                              closeOverlays:
                                                                  true);
                                                        },
                                                        child: Text(
                                                          "Take Photo ...",
                                                          style: CustomFonts
                                                              .kBlack15Black
                                                              .copyWith(
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
                                                        onTap: () async {
                                                          var file =
                                                              await controller
                                                                  .uploadFile();
                                                          print(file);
                                                          controller
                                                                  .dealthCertificate
                                                                  .value =
                                                              basename(file);
                                                          controller
                                                              .deathCertificatePath
                                                              .value = file;
                                                          Get.back(
                                                              closeOverlays:
                                                                  true);
                                                        },
                                                        child: Text(
                                                          "Choose Files from Phone",
                                                          style: CustomFonts
                                                              .kBlack15Black
                                                              .copyWith(
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
                                                  cancel: GestureDetector(
                                                    onTap: () {
                                                      log("**");
                                                      Get.back(
                                                          closeOverlays: true);
                                                    },
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Cancel",
                                                        style: CustomFonts
                                                            .kBlack15Black
                                                            .copyWith(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                  onCancel: () => Get.back());
                                            }
                                          },
                                          shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: kGrey),
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          color: Colors.white,
                                          child: Text("Upload",
                                              style: CustomFonts.kBlack15Black
                                                  .copyWith(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Obx(() => controller
                                          .deathCertificatePath.value.isNotEmpty
                                      ? Row(
                                          children: [
                                            GestureDetector(
                                              child: Text(
                                                "Preview",
                                                style: CustomFonts.kBlack15Black
                                                    .copyWith(
                                                        fontSize: 14.0,
                                                        color: kdarkBlue,
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                              onTap: () =>
                                                  Get.to(() => PreviewScreen(
                                                        filePath: controller
                                                            .deathCertificatePath
                                                            .value,
                                                      )),
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                controller.dealthCertificate
                                                    .value = "";
                                                controller.deathCertificatePath
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
                                    style: CustomFonts.kBlack15Black.copyWith(
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
                                      text:
                                          "(atleast one  document is mandatory)"),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius:
                                            BorderRadius.circular(1.0),
                                        border: Border.all(color: kGrey)),
                                    child: Obx(() => DropdownButton<String>(
                                          isExpanded: true,
                                          hint: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: controller.borroweridProof
                                                    .value.isNotEmpty
                                                ? Text(
                                                    controller
                                                        .borroweridProof.value,
                                                    style: CustomFonts
                                                        .kBlack15Black
                                                        .copyWith(
                                                            fontSize: 14.0),
                                                  )
                                                : Text(
                                                    "Select Document Type",
                                                    style: CustomFonts
                                                        .kBlack15Black
                                                        .copyWith(
                                                            fontSize: 14.0),
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
                                            controller.borroweridProof.value =
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
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color: kGrey,
                                        )),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Obx(() => Text(
                                                  "${controller.borroweridProofDoc.value}",
                                                  style: CustomFonts
                                                      .kBlack15Black
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
                                            if (controller.claimDetail
                                                    .value["claimStatus"]
                                                    .toString() ==
                                                "UNDER_VERIFICATION") {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Already Under Verification",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else {
                                              Get.defaultDialog(
                                                  title: "Upload",
                                                  titleStyle: CustomFonts
                                                      .kBlack15Black
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Divider(),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          var file =
                                                              await controller
                                                                  .imageFromCamera();
                                                          print(file);
                                                          controller
                                                                  .borroweridProofDoc
                                                                  .value =
                                                              basename(file);
                                                          controller
                                                              .borrowerIdDocPath
                                                              .value = file;
                                                          Get.back(
                                                              closeOverlays:
                                                                  true);
                                                        },
                                                        child: Text(
                                                          "Take Photo ...",
                                                          style: CustomFonts
                                                              .kBlack15Black
                                                              .copyWith(
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
                                                        onTap: () async {
                                                          var file =
                                                              await controller
                                                                  .uploadFile();
                                                          controller
                                                                  .borroweridProofDoc
                                                                  .value =
                                                              basename(file);
                                                          controller
                                                              .borrowerIdDocPath
                                                              .value = file;
                                                          Get.back(
                                                              closeOverlays:
                                                                  true);
                                                        },
                                                        child: Text(
                                                          "Choose Files from Phone",
                                                          style: CustomFonts
                                                              .kBlack15Black
                                                              .copyWith(
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
                                                  cancel: GestureDetector(
                                                    onTap: () {
                                                      Get.back(
                                                          closeOverlays: true);
                                                    },
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Cancel",
                                                        style: CustomFonts
                                                            .kBlack15Black
                                                            .copyWith(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                  onCancel: () => Get.back());
                                            }
                                          },
                                          shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: kGrey),
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          color: Colors.white,
                                          child: Text("Upload",
                                              style: CustomFonts.kBlack15Black
                                                  .copyWith(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Obx(() => controller
                                          .borrowerIdDocPath.value.isNotEmpty
                                      ? Row(
                                          children: [
                                            GestureDetector(
                                              child: Text(
                                                "Preview",
                                                style: CustomFonts.kBlack15Black
                                                    .copyWith(
                                                        fontSize: 14.0,
                                                        color: kdarkBlue,
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                              onTap: () =>
                                                  Get.to(() => PreviewScreen(
                                                        filePath: controller
                                                            .borrowerIdDocPath
                                                            .value,
                                                      )),
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                controller.borroweridProofDoc
                                                    .value = "";
                                                controller.borrowerIdDocPath
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
                                    child: MaterialButton(
                                      onPressed: () {
                                        if (controller.nominee.value ==
                                            "Minor") {
                                          if (controller.minor.length >= 3) {
                                            if (controller.causeofDeath.value
                                                    .isNotEmpty &&
                                                controller
                                                    .filledPath.value.isNotEmpty &&
                                                controller.dealthCertificate
                                                    .value.isNotEmpty &&
                                                controller.borroweridProofDoc
                                                    .value.isNotEmpty &&
                                                controller.borrowerIdDocPath
                                                    .value.isNotEmpty) {
                                              controller.uploadFormData();
                                            } else {
                                              log("${controller.borroweridProofDoc.value.isNotEmpty && controller.borrowerIdDocPath.value.isNotEmpty}");
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please update all mandatory fields",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Please update atleast 3 documents for minor",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        } else if (controller.causeofDeath.value
                                                .isNotEmpty ||
                                            controller
                                                .filledPath.value.isNotEmpty ||
                                            controller.dealthCertificate.value
                                                .isNotEmpty ||
                                            controller.borroweridProof.value
                                                .isNotEmpty ||
                                            controller.borrowerIdDocPath.value
                                                .isNotEmpty) {
                                          controller.uploadFormData();
                                        }
                                      },
                                      color: kdarkBlue,
                                      child: Text(
                                        "Save",
                                        style: CustomFonts.kBlack15Black
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
                              // smallText(text: "Address Proof"),
                              // const SizedBox(
                              //   height: 10.0,
                              // ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //       color: Colors.grey.shade100,
                              //       borderRadius: BorderRadius.circular(1.0),
                              //       border: Border.all(color: kGrey)),
                              //   child: Obx(() => DropdownButton<String>(
                              //         isExpanded: true,
                              //         hint: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: controller.borrowerAddressProof
                              //                   .value.isNotEmpty
                              //               ? Text(
                              //                   controller
                              //                       .borrowerAddressProof.value,
                              //                   style: CustomFonts.kBlack15Black
                              //                       .copyWith(fontSize: 14.0),
                              //                 )
                              //               : Text(
                              //                   "Select Document Type",
                              //                   style: CustomFonts.kBlack15Black
                              //                       .copyWith(fontSize: 14.0),
                              //                 ),
                              //         ),
                              //         underline: const SizedBox(),
                              //         items: <String>[
                              //           'Aadhar Card',
                              //           'Passport',
                              //           'Voter card',
                              //           'Driving License',
                              //           'Bank Passbook',
                              //           'Any other Govt ID Card',
                              //         ].map((String value) {
                              //           return DropdownMenuItem<String>(
                              //             value: value,
                              //             child: Text(value),
                              //           );
                              //         }).toList(),
                              //         onChanged: (value) {
                              //           controller.borrowerAddressProof.value =
                              //               value!;
                              //         },
                              //       )),
                              // ),
                              // const SizedBox(
                              //   height: 10.0,
                              // ),
                              // Container(
                              //   height: 40.0.h,
                              //   decoration: BoxDecoration(
                              //       color: Colors.grey.shade50,
                              //       borderRadius: BorderRadius.circular(5.0),
                              //       border: Border.all(
                              //         color: kGrey,
                              //       )),
                              //   child: Row(
                              //     children: [
                              //       Flexible(
                              //         child: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Obx(() => Text(
                              //                 "${controller.borrowerAddressProofDoc.value}",
                              //                 style: CustomFonts.kBlack15Black
                              //                     .copyWith(
                              //                         fontWeight:
                              //                             FontWeight.w600,
                              //                         fontSize: 14.0),
                              //               )),
                              //         ),
                              //         fit: FlexFit.tight,
                              //       ),
                              //       const Spacer(),
                              //       MaterialButton(
                              //         elevation: 1.0,
                              //         onPressed: () async {
                              //           Get.defaultDialog(
                              //               title: "Upload",
                              //               titleStyle: CustomFonts
                              //                   .kBlack15Black
                              //                   .copyWith(
                              //                       color: Colors.black,
                              //                       fontSize: 20.0,
                              //                       fontWeight:
                              //                           FontWeight.bold),
                              //               content: Column(
                              //                 mainAxisSize: MainAxisSize.min,
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.center,
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.center,
                              //                 children: [
                              //                   const Divider(),
                              //                   GestureDetector(
                              //                     onTap: () async {
                              //                       var file = await controller
                              //                           .imageFromCamera();
                              //                       print(file);
                              //                       controller
                              //                           .borrowerAddressProofDoc
                              //                           .value = basename(file);
                              //                       controller
                              //                           .borrowerAddressDocPath
                              //                           .value = file;
                              //                       Get.back(
                              //                           closeOverlays: true);
                              //                     },
                              //                     child: Text(
                              //                       "Take Photo ...",
                              //                       style: CustomFonts
                              //                           .kBlack15Black
                              //                           .copyWith(
                              //                               color: kdarkBlue,
                              //                               fontWeight:
                              //                                   FontWeight.w600,
                              //                               fontSize: 16.0),
                              //                     ),
                              //                   ),
                              //                   Divider(),
                              //                   GestureDetector(
                              //                     behavior:
                              //                         HitTestBehavior.opaque,
                              //                     onTap: () async {
                              //                       var file = await controller
                              //                           .uploadFile();
                              //
                              //                       controller
                              //                           .borrowerAddressProofDoc
                              //                           .value = basename(file);
                              //                       controller
                              //                           .borrowerAddressDocPath
                              //                           .value = file;
                              //                       Get.back(
                              //                           closeOverlays: true);
                              //                     },
                              //                     child: Text(
                              //                       "Choose Files from Phone",
                              //                       style: CustomFonts
                              //                           .kBlack15Black
                              //                           .copyWith(
                              //                               color: kdarkBlue,
                              //                               fontWeight:
                              //                                   FontWeight.w600,
                              //                               fontSize: 16.0),
                              //                     ),
                              //                   ),
                              //                   Divider(),
                              //                 ],
                              //               ),
                              //               cancel: GestureDetector(
                              //                 onTap: () {
                              //                   log("**");
                              //                   Get.back(closeOverlays: true);
                              //                 },
                              //                 behavior: HitTestBehavior.opaque,
                              //                 child: Padding(
                              //                   padding:
                              //                       const EdgeInsets.all(8.0),
                              //                   child: Text(
                              //                     "Cancel",
                              //                     style: CustomFonts
                              //                         .kBlack15Black
                              //                         .copyWith(
                              //                             color: Colors.red,
                              //                             fontSize: 16),
                              //                   ),
                              //                 ),
                              //               ),
                              //               onCancel: () => Get.back());
                              //         },
                              //         shape: RoundedRectangleBorder(
                              //             side: const BorderSide(color: kGrey),
                              //             borderRadius:
                              //                 BorderRadius.circular(5.0)),
                              //         color: Colors.white,
                              //         child: Text("Upload",
                              //             style: CustomFonts.kBlack15Black
                              //                 .copyWith(
                              //                     fontSize: 15.0,
                              //                     fontWeight: FontWeight.w400)),
                              //       ),
                              //       const SizedBox(
                              //         width: 10,
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // const SizedBox(height: 10.0),
                              // Obx(() => controller
                              //         .borrowerAddressDocPath.value.isNotEmpty
                              //     ? Row(
                              //         children: [
                              //           GestureDetector(
                              //             child: Text(
                              //               "Preview",
                              //               style: CustomFonts.kBlack15Black
                              //                   .copyWith(
                              //                       fontSize: 14.0,
                              //                       color: kdarkBlue,
                              //                       fontWeight:
                              //                           FontWeight.w700),
                              //             ),
                              //             onTap: () =>
                              //                 Get.to(() => PreviewScreen(
                              //                       filePath: controller
                              //                           .borrowerAddressDocPath
                              //                           .value,
                              //                     )),
                              //           ),
                              //           const Spacer(),
                              //           GestureDetector(
                              //             onTap: () {
                              //               controller.borrowerAddressProofDoc
                              //                   .value = "";
                              //               controller.borrowerAddressDocPath
                              //                   .value = "";
                              //             },
                              //             child: const Icon(
                              //               Icons.delete,
                              //               color: klightBlue,
                              //               size: 20,
                              //             ),
                              //           )
                              //         ],
                              //       )
                              //     : SizedBox()),
                              // const SizedBox(
                              //   height: 10.0,
                              // ),
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
                                style: CustomFonts.kBlack15Black.copyWith(
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
                                  text: "(atleast one  document is mandatory)"),
                              const SizedBox(
                                height: 5.0,
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
                                                style: CustomFonts.kBlack15Black
                                                    .copyWith(fontSize: 14.0),
                                              )
                                            : Text(
                                                "Select Document Type",
                                                style: CustomFonts.kBlack15Black
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
                                              style: CustomFonts.kBlack15Black
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
                                              titleStyle: CustomFonts
                                                  .kBlack15Black
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
                                                      style: CustomFonts
                                                          .kBlack15Black
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
                                                      var file =
                                                          await controller
                                                              .uploadFile();
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
                                                      "Choose Files from Phone",
                                                      style: CustomFonts
                                                          .kBlack15Black
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
                                                    style: CustomFonts
                                                        .kBlack15Black
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
                                          style: CustomFonts.kBlack15Black
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
                              Obx(() => controller
                                      .nomineeIdDocPath.value.isNotEmpty
                                  ? Row(
                                      children: [
                                        GestureDetector(
                                          child: Text(
                                            "Preview",
                                            style: CustomFonts.kBlack15Black
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
                              // smallText(text: "Address Proof"),
                              // const SizedBox(
                              //   height: 10.0,
                              // ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //       color: Colors.grey.shade100,
                              //       borderRadius: BorderRadius.circular(1.0),
                              //       border: Border.all(color: kGrey)),
                              //   child: Obx(() => DropdownButton<String>(
                              //         isExpanded: true,
                              //         hint: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: controller.nomineeAddressProof
                              //                   .value.isNotEmpty
                              //               ? Text(
                              //                   controller
                              //                       .nomineeAddressProof.value,
                              //                   style: CustomFonts.kBlack15Black
                              //                       .copyWith(fontSize: 14.0),
                              //                 )
                              //               : Text(
                              //                   "Select Document Type",
                              //                   style: CustomFonts.kBlack15Black
                              //                       .copyWith(fontSize: 14.0),
                              //                 ),
                              //         ),
                              //         underline: const SizedBox(),
                              //         items: <String>[
                              //           'Aadhar Card',
                              //           'Passport',
                              //           'Voter card',
                              //           'Driving License',
                              //           'Bank Passbook',
                              //           'Any other Govt ID Card',
                              //         ].map((String value) {
                              //           return DropdownMenuItem<String>(
                              //             value: value,
                              //             child: Text(value),
                              //           );
                              //         }).toList(),
                              //         onChanged: (value) {
                              //           controller.nomineeAddressProof.value =
                              //               value!;
                              //         },
                              //       )),
                              // ),
                              // const SizedBox(
                              //   height: 10.0,
                              // ),
                              // Container(
                              //   height: 40.0.h,
                              //   decoration: BoxDecoration(
                              //       color: Colors.grey.shade50,
                              //       borderRadius: BorderRadius.circular(5.0),
                              //       border: Border.all(
                              //         color: kGrey,
                              //       )),
                              //   child: Row(
                              //     children: [
                              //       Flexible(
                              //         fit: FlexFit.tight,
                              //         child: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Obx(() => Text(
                              //                 "${controller.nomineeAddressProofDoc.value}",
                              //                 style: CustomFonts.kBlack15Black
                              //                     .copyWith(
                              //                         fontWeight:
                              //                             FontWeight.w600,
                              //                         fontSize: 14.0),
                              //               )),
                              //         ),
                              //       ),
                              //       const Spacer(),
                              //       MaterialButton(
                              //         elevation: 1.0,
                              //         onPressed: () async {
                              //           Get.defaultDialog(
                              //               title: "Upload",
                              //               titleStyle: CustomFonts
                              //                   .kBlack15Black
                              //                   .copyWith(
                              //                       color: Colors.black,
                              //                       fontSize: 20.0,
                              //                       fontWeight:
                              //                           FontWeight.bold),
                              //               content: Column(
                              //                 mainAxisSize: MainAxisSize.min,
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.center,
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.center,
                              //                 children: [
                              //                   Divider(),
                              //                   GestureDetector(
                              //                     onTap: () async {
                              //                       var file = await controller
                              //                           .imageFromCamera();
                              //                       print(file);
                              //
                              //                       controller
                              //                           .nomineeAddressProofDoc
                              //                           .value = basename(file);
                              //                       controller
                              //                           .nomineeAddressDocPath
                              //                           .value = file;
                              //                       Get.back(
                              //                           closeOverlays: true);
                              //                     },
                              //                     child: Text(
                              //                       "Take Photo ...",
                              //                       style: CustomFonts
                              //                           .kBlack15Black
                              //                           .copyWith(
                              //                               color: kdarkBlue,
                              //                               fontWeight:
                              //                                   FontWeight.w600,
                              //                               fontSize: 16.0),
                              //                     ),
                              //                   ),
                              //                   Divider(),
                              //                   GestureDetector(
                              //                     behavior:
                              //                         HitTestBehavior.opaque,
                              //                     onTap: () async {
                              //                       var file = await controller
                              //                           .uploadFile();
                              //                       controller
                              //                           .nomineeAddressProofDoc
                              //                           .value = basename(file);
                              //                       controller
                              //                           .nomineeAddressDocPath
                              //                           .value = file;
                              //                       Get.back(
                              //                           closeOverlays: true);
                              //                     },
                              //                     child: Text(
                              //                       "Choose Files from Phone",
                              //                       style: CustomFonts
                              //                           .kBlack15Black
                              //                           .copyWith(
                              //                               color: kdarkBlue,
                              //                               fontWeight:
                              //                                   FontWeight.w600,
                              //                               fontSize: 16.0),
                              //                     ),
                              //                   ),
                              //                   Divider(),
                              //                 ],
                              //               ),
                              //               cancel: GestureDetector(
                              //                 onTap: () {
                              //                   log("**");
                              //                   Get.back(closeOverlays: true);
                              //                 },
                              //                 behavior: HitTestBehavior.opaque,
                              //                 child: Padding(
                              //                   padding:
                              //                       const EdgeInsets.all(8.0),
                              //                   child: Text(
                              //                     "Cancel",
                              //                     style: CustomFonts
                              //                         .kBlack15Black
                              //                         .copyWith(
                              //                             color: Colors.red,
                              //                             fontSize: 16),
                              //                   ),
                              //                 ),
                              //               ),
                              //               onCancel: () => Get.back());
                              //         },
                              //         shape: RoundedRectangleBorder(
                              //             side: const BorderSide(color: kGrey),
                              //             borderRadius:
                              //                 BorderRadius.circular(5.0)),
                              //         color: Colors.white,
                              //         child: Text("Upload",
                              //             style: CustomFonts.kBlack15Black
                              //                 .copyWith(
                              //                     fontSize: 15.0,
                              //                     fontWeight: FontWeight.w400)),
                              //       ),
                              //       const SizedBox(
                              //         width: 10,
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 10.0,
                              // ),
                              // Obx(() => controller
                              //         .nomineeAddressDocPath.value.isNotEmpty
                              //     ? Row(
                              //         children: [
                              //           GestureDetector(
                              //             child: Text(
                              //               "Preview",
                              //               style: CustomFonts.kBlack15Black
                              //                   .copyWith(
                              //                       fontSize: 14.0,
                              //                       color: kdarkBlue,
                              //                       fontWeight:
                              //                           FontWeight.w700),
                              //             ),
                              //             onTap: () =>
                              //                 Get.to(() => PreviewScreen(
                              //                       filePath: controller
                              //                           .nomineeAddressDocPath
                              //                           .value,
                              //                     )),
                              //           ),
                              //           const Spacer(),
                              //           GestureDetector(
                              //             onTap: () {
                              //               controller.nomineeAddressProofDoc
                              //                   .value = "";
                              //               controller.nomineeAddressDocPath
                              //                   .value = "";
                              //             },
                              //             child: const Icon(
                              //               Icons.delete,
                              //               color: klightBlue,
                              //               size: 20,
                              //             ),
                              //           )
                              //         ],
                              //       )
                              //     : SizedBox()),
                              // const SizedBox(
                              //   height: 10.0,
                              // ),

                              Row(
                                children: [
                                  smallText(text: "Bank A/C Proof"),
                                  Text(
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
                                                style: CustomFonts.kBlack15Black
                                                    .copyWith(fontSize: 14.0),
                                              )
                                            : Text(
                                                "Select Document Type",
                                                style: CustomFonts.kBlack15Black
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
                                        // 'Bank passbook',
                                        // 'Bank statement',
                                        // 'Cheque',
                                        // 'Neft form',
                                        // 'Other',
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
                                              style: CustomFonts.kBlack15Black
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
                                          var file =
                                              await controller.uploadFile();
                                          print(file);
                                          controller.bankProofDoc.value =
                                              basename(file);
                                          controller.bankAccountDocPath.value =
                                              file;
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: kGrey),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      color: Colors.white,
                                      child: Text("Upload",
                                          style: CustomFonts.kBlack15Black
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
                                  controller.bankAccountDocPath.value.isNotEmpty
                                      ? Row(
                                          children: [
                                            GestureDetector(
                                              child: Text(
                                                "Preview",
                                                style: CustomFonts.kBlack15Black
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
                              // Obx(() => controller.causeofDeath.value ==
                              //         "Accident"
                              //     ? Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.start,
                              //         children: [
                              //           smallText(
                              //               text: "FIR / postmortem report"),
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
                              //                   fit: FlexFit.tight,
                              //                   child: Padding(
                              //                     padding:
                              //                         const EdgeInsets.all(8.0),
                              //                     child: Obx(() => Text(
                              //                           "${controller.firProof.value}",
                              //                           style: CustomFonts
                              //                               .kBlack15Black
                              //                               .copyWith(
                              //                                   fontWeight:
                              //                                       FontWeight
                              //                                           .w600,
                              //                                   fontSize: 14.0),
                              //                         )),
                              //                   ),
                              //                 ),
                              //                 const Spacer(),
                              //                 MaterialButton(
                              //                   elevation: 1.0,
                              //                   onPressed: () async {
                              //                     if(controller.claimDetail.value["claimStatus"].toString() =="UNDER_VERIFICATION"){
                              //                       Fluttertoast.showToast(
                              //                           msg: "Already Under Verification",
                              //                           toastLength: Toast.LENGTH_SHORT,
                              //                           gravity: ToastGravity.BOTTOM,
                              //                           timeInSecForIosWeb: 1,
                              //                           backgroundColor: Colors.red,
                              //                           textColor: Colors.white,
                              //                           fontSize: 16.0);
                              //                     }
                              //                     else{
                              //                     Get.defaultDialog(
                              //                         title: "Upload",
                              //                         titleStyle: CustomFonts
                              //                             .kBlack15Black
                              //                             .copyWith(
                              //                                 color:
                              //                                     Colors.black,
                              //                                 fontSize: 20.0,
                              //                                 fontWeight:
                              //                                     FontWeight
                              //                                         .bold),
                              //                         content: Column(
                              //                           mainAxisSize:
                              //                               MainAxisSize.min,
                              //                           crossAxisAlignment:
                              //                               CrossAxisAlignment
                              //                                   .center,
                              //                           mainAxisAlignment:
                              //                               MainAxisAlignment
                              //                                   .center,
                              //                           children: [
                              //                             Divider(),
                              //                             GestureDetector(
                              //                               onTap: () async {
                              //                                 var file =
                              //                                     await controller
                              //                                         .imageFromCamera();
                              //                                 print(file);
                              //                                 controller
                              //                                         .firProof
                              //                                         .value =
                              //                                     basename(
                              //                                         file);
                              //                                 controller
                              //                                     .firOrPostmortemReportPath
                              //                                     .value = file;
                              //                                 Get.back(
                              //                                     closeOverlays:
                              //                                         true);
                              //                               },
                              //                               child: Text(
                              //                                 "Take Photo ...",
                              //                                 style: CustomFonts
                              //                                     .kBlack15Black
                              //                                     .copyWith(
                              //                                         color:
                              //                                             kdarkBlue,
                              //                                         fontWeight:
                              //                                             FontWeight
                              //                                                 .w600,
                              //                                         fontSize:
                              //                                             16.0),
                              //                               ),
                              //                             ),
                              //                             Divider(),
                              //                             GestureDetector(
                              //                               behavior:
                              //                                   HitTestBehavior
                              //                                       .opaque,
                              //                               onTap: () async {
                              //                                 var file =
                              //                                     await controller
                              //                                         .uploadFile();
                              //
                              //                                 controller
                              //                                         .firProof
                              //                                         .value =
                              //                                     basename(
                              //                                         file);
                              //                                 controller
                              //                                     .firOrPostmortemReportPath
                              //                                     .value = file;
                              //                                 Get.back(
                              //                                     closeOverlays:
                              //                                         true);
                              //                               },
                              //                               child: Text(
                              //                                 "Choose Files from Phone",
                              //                                 style: CustomFonts
                              //                                     .kBlack15Black
                              //                                     .copyWith(
                              //                                         color:
                              //                                             kdarkBlue,
                              //                                         fontWeight:
                              //                                             FontWeight
                              //                                                 .w600,
                              //                                         fontSize:
                              //                                             16.0),
                              //                               ),
                              //                             ),
                              //                             Divider(),
                              //                           ],
                              //                         ),
                              //                         cancel: GestureDetector(
                              //                           onTap: () {
                              //                             log("**");
                              //                             Get.back(
                              //                                 closeOverlays:
                              //                                     true);
                              //                           },
                              //                           behavior:
                              //                               HitTestBehavior
                              //                                   .opaque,
                              //                           child: Padding(
                              //                             padding:
                              //                                 const EdgeInsets
                              //                                     .all(8.0),
                              //                             child: Text(
                              //                               "Cancel",
                              //                               style: CustomFonts
                              //                                   .kBlack15Black
                              //                                   .copyWith(
                              //                                       color: Colors
                              //                                           .red,
                              //                                       fontSize:
                              //                                           16),
                              //                             ),
                              //                           ),
                              //                         ),
                              //                         onCancel: () =>
                              //                             Get.back());}
                              //                   },
                              //                   shape: RoundedRectangleBorder(
                              //                       side: const BorderSide(
                              //                           color: kGrey),
                              //                       borderRadius:
                              //                           BorderRadius.circular(
                              //                               5.0)),
                              //                   color: Colors.white,
                              //                   child: Text("Upload",
                              //                       style: CustomFonts
                              //                           .kBlack15Black
                              //                           .copyWith(
                              //                               fontSize: 15.0,
                              //                               fontWeight:
                              //                                   FontWeight
                              //                                       .w400)),
                              //                 ),
                              //                 const SizedBox(
                              //                   width: 10,
                              //                 )
                              //               ],
                              //             ),
                              //           ),
                              //         ],
                              //       )
                              //     : const SizedBox()),
                              // const SizedBox(
                              //   height: 10.0,
                              // ),
                              // Obx(() => controller.firOrPostmortemReportPath
                              //         .value.isNotEmpty
                              //     ? Row(
                              //         children: [
                              //           GestureDetector(
                              //             child: Text(
                              //               "Preview",
                              //               style: CustomFonts.kBlack15Black
                              //                   .copyWith(
                              //                       fontSize: 14.0,
                              //                       color: kdarkBlue,
                              //                       fontWeight:
                              //                           FontWeight.w700),
                              //             ),
                              //             onTap: () =>
                              //                 Get.to(() => PreviewScreen(
                              //                       filePath: controller
                              //                           .firOrPostmortemReportPath
                              //                           .value,
                              //                     )),
                              //           ),
                              //           const Spacer(),
                              //           GestureDetector(
                              //             onTap: () {
                              //               controller.firProof.value = "";
                              //               controller.firOrPostmortemReportPath
                              //                   .value = "";
                              //             },
                              //             child: const Icon(
                              //               Icons.delete,
                              //               color: klightBlue,
                              //               size: 20,
                              //             ),
                              //           )
                              //         ],
                              //       )
                              //     : SizedBox()),
                              // const SizedBox(
                              //   height: 10.0,
                              // ),
                              smallText(text: "Additional Document"),
                              const SizedBox(
                                height: 10.0,
                              ),
                              if (controller.nominee.value == "Minor")
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
                                                  style: CustomFonts
                                                      .kBlack15Black
                                                      .copyWith(fontSize: 14.0),
                                                )
                                              : Text(
                                                  "Select Document Type",
                                                  style: CustomFonts
                                                      .kBlack15Black
                                                      .copyWith(fontSize: 14.0),
                                                ),
                                        ),
                                        underline: const SizedBox(),
                                        items: minorList
                                            // <String>[
                                            //   'Police FIR Copy',
                                            //   'Postmortem Report',
                                            //   'Income Tax Returns',
                                            //   'Medical Records',
                                            //   'Legal Heir Certificate',
                                            //   'Police Investigation Report',
                                            //   'Relationship Proof',
                                            //   'Stamped Affidavit',
                                            //   'Medical Attendant Certificate',
                                            //   'Guardian - Id proof',
                                            //   'Guardian - Add proof',
                                            //   'Any utility bill (gas / electricity / rental agreement)',
                                            //   'Other Document',
                                            //   // 'Income Tax Return',
                                            //   // 'Medical Records',
                                            //   // 'Legal Heir Certificate',
                                            //   // 'Police Investigation Report',
                                            //   // 'Other',
                                            // ]
                                            .map((String value) {
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
                              if (controller.causeofDeath.value == "Accident")
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
                                                  style: CustomFonts
                                                      .kBlack15Black
                                                      .copyWith(fontSize: 14.0),
                                                )
                                              : Text(
                                                  "Select Document Type",
                                                  style: CustomFonts
                                                      .kBlack15Black
                                                      .copyWith(fontSize: 14.0),
                                                ),
                                        ),
                                        underline: const SizedBox(),
                                        items: accientList
                                            // <String>[
                                            //   'Police FIR Copy',
                                            //   'Postmortem Report',
                                            //   'Income Tax Returns',
                                            //   'Medical Records',
                                            //   'Legal Heir Certificate',
                                            //   'Police Investigation Report',
                                            //   'Relationship Proof',
                                            //   'Stamped Affidavit',
                                            //   'Medical Attendant Certificate',
                                            //   'Guardian - Id proof',
                                            //   'Guardian - Add proof',
                                            //   'Any utility bill (gas / electricity / rental agreement)',
                                            //   'Other Document',
                                            //   // 'Income Tax Return',
                                            //   // 'Medical Records',
                                            //   // 'Legal Heir Certificate',
                                            //   // 'Police Investigation Report',
                                            //   // 'Other',
                                            // ]
                                            .map((String value) {
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
                              if (controller.causeofDeath.value ==
                                  "Illness &  Medical Reason")
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
                                                  style: CustomFonts
                                                      .kBlack15Black
                                                      .copyWith(fontSize: 14.0),
                                                )
                                              : Text(
                                                  "Select Document Type",
                                                  style: CustomFonts
                                                      .kBlack15Black
                                                      .copyWith(fontSize: 14.0),
                                                ),
                                        ),
                                        underline: const SizedBox(),
                                        items: sickList
                                            // <String>[
                                            //   'Police FIR Copy',
                                            //   'Postmortem Report',
                                            //   'Income Tax Returns',
                                            //   'Medical Records',
                                            //   'Legal Heir Certificate',
                                            //   'Police Investigation Report',
                                            //   'Relationship Proof',
                                            //   'Stamped Affidavit',
                                            //   'Medical Attendant Certificate',
                                            //   'Guardian - Id proof',
                                            //   'Guardian - Add proof',
                                            //   'Any utility bill (gas / electricity / rental agreement)',
                                            //   'Other Document',
                                            //   // 'Income Tax Return',
                                            //   // 'Medical Records',
                                            //   // 'Legal Heir Certificate',
                                            //   // 'Police Investigation Report',
                                            //   // 'Other',
                                            // ]
                                            .map((String value) {
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

                              if (controller.causeofDeath.value == "Major" &&
                                  (controller.causeofDeath.value !=
                                          "Accident" ||
                                      controller.causeofDeath.value !=
                                          "Natural Death" ||
                                      controller.causeofDeath.value !=
                                          "Death due to Natural Calamity" ||
                                      controller.causeofDeath.value !=
                                          "Suicide" ||
                                      controller.causeofDeath.value !=
                                          "Illness &  Medical Reason"))
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
                                                  style: CustomFonts
                                                      .kBlack15Black
                                                      .copyWith(fontSize: 14.0),
                                                )
                                              : Text(
                                                  "Select Document Type",
                                                  style: CustomFonts
                                                      .kBlack15Black
                                                      .copyWith(fontSize: 14.0),
                                                ),
                                        ),
                                        underline: const SizedBox(),
                                        items: <String>[
                                          'Police FIR Copy',
                                          'Postmortem Report',
                                          'Income Tax Returns',
                                          'Medical Records',
                                          'Legal Heir Certificate',
                                          'Police Investigation Report',
                                          'Relationship Proof',
                                          'Stamped Affidavit',
                                          'Medical Attendant Certificate',
                                          'Guardian - Id proof',
                                          'Guardian - Add proof',
                                          'Any utility bill (gas / electricity / rental agreement)',
                                          'Other Document',
                                          // 'Income Tax Return',
                                          // 'Medical Records',
                                          // 'Legal Heir Certificate',
                                          // 'Police Investigation Report',
                                          // 'Other',
                                        ].map((String value) {
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
                              if (controller.nominee.value == "Minor")
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
                                                  style: CustomFonts
                                                      .kBlack15Black
                                                      .copyWith(fontSize: 14.0),
                                                )
                                              : Text(
                                                  "Select Document Type",
                                                  style: CustomFonts
                                                      .kBlack15Black
                                                      .copyWith(fontSize: 14.0),
                                                ),
                                        ),
                                        underline: const SizedBox(),
                                        items: minorList
                                            // <String>[
                                            //   'Police FIR Copy',
                                            //   'Postmortem Report',
                                            //   'Income Tax Returns',
                                            //   'Medical Records',
                                            //   'Legal Heir Certificate',
                                            //   'Police Investigation Report',
                                            //   'Relationship Proof',
                                            //   'Stamped Affidavit',
                                            //   'Medical Attendant Certificate',
                                            //   'Guardian - Id proof',
                                            //   'Guardian - Add proof',
                                            //   'Any utility bill (gas / electricity / rental agreement)',
                                            //   'Other Document',
                                            //   // 'Income Tax Return',
                                            //   // 'Medical Records',
                                            //   // 'Legal Heir Certificate',
                                            //   // 'Police Investigation Report',
                                            //   // 'Other',
                                            // ]
                                            .map((String value) {
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

                              Obx(() => controller.nominee.value == "Minor"
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(1.0),
                                          border: Border.all(color: kGrey)),
                                      child: Obx(() => DropdownButton<String>(
                                            isExpanded: true,
                                            hint: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: controller.additionalProof
                                                      .value.isNotEmpty
                                                  ? Text(
                                                      controller.additionalProof
                                                          .value,
                                                      style: CustomFonts
                                                          .kBlack15Black
                                                          .copyWith(
                                                              fontSize: 14.0),
                                                    )
                                                  : Text(
                                                      "Select Document Type",
                                                      style: CustomFonts
                                                          .kBlack15Black
                                                          .copyWith(
                                                              fontSize: 14.0),
                                                    ),
                                            ),
                                            underline: const SizedBox(),
                                            items: minorList
                                                // <String>[
                                                //   'Police FIR Copy',
                                                //   'Postmortem Report',
                                                //   'Income Tax Returns',
                                                //   'Medical Records',
                                                //   'Legal Heir Certificate',
                                                //   'Police Investigation Report',
                                                //   'Relationship Proof',
                                                //   'Stamped Affidavit',
                                                //   'Medical Attendant Certificate',
                                                //   'Guardian - Id proof',
                                                //   'Guardian - Add proof',
                                                //   'Any utility bill (gas / electricity / rental agreement)',
                                                //   'Other Document',
                                                //   // 'Income Tax Return',
                                                //   // 'Medical Records',
                                                //   // 'Legal Heir Certificate',
                                                //   // 'Police Investigation Report',
                                                //   // 'Other',
                                                // ]
                                                .map((String value) {
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
                                    )
                                  : SizedBox()),

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
                                              style: CustomFonts.kBlack15Black
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
                                              titleStyle: CustomFonts
                                                  .kBlack15Black
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
                                                      if (controller
                                                          .additionalDropDownList
                                                          .contains(controller
                                                              .additionalProofDoc
                                                              .value)) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Already Exit Record for Selected Dropdown",
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
                                                      "Take Photo ...",
                                                      style: CustomFonts
                                                          .kBlack15Black
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
                                                                "Already Exit Record for Selected Dropdown",
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
                                                      style: CustomFonts
                                                          .kBlack15Black
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
                                                    style: CustomFonts
                                                        .kBlack15Black
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
                                          style: CustomFonts.kBlack15Black
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

                              Text(controller.additionalList.value.toString()),
                              Text(controller.additionalList.value.length
                                  .toString()),

                              Obx(() =>
                                  controller.additionalDocpath.value.isNotEmpty
                                      ? Row(
                                          children: [
                                            GestureDetector(
                                              child: Text(
                                                "Preview",
                                                style: CustomFonts.kBlack15Black
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
                                child: MaterialButton(
                                  onPressed: () {
                                    if (controller.nominee.value == "Minor") {
                                      if (controller.minor.length >= 3) {
                                        if (controller.causeofDeath.value
                                                .isNotEmpty &&
                                            controller
                                                .filledPath.value.isNotEmpty &&
                                            controller
                                                .dealthCertificate.value.isNotEmpty &&
                                            controller.borroweridProofDoc.value
                                                .isNotEmpty &&
                                            controller.borrowerIdDocPath.value
                                                .isNotEmpty) {
                                          controller.uploadFormData1();
                                        } else {
                                          log("${controller.borroweridProofDoc.value.isNotEmpty && controller.borrowerIdDocPath.value.isNotEmpty}");
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please update all mandatory fields",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Please update atleast 3 documents for minor",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    } else if (controller
                                            .causeofDeath.value.isNotEmpty ||
                                        controller
                                            .filledPath.value.isNotEmpty ||
                                        controller.dealthCertificate.value
                                            .isNotEmpty ||
                                        controller
                                            .borroweridProof.value.isNotEmpty ||
                                        controller.borrowerIdDocPath.value
                                            .isNotEmpty) {
                                      controller.uploadFormData1();
                                    }
                                    if (controller.additionalDropDownList
                                        .contains(controller
                                            .additionalProofDoc.value)) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Already Exit Record for Selected Dropdown",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      controller.additionalDocumentList(
                                          dropDownValue:
                                              controller.additionalProof.value,
                                          imagePath: controller
                                              .additionalDocpath.value,
                                          selectedValue:
                                              controller.additionalProof.value);
                                    }
                                  },
                                  child: Text(
                                    "Save",
                                    style: CustomFonts.kBlack15Black
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

                                  // log(" value of index${controller.currentIndex.value.toString()== "0"}");
                                  controller.currentIndex.value =
                                      controller.currentIndex.value - 1;
                                  // if(controller.currentIndex.value.toString() == "0"){
                                  //   Get.off(() => Details(
                                  //     title: '${dataArg[0]}',
                                  //   ));
                                  //
                                  // }
                                  // else{
                                  //
                                  // }
                                }
                                // else{
                                //   Get.off(() => Details(
                                //     title: '${dataArg[0]}',
                                //   ));
                                // }
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
                                } else {
                                  log("--");
                                  if (controller.causeofDeath.value.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Cause of Death Cannot be blank",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    //controller.uploadFormData();
                                    if (controller
                                            .borroweridProof.value.isNotEmpty
                                        // || controller.borrowerAddressProof.value.isNotEmpty
                                        ||
                                        controller
                                            .nomineeIdProof.value.isNotEmpty ||
                                        // controller.nomineeAddressProof.value.isNotEmpty ||
                                        controller.bankProof.value.isNotEmpty ||
                                        controller
                                            .additionalProof.value.isNotEmpty) {
                                      log("87");
                                    } else if (controller
                                            .borrowerIdDocPath.isNotEmpty ||
                                        // controller.borrowerAddressDocPath.isNotEmpty ||
                                        controller
                                            .nomineeIdDocPath.isNotEmpty ||
                                        // controller.nomineeAddressDocPath.isNotEmpty ||
                                        // controller.borrowerAddressDocPath.isNotEmpty ||
                                        controller
                                            .additionalDocpath.isNotEmpty) {
                                      log("88");
                                    } else {
                                      if (controller.causeofDeath.value ==
                                          "Accident") {
                                        if (controller
                                                .additionalProofDoc.value ==
                                            "Police FIR Copy") {
                                          controller.uploadFormData();
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Police Fir Copy is compulsory",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      }

                                      if (controller.causeofDeath.value ==
                                          "Illness & Medical Reason") {
                                        if (controller
                                                .additionalProofDoc.value ==
                                            "Medical Attendant Certificate") {
                                          controller.uploadFormData();
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Medical Attendant Certificate is compulsory",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      }
                                    }
                                  } else if (controller.filled.value == '' ||
                                      controller.filledPath.value == null) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Filled & Signed Claim form Cannot be blank",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else if (controller
                                              .dealthCertificate.value ==
                                          "" ||
                                      controller.deathCertificatePath.value ==
                                          null) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Death Certificate Cannot be blank",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else if (controller
                                          .claimDetail.value["claimStatus"]
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
                                    log("rrr");
                                    Fluttertoast.showToast(
                                        msg: "Cause of Death Cannot be blank",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
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
                                    : controller.causeofDeath.value.isEmpty
                                        ? Container(
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
                                          )
                                        : Container(
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
              hintStyle: CustomFonts.kBlack15Black,
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
          maxLines: 2,
          decoration: InputDecoration(
              hintText: text,
              hintStyle: CustomFonts.kBlack15Black,
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
          style: CustomFonts.kBlack15Black.copyWith(
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
                style: CustomFonts.kBlack15Black
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
                  style: CustomFonts.kBlack15Black
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
    // if (controller.borrowerAddressProof.value.isNotEmpty) {
    //   if (controller.borrowerAddressDocPath.isNotEmpty) {
    //     ///Api call krni h yha se
    //   } else {
    //     showMessage(message: "Please Select KYC Address Proof");
    //   }
    // }
    if (controller.nomineeIdProof.value.isNotEmpty) {
      if (controller.nomineeIdDocPath.isNotEmpty) {
        ///Api call krni h yha se
      } else {
        showMessage(message: "Please Select Nominee ID Proof");
      }
    }
    // if (controller.nomineeAddressProof.value.isNotEmpty) {
    //   if (controller.nomineeIdDocPath.isNotEmpty) {
    //     ///Api call krni h yha se
    //   } else {
    //     showMessage(message: "Please Select Nominee Address Proof");
    //   }
    // }
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
    // if (controller.borrowerAddressDocPath.value.isNotEmpty) {
    //   if (controller.borrowerAddressProof.isNotEmpty) {
    //     ///Api call krni h yha se
    //   } else {
    //     showMessage(message: "Please Select KYC Address Proof");
    //   }
    // }
    if (controller.nomineeIdDocPath.value.isNotEmpty) {
      if (controller.nomineeIdProof.isNotEmpty) {
        ///Api call krni h yha se
      } else {
        showMessage(message: "Please Select Nominee ID Proof");
      }
    }
    // if (controller.nomineeAddressProof.value.isNotEmpty) {
    //   if (controller.nomineeAddressProofDoc.isNotEmpty) {
    //     ///Api call krni h yha se
    //   } else {
    //     showMessage(message: "Please Select Nominee Address Proof");
    //   }
    // }
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
