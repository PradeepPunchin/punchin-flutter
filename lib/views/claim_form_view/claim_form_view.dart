import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';

import '../../controller/claim_form_controller.dart';

class ClaimFormView extends StatefulWidget {
  const ClaimFormView({Key? key}) : super(key: key);

  @override
  State<ClaimFormView> createState() => _ClaimFormViewState();
}

class _ClaimFormViewState extends State<ClaimFormView> {
  final controller = Get.put(ClaimFormController());
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  List forms = <Widget>[
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Borrower Details",
          style: CustomFonts.kBlack15Black.copyWith(
              fontSize: 15.0, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        SizedBox(
          height: 15.0.h,
        ),
        smallText(text: "Name"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "34675000002146"),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Date of Birth"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "10-12-1977"),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Mobile number"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "9876543210"),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Email id"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "sanjayp@gmail.com"),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Address"),
        const SizedBox(
          height: 5.0,
        ),
        addressField(
            text:
                "H No - 36, Masjid Bunder road, Mohalla no-12,Gaur Gali, Hyderabad")
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Loan Account Details",
          style: CustomFonts.kBlack15Black.copyWith(
              fontSize: 15.0, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        SizedBox(
          height: 15.0.h,
        ),
        smallText(text: "Loan account number"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "34675000002146"),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Loan Type / category"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "Housing Loan "),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Loan o/s amt"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "1,235,700.00"),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Lender name"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "ABC Bank"),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Lender RM name"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "Ashish Kumar"),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Lender RM number"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "9761245896")
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Insurance policy details",
          style: CustomFonts.kBlack15Black.copyWith(
              fontSize: 15.0, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        SizedBox(
          height: 15.0.h,
        ),
        smallText(text: "Insurer name"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "HDFC"),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Borrower policy number"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "201304672"),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Master policy number"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "45296/18"),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Policy start date"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "4/1/2018"),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Policy coverage duration ( In years)"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "12"),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Policy sum assured"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "1,500,000"),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Nominee name"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "Sanjay Prakash"),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Nominee relationship"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "Son"),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Contact number"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "9462302854"),
        const SizedBox(
          height: 10.0,
        ),
        smallText(text: "Email Id"),
        const SizedBox(
          height: 5.0,
        ),
        field(text: "sanjayp@gmail.com")
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
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
              "Case/Claim ID :  27193",
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
      body: stepperForm(),
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
                            field(text: "34675000002146"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Date of Birth"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(text: "10-12-1977"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Mobile number"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(text: "9876543210"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Email id"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(text: "sanjayp@gmail.com"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Address"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            addressField(
                                text:
                                    "H No - 36, Masjid Bunder road, Mohalla no-12,Gaur Gali, Hyderabad")
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
                            field(text: "34675000002146"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Loan Type / category"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(text: "Housing Loan "),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Loan o/s amt"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(text: "1,235,700.00"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Lender name"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(text: "ABC Bank"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Lender RM name"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(text: "Ashish Kumar"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Lender RM number"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(text: "9761245896")
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
                            field(text: "HDFC"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Borrower policy number"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(text: "201304672"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Master policy number"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(text: "45296/18"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Policy start date"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(text: "4/1/2018"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(
                                text: "Policy coverage duration ( In years)"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(text: "12"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Policy sum assured"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(text: "1,500,000"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Nominee name"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(text: "Sanjay Prakash"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Nominee relationship"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(text: "Son"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Contact number"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(text: "9462302854"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Email Id"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            field(text: "sanjayp@gmail.com")
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
                            imagePick(certificate: "Scan 1"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Dealth certificate"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            imagePick(certificate: "Dealth Certificate"),
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
                                              .document.value.isNotEmpty
                                          ? Text(
                                              controller.document.value,
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
                                      controller.document.value = value!;
                                    },
                                  )),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            imagePick(certificate: "Aadhaar Card.jpeg"),
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
                                              .document.value.isNotEmpty
                                          ? Text(
                                              controller.document.value,
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
                                      controller.document.value = value!;
                                    },
                                  )),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            imagePick(certificate: "Aadhaar Card.jpeg"),
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
                                              .document.value.isNotEmpty
                                          ? Text(
                                              controller.document.value,
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
                                      controller.document.value = value!;
                                    },
                                  )),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            imagePick(certificate: "Aadhaar Card.jpeg"),
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
                                              .document.value.isNotEmpty
                                          ? Text(
                                              controller.document.value,
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
                                      controller.document.value = value!;
                                    },
                                  )),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            imagePick(certificate: "Aadhaar Card.jpeg"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "Bank a/c proof"),
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
                                              .document.value.isNotEmpty
                                          ? Text(
                                              controller.document.value,
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
                                      controller.document.value = value!;
                                    },
                                  )),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            imagePick(certificate: "Aadhaar Card.jpeg"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            smallText(text: "FIR / postmortem report"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            imagePick(certificate: "Aadhaar Card.jpeg"),
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
                                              .document.value.isNotEmpty
                                          ? Text(
                                              controller.document.value,
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
                                      controller.document.value = value!;
                                    },
                                  )),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            imagePick(certificate: "Aadhaar Card.jpeg"),
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

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 3 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  static Widget field({text}) => Container(
        child: TextFormField(
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
            title: Text("Major"),
            value: "Major",
            groupValue: controller.nominee.value,
            activeColor: kdarkBlue,
            onChanged: (value) {
              setState(() {
                controller.nominee.value = value.toString();
              });
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: RadioListTile(
            title: Text("Minor"),
            value: "Minor",
            groupValue: controller.nominee.value,
            activeColor: kdarkBlue,
            onChanged: (value) {
              setState(() {
                controller.nominee.value = value.toString();
              });
            },
          ),
        ),
        Expanded(
          child: SizedBox(),
          flex: 1,
        )
      ],
    );
  }

  Widget imagePick({certificate}) => Container(
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
            Spacer(),
            MaterialButton(
              elevation: 1.0,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: kGrey),
                  borderRadius: BorderRadius.circular(5.0)),
              color: Colors.white,
              child: Text("Upload",
                  style: CustomFonts.kBlack15Black
                      .copyWith(fontSize: 15.0, fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      );
}
