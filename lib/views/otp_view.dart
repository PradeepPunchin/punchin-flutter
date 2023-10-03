// // ignore: must_be_immutable
// import 'package:alt_sms_autofill/alt_sms_autofill.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:punchin/constant/const_text.dart';
//
// import '../constant/const_color.dart';
//
// class MobileLogin extends StatefulWidget {
//   const MobileLogin({Key? key}) : super(key: key);
//
//   @override
//   State<MobileLogin> createState() => _MobileLoginState();
// }
//
// class _MobileLoginState extends State<MobileLogin> {
//   TextEditingController mobile = TextEditingController();
//
//   //Authentication authentication= Get.put(Authentication());
//   late PageController controller1;
//
//   // GlobalKey<PageContainerState> key = GlobalKey();
//   bool islogin = false;
//
//   _changeScreen() {
//     setState(() {
//       // sets it to the opposite of the current screen
//
//       islogin = !islogin;
//       print(islogin);
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     controller1 = PageController();
//
//     initSmsListener();
//   }
//
//   TextEditingController otpController = TextEditingController();
//
//   // var mobile=Get.arguments;
//
//   RxBool isloading = true.obs;
//   RxBool isotpFill = true.obs;
//   String? _commingSms = '';
//
//   Future<void> initSmsListener() async {
//     String? commingSms;
//     try {
//       commingSms = await AltSmsAutofill().listenForSms;
//     } on PlatformException {
//       commingSms = 'Failed to get Sms.';
//     }
//     if (!mounted) return;
//
//     setState(() {
//       _commingSms = commingSms;
//       otpController.text = _commingSms![52] +
//           _commingSms![53] +
//           _commingSms![54] +
//           _commingSms![55] +
//           _commingSms![56];
//     });
//   }
//
//   @override
//   void dispose() {
//     controller1.dispose();
//     AltSmsAutofill().unregisterListener();
//     super.dispose();
//   }
//
//   int counter = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       return WillPopScope(
//         onWillPop: () async {
//           islogin = false;
//           return false;
//         },
//         child: Scaffold(
//           // backgroundColor: Colors.transparent,
//           backgroundColor: Colors.white,
//           body: Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: Get.height * 0.12,
//                       ),
//                       Image.asset("assets/insurance.png"),
//                       SizedBox(
//                         height: 15.0.h,
//                       ),
//                       Center(child: Image.asset("assets/img.png")),
//                       SizedBox(
//                         height: Get.height * 0.05,
//                       ),
//                       Text(
//                         "Verify Your Number ",
//                         style: CustomFonts.getMultipleStyle(
//                             15.0, kBlack, FontWeight.w400),
//                       ),
//                       SizedBox(
//                         height: 10.0.h,
//                       ),
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 20),
//                         child: Text(
//                           "We have sent a 6 digit OTP on your phone number please enter and verify",
//                           style: CustomFonts.kBlack15Black.copyWith(
//                             fontSize: 14.0,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10.0.h,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 47),
//                         child: Container(
//                           child: PinCodeTextField(
//                             keyboardType: TextInputType.number,
//                             length: 6,
//                             controller: otpController,
//                             appContext: context,
//                             enableActiveFill: true,
//                             autoDismissKeyboard: true,
//                             inputFormatters: <TextInputFormatter>[
//                               FilteringTextInputFormatter.digitsOnly
//                             ],
//                             textStyle: TextStyle(color: Colors.white),
//                             autoDisposeControllers: false,
//                             pinTheme: PinTheme(
//                               fieldHeight: 42,
//                               fieldWidth: 42,
//                               shape: PinCodeFieldShape.box,
//
//                               inactiveColor: Color.fromRGBO(217, 217, 217, 0.2),
//
//                               inactiveFillColor:
//                                   Color.fromRGBO(217, 217, 217, 0.2),
//                               activeColor: Color.fromRGBO(217, 217, 217, 0.2),
//                               selectedColor: Color.fromRGBO(217, 217, 217, 0.2),
//                               //activeFillColor: Colors.white,
//                               activeFillColor:
//                                   Color.fromRGBO(217, 217, 217, 0.2),
//                               //klightBlack,
//                               disabledColor: Color.fromRGBO(217, 217, 217, 0.2),
//
//                               selectedFillColor:
//                                   Color.fromRGBO(217, 217, 217, 0.2),
//                               borderRadius: BorderRadius.circular(7),
//                               borderWidth: 0,
//                             ),
//                             onCompleted: (String sms) {
//                               isotpFill.value = false;
//                               // authentication.postverifyOtp(
//                               //     mobile.text, otpController.text);
//                             },
//                             onChanged: (String value) {
//                               if (otpController.text.length < 5) {
//                                 // authentication.postverifyOtp(
//                                 //     mobile.text, otpController.text);
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 8,
//                       ),
//                       // Padding(
//                       //   padding: const EdgeInsets.symmetric(horizontal: 28),
//                       //   child: TweenAnimationBuilder<Duration>(
//                       //       duration: Duration(seconds: 30),
//                       //       tween: Tween(
//                       //           begin: Duration(seconds: 30),
//                       //           end: Duration.zero),
//                       //       onEnd: () {
//                       //         isloading.value = false;
//                       //       },
//                       //       builder: (BuildContext context, Duration value,
//                       //           Widget? child) {
//                       //         final minutes = value.inSeconds;
//                       //         final seconds = value.inSeconds % 60;
//                       //         return Padding(
//                       //             padding:
//                       //                 const EdgeInsets.symmetric(vertical: 0),
//                       //             child: Text('0:$seconds',
//                       //                 textAlign: TextAlign.center,
//                       //                 style: GoogleFonts.inter(
//                       //                     textStyle: KBody13white700)));
//                       //       }),
//                       // ),
//                       Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 15.0),
//                         child: MaterialButton(
//                           height: 53,
//                           minWidth: Get.width,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5.0)),
//                           color: kdarkBlue,
//                           onPressed: () {},
//                           child: Text(
//                             "Submit",
//                             style: CustomFonts.getMultipleStyle(
//                                 15.0, Colors.white, FontWeight.w400),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 11,
//                       ),
//                       Container(
//                         child: Text("Resend OTP",
//                             style: CustomFonts.kBlack15Black.copyWith(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 14.0,
//                                 decoration: TextDecoration.underline)),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
