import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/controller/claim_controller/claim_controller.dart';
import 'package:punchin/views/details.dart';

class ClaimFormView extends StatefulWidget {
  const ClaimFormView({Key? key}) : super(key: key);

  @override
  State<ClaimFormView> createState() => _ClaimFormViewState();
}

class _ClaimFormViewState extends State<ClaimFormView> {
  ClaimController controller = Get.put(ClaimController());
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  List forms = <Widget>[];
  var dataArg = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () {
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
            child: Text(
              "Case/Claim ID :  ",
              style: CustomFonts.kBlack15Black.copyWith(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400),
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
      // body: Obx(() =>
      // !controller.loading.value
      //     ? Obx(() =>
      // !controller.loadUpload.value
      //     ? stepperForm()
      //     : Center(
      //   child: CupertinoActivityIndicator(),
      // ))
      //     : Center(child: CupertinoActivityIndicator())),
      body: customStepperForm(),
    );
  }

  stepperForm() => Container(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Theme(
                  data: ThemeData(primaryColor: kdarkBlue),
                  child: Stepper(
                    type: stepperType,
                    physics: const ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: continued,
                    elevation: 0,
                    onStepCancel: cancel,
                    steps: <Step>[
                      Step(
                        title: const SizedBox(),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Borrower Details",
                              style: CustomFonts.kBlack15Black.copyWith(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
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
                            field(text: ""),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Mobile number"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(
                                text: controller.claimDetail
                                    .value["borrowerContactNumber"]),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Email id"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(
                                text: controller.claimDetail
                                    .value["borrowerContactNumber"]),
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
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: const SizedBox(),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Loan Account Details",
                              style: CustomFonts.kBlack15Black.copyWith(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 15.0.h,
                            ),
                            smallText(text: "Loan account number"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(
                                text: controller
                                    .claimDetail.value["loanAccountNumber"]),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Loan Type / category"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(
                                text: controller.claimDetail.value["loanType"]),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Loan o/s amt"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(
                                text: controller.claimDetail.value["loanAmount"]
                                    .toString()),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Lender name"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(
                                text: controller.claimDetail.value["loanAmount"]
                                    .toString()),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Lender RM name"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(
                                text: controller.claimDetail.value["loanAmount"]
                                    .toString()),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Lender RM number"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(
                                text: controller.claimDetail.value["loanAmount"]
                                    .toString())
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: const SizedBox(),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Insurance policy details",
                              style: CustomFonts.kBlack15Black.copyWith(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 15.0.h,
                            ),
                            smallText(text: "Insurer name"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(
                                text: controller
                                    .claimDetail.value["insurerName"]),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Borrower policy number"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(
                                text: controller
                                    .claimDetail.value["insurerName"]),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Master policy number"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(
                                text: controller
                                    .claimDetail.value["masterPolNumber"]),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Policy start date"),
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
                                text: "Policy coverage duration ( In years)"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(
                                text: controller
                                    .claimDetail.value["policyCoverageDuration"]
                                    .toString()),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Policy sum assured"),
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
                            smallText(text: "Nominee name"),
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
                            smallText(text: "Nominee relationship"),
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
                            smallText(text: "Contact number"),
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
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: const SizedBox(),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Documentation Upload",
                              style: CustomFonts.kBlack15Black.copyWith(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 15.0.h,
                            ),
                            smallText(text: "Cause of death / Life Insurance"),
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
                                              .causeofDealth.value.isNotEmpty
                                          ? Text(
                                              controller.causeofDealth.value,
                                              style: CustomFonts.kBlack15Black
                                                  .copyWith(fontSize: 14.0),
                                            )
                                          : Text(
                                              "Choose the cause ",
                                              style: CustomFonts.kBlack15Black
                                                  .copyWith(fontSize: 14.0),
                                            ),
                                    ),
                                    underline: const SizedBox(),
                                    items: <String>[
                                      'Accident',
                                      'Natural Dealth',
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
                                      controller.causeofDealth.value = value!;
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
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Filled & Signed Claim form"),
                            const SizedBox(
                              height: 5.0,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      child: Obx(() => Text(
                                            "${controller.filled.value}",
                                            style: CustomFonts.kBlack15Black
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.0),
                                          )),
                                    ),
                                  ),
                                  const Spacer(),
                                  MaterialButton(
                                    elevation: 1.0,
                                    onPressed: () async {
                                      var file = await controller.uploadFile();
                                      print(file);
                                      controller.filled.value = basename(file);
                                      controller.filledPath.value = file;
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
                            smallText(text: "Dealth certificate"),
                            const SizedBox(
                              height: 5.0,
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
                                            "${controller.dealthCertificate.value}",
                                            style: CustomFonts.kBlack15Black
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.0),
                                          )),
                                    ),
                                    fit: FlexFit.tight,
                                  ),
                                  const Spacer(),
                                  MaterialButton(
                                    elevation: 1.0,
                                    onPressed: () async {
                                      var file = await controller.uploadFile();
                                      print(file);
                                      controller.dealthCertificate.value =
                                          basename(file);
                                      controller.deathCertificatePath.value =
                                          file;
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
                            Text(
                              "KYC - Borrower",
                              style: CustomFonts.kBlack15Black.copyWith(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Id proof"),
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
                                              .borroweridProof.value.isNotEmpty
                                          ? Text(
                                              controller.borroweridProof.value,
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
                                      'Bank Passbook',
                                      'Any other Govt ID Card',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.borroweridProof.value = value!;
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
                                            "${controller.borroweridProofDoc.value}",
                                            style: CustomFonts.kBlack15Black
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.0),
                                          )),
                                    ),
                                    fit: FlexFit.tight,
                                  ),
                                  const Spacer(),
                                  MaterialButton(
                                    elevation: 1.0,
                                    onPressed: () async {
                                      var file = await controller.uploadFile();
                                      print(file);
                                      controller.borroweridProofDoc.value =
                                          basename(file);
                                      controller.borrowerIdDocPath.value = file;
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
                            smallText(text: "Address Proof"),
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
                                      child: controller.borrowerAddressProof
                                              .value.isNotEmpty
                                          ? Text(
                                              controller
                                                  .borrowerAddressProof.value,
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
                                      'Bank Passbook',
                                      'Any other Govt ID Card',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.borrowerAddressProof.value =
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
                                            "${controller.borrowerAddressProofDoc.value}",
                                            style: CustomFonts.kBlack15Black
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.0),
                                          )),
                                    ),
                                    fit: FlexFit.tight,
                                  ),
                                  const Spacer(),
                                  MaterialButton(
                                    elevation: 1.0,
                                    onPressed: () async {
                                      var file = await controller.uploadFile();
                                      print(file);
                                      controller.borrowerAddressProofDoc.value =
                                          basename(file);
                                      controller.borrowerAddressDocPath.value =
                                          file;
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
                            Text(
                              "KYC - Nominee",
                              style: CustomFonts.kBlack15Black.copyWith(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Id proof"),
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
                                      'Bank Passbook',
                                      'Any other Govt ID Card',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.nomineeIdProof.value = value!;
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
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.0),
                                          )),
                                    ),
                                    fit: FlexFit.tight,
                                  ),
                                  const Spacer(),
                                  MaterialButton(
                                    elevation: 1.0,
                                    onPressed: () async {
                                      var file = await controller.uploadFile();
                                      print(file);
                                      controller.nomineeIdProofDoc.value =
                                          basename(file);
                                      controller.nomineeIdDocPath.value = file;
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
                            smallText(text: "Address Proof"),
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
                                      child: controller.nomineeAddressProof
                                              .value.isNotEmpty
                                          ? Text(
                                              controller
                                                  .nomineeAddressProof.value,
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
                                      'Bank Passbook',
                                      'Any other Govt ID Card',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.nomineeAddressProof.value =
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
                                    fit: FlexFit.tight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Obx(() => Text(
                                            "${controller.nomineeAddressProofDoc.value}",
                                            style: CustomFonts.kBlack15Black
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.0),
                                          )),
                                    ),
                                  ),
                                  const Spacer(),
                                  MaterialButton(
                                    elevation: 1.0,
                                    onPressed: () async {
                                      var file = await controller.uploadFile();
                                      print(file);
                                      controller.nomineeAddressProofDoc.value =
                                          basename(file);
                                      controller.nomineeAddressDocPath.value =
                                          file;
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
                            smallText(text: "Bank A/C proof"),
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
                                      'Bank passbook',
                                      'Bank statement',
                                      'Cheque',
                                      'Neft form',
                                      'Other',
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
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.0),
                                          )),
                                    ),
                                  ),
                                  const Spacer(),
                                  MaterialButton(
                                    elevation: 1.0,
                                    onPressed: () async {
                                      var file = await controller.uploadFile();
                                      print(file);
                                      controller.bankProofDoc.value =
                                          basename(file);
                                      controller.bankAccountDocPath.value =
                                          file;
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
                            controller.causeofDealth.value == "Accident"
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      smallText(
                                          text: "FIR / postmortem report"),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Obx(() => Text(
                                                      "${controller.firProof.value}",
                                                      style: CustomFonts
                                                          .kBlack15Black
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14.0),
                                                    )),
                                              ),
                                              fit: FlexFit.tight,
                                            ),
                                            const Spacer(),
                                            MaterialButton(
                                              elevation: 1.0,
                                              onPressed: () async {
                                                var file = await controller
                                                    .uploadFile();
                                                print(file);
                                                controller.firProof.value =
                                                    basename(file);
                                                controller
                                                    .firOrPostmortemReportPath
                                                    .value = file;
                                              },
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: kGrey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              color: Colors.white,
                                              child: Text("Upload",
                                                  style: CustomFonts
                                                      .kBlack15Black
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
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Additional document"),
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
                                              .additionalProof.value.isNotEmpty
                                          ? Text(
                                              controller.additionalProof.value,
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
                                      'Income Tax Return',
                                      'Medical Records',
                                      'Legal Heir Certificate',
                                      'Police Investigation Report',
                                      'Other',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.additionalProof.value = value!;
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
                                            "${controller.additionalProofDoc.value}",
                                            style: CustomFonts.kBlack15Black
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.0),
                                          )),
                                    ),
                                  ),
                                  const Spacer(),
                                  MaterialButton(
                                    elevation: 1.0,
                                    onPressed: () async {
                                      var file = await controller.uploadFile();
                                      print(file);
                                      controller.additionalProofDoc.value =
                                          basename(file);
                                      controller.additionalDocpath.value = file;
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
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  customStepperForm() {
    return Container(
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
                            fontWeight: FontWeight.w700,
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
                          text: controller.claimDetail.value["borrowerName"]
                              .toString()),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Date of Birth"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      field(text: ""),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Mobile number"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      field(
                          text: controller
                              .claimDetail.value["borrowerContactNumber"]),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Email id"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      field(
                          text: controller
                              .claimDetail.value["borrowerContactNumber"]),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Address"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      addressField(
                          text: controller.claimDetail.value["borrowerAddress"])
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
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 15.0.h,
                      ),
                      smallText(text: "Loan account number"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      field(
                          text: controller
                              .claimDetail.value["loanAccountNumber"]),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Loan Type / category"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      field(text: controller.claimDetail.value["loanType"]),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Loan o/s amt"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      field(
                          text: controller.claimDetail.value["loanAmount"]
                              .toString()),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Lender name"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      field(
                          text: controller.claimDetail.value["loanAmount"]
                              .toString()),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Lender RM name"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      field(
                          text: controller.claimDetail.value["loanAmount"]
                              .toString()),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Lender RM number"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      field(
                          text: controller.claimDetail.value["loanAmount"]
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
                        "Insurance policy details",
                        style: CustomFonts.kBlack15Black.copyWith(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 15.0.h,
                      ),
                      smallText(text: "Insurer name"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      field(text: controller.claimDetail.value["insurerName"]),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Borrower policy number"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      field(text: controller.claimDetail.value["insurerName"]),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Master policy number"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      field(
                          text:
                              controller.claimDetail.value["masterPolNumber"]),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Policy start date"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      field(
                          text:
                              controller.claimDetail.value["policyStartDate"] !=
                                      null
                                  ? dateChange(controller
                                      .claimDetail.value["policyStartDate"])
                                  : ""),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Policy coverage duration ( In years)"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      field(
                          text: controller
                              .claimDetail.value["policyCoverageDuration"]
                              .toString()),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Policy sum assured"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      field(
                          text: controller.claimDetail.value["policySumAssured"]
                              .toString()),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Nominee name"),
                      const SizedBox(
                        height: 5.0,
                      ),
                      field(
                          text: controller.claimDetail.value["nomineeName"]
                              .toString()),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Nominee relationship"),
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
                      smallText(text: "Contact number"),
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
                          text: controller.claimDetail.value["nomineeEmailId"])
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Documentation Upload",
                        style: CustomFonts.kBlack15Black.copyWith(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 15.0.h,
                      ),
                      smallText(text: "Cause of death / Life Insurance"),
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
                                child: controller.causeofDealth.value.isNotEmpty
                                    ? Text(
                                        controller.causeofDealth.value,
                                        style: CustomFonts.kBlack15Black
                                            .copyWith(fontSize: 14.0),
                                      )
                                    : Text(
                                        "Choose the cause ",
                                        style: CustomFonts.kBlack15Black
                                            .copyWith(fontSize: 14.0),
                                      ),
                              ),
                              underline: const SizedBox(),
                              items: <String>[
                                'Accident',
                                'Natural Dealth',
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
                                controller.causeofDealth.value = value!;
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
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Filled & Signed Claim form"),
                      const SizedBox(
                        height: 5.0,
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Obx(() => Text(
                                      "${controller.filled.value}",
                                      style: CustomFonts.kBlack15Black.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0),
                                    )),
                              ),
                            ),
                            const Spacer(),
                            MaterialButton(
                              elevation: 1.0,
                              onPressed: () async {
                                var file = await controller.uploadFile();
                                print(file);
                                controller.filled.value = basename(file);
                                controller.filledPath.value = file;
                              },
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: kGrey),
                                  borderRadius: BorderRadius.circular(5.0)),
                              color: Colors.white,
                              child: Text("Upload",
                                  style: CustomFonts.kBlack15Black.copyWith(
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
                      smallText(text: "Dealth certificate"),
                      const SizedBox(
                        height: 5.0,
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
                                      "${controller.dealthCertificate.value}",
                                      style: CustomFonts.kBlack15Black.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0),
                                    )),
                              ),
                              fit: FlexFit.tight,
                            ),
                            const Spacer(),
                            MaterialButton(
                              elevation: 1.0,
                              onPressed: () async {
                                var file = await controller.uploadFile();
                                print(file);
                                controller.dealthCertificate.value =
                                    basename(file);
                                controller.deathCertificatePath.value = file;
                              },
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: kGrey),
                                  borderRadius: BorderRadius.circular(5.0)),
                              color: Colors.white,
                              child: Text("Upload",
                                  style: CustomFonts.kBlack15Black.copyWith(
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
                      Text(
                        "KYC - Borrower",
                        style: CustomFonts.kBlack15Black.copyWith(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Id proof"),
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
                                child:
                                    controller.borroweridProof.value.isNotEmpty
                                        ? Text(
                                            controller.borroweridProof.value,
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
                                'Bank Passbook',
                                'Any other Govt ID Card',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                controller.borroweridProof.value = value!;
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
                                      "${controller.borroweridProofDoc.value}",
                                      style: CustomFonts.kBlack15Black.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0),
                                    )),
                              ),
                              fit: FlexFit.tight,
                            ),
                            const Spacer(),
                            MaterialButton(
                              elevation: 1.0,
                              onPressed: () async {
                                var file = await controller.uploadFile();
                                print(file);
                                controller.borroweridProofDoc.value =
                                    basename(file);
                                controller.borrowerIdDocPath.value = file;
                              },
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: kGrey),
                                  borderRadius: BorderRadius.circular(5.0)),
                              color: Colors.white,
                              child: Text("Upload",
                                  style: CustomFonts.kBlack15Black.copyWith(
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
                      smallText(text: "Address Proof"),
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
                                        .borrowerAddressProof.value.isNotEmpty
                                    ? Text(
                                        controller.borrowerAddressProof.value,
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
                                'Bank Passbook',
                                'Any other Govt ID Card',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                controller.borrowerAddressProof.value = value!;
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
                                      "${controller.borrowerAddressProofDoc.value}",
                                      style: CustomFonts.kBlack15Black.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0),
                                    )),
                              ),
                              fit: FlexFit.tight,
                            ),
                            const Spacer(),
                            MaterialButton(
                              elevation: 1.0,
                              onPressed: () async {
                                var file = await controller.uploadFile();
                                print(file);
                                controller.borrowerAddressProofDoc.value =
                                    basename(file);
                                controller.borrowerAddressDocPath.value = file;
                              },
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: kGrey),
                                  borderRadius: BorderRadius.circular(5.0)),
                              color: Colors.white,
                              child: Text("Upload",
                                  style: CustomFonts.kBlack15Black.copyWith(
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
                      Text(
                        "KYC - Nominee",
                        style: CustomFonts.kBlack15Black.copyWith(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Id proof"),
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
                                child:
                                    controller.nomineeIdProof.value.isNotEmpty
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
                                'Bank Passbook',
                                'Any other Govt ID Card',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                controller.nomineeIdProof.value = value!;
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
                                      style: CustomFonts.kBlack15Black.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0),
                                    )),
                              ),
                              fit: FlexFit.tight,
                            ),
                            const Spacer(),
                            MaterialButton(
                              elevation: 1.0,
                              onPressed: () async {
                                var file = await controller.uploadFile();
                                print(file);
                                controller.nomineeIdProofDoc.value =
                                    basename(file);
                                controller.nomineeIdDocPath.value = file;
                              },
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: kGrey),
                                  borderRadius: BorderRadius.circular(5.0)),
                              color: Colors.white,
                              child: Text("Upload",
                                  style: CustomFonts.kBlack15Black.copyWith(
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
                      smallText(text: "Address Proof"),
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
                                        .nomineeAddressProof.value.isNotEmpty
                                    ? Text(
                                        controller.nomineeAddressProof.value,
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
                                'Bank Passbook',
                                'Any other Govt ID Card',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                controller.nomineeAddressProof.value = value!;
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
                                      "${controller.nomineeAddressProofDoc.value}",
                                      style: CustomFonts.kBlack15Black.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0),
                                    )),
                              ),
                            ),
                            const Spacer(),
                            MaterialButton(
                              elevation: 1.0,
                              onPressed: () async {
                                var file = await controller.uploadFile();
                                print(file);
                                controller.nomineeAddressProofDoc.value =
                                    basename(file);
                                controller.nomineeAddressDocPath.value = file;
                              },
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: kGrey),
                                  borderRadius: BorderRadius.circular(5.0)),
                              color: Colors.white,
                              child: Text("Upload",
                                  style: CustomFonts.kBlack15Black.copyWith(
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
                      smallText(text: "Bank A/C proof"),
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
                                child: controller.bankProof.value.isNotEmpty
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
                                'Bank passbook',
                                'Bank statement',
                                'Cheque',
                                'Neft form',
                                'Other',
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
                                      style: CustomFonts.kBlack15Black.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0),
                                    )),
                              ),
                            ),
                            const Spacer(),
                            MaterialButton(
                              elevation: 1.0,
                              onPressed: () async {
                                var file = await controller.uploadFile();
                                print(file);
                                controller.bankProofDoc.value = basename(file);
                                controller.bankAccountDocPath.value = file;
                              },
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: kGrey),
                                  borderRadius: BorderRadius.circular(5.0)),
                              color: Colors.white,
                              child: Text("Upload",
                                  style: CustomFonts.kBlack15Black.copyWith(
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
                      controller.causeofDealth.value == "Accident"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                smallText(text: "FIR / postmortem report"),
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
                                                "${controller.firProof.value}",
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
                                          var file =
                                              await controller.uploadFile();
                                          print(file);
                                          controller.firProof.value =
                                              basename(file);
                                          controller.firOrPostmortemReportPath
                                              .value = file;
                                        },
                                        shape: RoundedRectangleBorder(
                                            side:
                                                const BorderSide(color: kGrey),
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
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      smallText(text: "Additional document"),
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
                                child:
                                    controller.additionalProof.value.isNotEmpty
                                        ? Text(
                                            controller.additionalProof.value,
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
                                'Income Tax Return',
                                'Medical Records',
                                'Legal Heir Certificate',
                                'Police Investigation Report',
                                'Other',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                controller.additionalProof.value = value!;
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
                                      "${controller.additionalProofDoc.value}",
                                      style: CustomFonts.kBlack15Black.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0),
                                    )),
                              ),
                            ),
                            const Spacer(),
                            MaterialButton(
                              elevation: 1.0,
                              onPressed: () async {
                                var file = await controller.uploadFile();
                                print(file);

                                controller.additionalProofDoc.value =
                                    basename(file);
                                controller.additionalDocpath.value = file;
                              },
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: kGrey),
                                  borderRadius: BorderRadius.circular(5.0)),
                              color: Colors.white,
                              child: Text("Upload",
                                  style: CustomFonts.kBlack15Black.copyWith(
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
                  ),
                )
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
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.ease);
                          controller.currentIndex.value =
                              controller.currentIndex.value - 1;
                        }
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
                        if (controller.currentIndex.value < 3) {
                          controller.pageController.animateToPage(
                              controller.currentIndex.value + 1,
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.ease);
                          controller.currentIndex.value =
                              controller.currentIndex.value + 1;
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color(0xff134E85),
                            border: Border.all(color: const Color(0xff134E85)),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: const Center(
                            child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    )),
              ],
            ),
          )
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
              for (int i = 0; i < 4; i++)
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
                    i != 3
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

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 3 ? setState(() => _currentStep += 1) : null;
    if (_currentStep == 3) {
      controller.uploadFormData();
    }
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
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
    return temp.toString();
  }
}
