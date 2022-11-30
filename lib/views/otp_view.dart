//
//
//
// // ignore: must_be_immutable
// import 'package:alt_sms_autofill/alt_sms_autofill.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:punchin/constant/const_text.dart';
//
// class MobileLogin extends StatefulWidget {
//   const MobileLogin({Key? key}) : super(key: key);
//
//   @override
//   State<MobileLogin> createState() => _MobileLoginState();
// }
//
// class _MobileLoginState extends State<MobileLogin> {
//
//   TextEditingController mobile=TextEditingController();
//   //Authentication authentication= Get.put(Authentication());
//   late PageController controller1;
//
//   GlobalKey<PageContainerState> key = GlobalKey();
//   bool islogin = false;
//   _changeScreen() {
//
//     setState(() { // sets it to the opposite of the current screen
//
//       islogin = !islogin; print(islogin);
//
//     });
//
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
//   TextEditingController otpController=TextEditingController();
//   // var mobile=Get.arguments;
//
//
//
//
//   RxBool isloading=true.obs;
//   RxBool isotpFill =true.obs;
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
//       otpController.text = _commingSms![52] + _commingSms![53]+_commingSms![54] + _commingSms![55]+_commingSms![56]  ;
//     });
//   }
//
//
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
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context,constraints){
//       return WillPopScope(
//
//         onWillPop: ()async {
//           islogin = false;
//           return false;
//
//         },
//         child: Scaffold(
//           // backgroundColor: Colors.transparent,
//           backgroundColor: Color.fromRGBO(0, 0, 0, 1),
//           body: Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//
//
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//
//                       // Container(
//                       //   child: Padding(
//                       //     padding: const EdgeInsets.symmetric(horizontal: 44.0),
//                       //     child: Row(
//                       //       mainAxisAlignment: MainAxisAlignment.center,
//                       //       children: [
//                       //
//                       //         Expanded(
//                       //           child: RichText(
//                       //             maxLines: 3,
//                       //             textAlign: TextAlign.center,
//                       //             text: TextSpan(
//                       //               children: [
//                       //                 TextSpan(
//                       //                   text:
//                       //                   "Please enter the code we just sent to",
//                       //                   style: GoogleFonts.inter(
//                       //                       textStyle: kBody16kBlack700),),
//                       //                 TextSpan(
//                       //                     text: " (+91) ${mobile.text}",
//                       //                     style: GoogleFonts.inter(
//                       //                         textStyle: kBody16kBlack700
//                       //                             .copyWith(color: kwhitecolor)),
//                       //                     recognizer: TapGestureRecognizer()
//                       //                       ..onTap = () {
//                       //                         //Get.to(() => EmailLoginScreen());
//                       //                       }),
//                       //                 TextSpan(
//                       //                     text: " to proceed ",
//                       //                     style: GoogleFonts.inter(
//                       //                       textStyle: kBody16kBlack700,)
//                       //                 ),
//                       //               ],
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ],
//                       //     ),
//                       //   ),
//                       // ),
//                       const SizedBox(
//                         height: 18,
//                       ),
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 47),
//                         child: Container(
//
//                           child: PinCodeTextField(
//                             keyboardType: TextInputType.number,
//                             length: 5,
//                             controller: otpController,
//                             appContext: context,
//                             enableActiveFill: true,
//                             autoDismissKeyboard : true,
//                             inputFormatters: <TextInputFormatter>[
//                               FilteringTextInputFormatter.digitsOnly
//                             ],
//                             textStyle: TextStyle(
//                                 color: Colors.white
//                             ),
//                             autoDisposeControllers: false,
//                             pinTheme: PinTheme(
//                               fieldHeight: 42,
//                               fieldWidth: 42,
//                               shape: PinCodeFieldShape.box,
//
//                               inactiveColor: Color.fromRGBO(217, 217, 217, 0.2),
//
//                               inactiveFillColor:Color.fromRGBO(217, 217, 217, 0.2),
//                               activeColor: Color.fromRGBO(217, 217, 217, 0.2),
//                               selectedColor: Color.fromRGBO(217, 217, 217, 0.2),
//                               //activeFillColor: Colors.white,
//                               activeFillColor: Color.fromRGBO(217, 217, 217, 0.2),//klightBlack,
//                               disabledColor:Color.fromRGBO(217, 217, 217, 0.2),
//
//                               selectedFillColor: Color.fromRGBO(217, 217, 217, 0.2),
//                               borderRadius: BorderRadius.circular(7),
//                               borderWidth: 0,
//
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
//
//                       const SizedBox(
//                         height: 8,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 28),
//                         child: TweenAnimationBuilder<Duration>(
//                             duration: Duration(seconds: 30),
//                             tween: Tween(begin: Duration(seconds: 30), end: Duration
//                                 .zero),
//                             onEnd: () {
//                               isloading.value = false;
//                             },
//                             builder: (BuildContext context, Duration value,
//                                 Widget? child) {
//                               final minutes = value.inSeconds;
//                               final seconds = value.inSeconds % 60;
//                               return Padding(
//                                   padding: const EdgeInsets.symmetric(vertical: 0),
//                                   child: Text('0:$seconds',
//                                       textAlign: TextAlign.center,
//                                       style: GoogleFonts.inter(
//                                           textStyle: KBody13white700)));
//                             }),
//                       ),
//
//                       const SizedBox(
//                         height: 11,
//                       ),
//
//
//                       //
//                       // Padding(
//                       //   padding: const EdgeInsets.symmetric(horizontal: 28.0),
//                       //   child: Obx(() =>
//                       //   isotpFill.value == false ? RoundedLoadingButton(
//                       //     width: Get.width,
//                       //     height: 44,
//                       //     color: kwhitecolor,
//                       //     successColor: kgreencolor,
//                       //     controller: authentication.btncontroller.value,
//                       //     onPressed: () {
//                       //       authentication.postverifyOtp(
//                       //           mobile.text, otpController.text);
//                       //     },
//                       //     valueColor: kblack,
//                       //     borderRadius: 5,
//                       //     resetDuration: const Duration(seconds: 3),
//                       //     child: GradientText(
//                       //       "CONTINUE",
//                       //       style: GoogleFonts.inter(textStyle: KBody13white600),
//                       //       gradient: LinearGradient(colors: ContinueTextColor
//                       //       ),
//                       //     ),
//                       //   ) :
//                       //   Container(
//                       //     decoration: BoxDecoration(
//                       //         borderRadius: BorderRadius.circular(5),
//                       //         color: kdisablecolor
//                       //     ),
//                       //     height: 44,
//                       //     width: Get.width,
//                       //     child: OutlinedButton(
//                       //       onPressed: () {},
//                       //       child: Text("CONTINUE", style: GoogleFonts.inter(
//                       //           textStyle: KBody13disableText600),),
//                       //     ),
//                       //   ),),
//                       // ),
//                       // const SizedBox(
//                       //   height: 18,
//                       // ),
//                       // GestureDetector(
//                       //   onTap: () {
//                       //     Get.to(() => WelcomeScreen());
//                       //   },
//                       //   child: Padding(
//                       //     padding: const EdgeInsets.symmetric(horizontal: 28.0),
//                       //     child: Text("TROUBLE LOGGING IN?",
//                       //       style: GoogleFonts.inter(textStyle: KBody13white700,),
//                       //     ),
//                       //   ),
//                       // ),
//
//
//                       // Align(
//                       //   alignment: Alignment.bottomCenter,
//                       //   child: Container(
//                       //     child: Padding(
//                       //       padding: const EdgeInsets.symmetric(horizontal: 28.0),
//                       //       child: Row(
//                       //         mainAxisAlignment: MainAxisAlignment.center,
//                       //         children: [
//                       //           Expanded(
//                       //             child: RichText(
//                       //               maxLines: 3,
//                       //               textAlign : TextAlign.center,
//                       //               text: TextSpan(
//                       //                 children: [
//                       //                   TextSpan(
//                       //                     text:
//                       //                     "By continuing you agree to the",
//                       //                     style: GoogleFonts.inter(
//                       //                         textStyle: KBody10kBlack600),),
//                       //                   TextSpan(
//                       //                       text: " Terms of services ",
//                       //                       style: GoogleFonts.inter(
//                       //                           textStyle: KBody10white600),
//                       //                       recognizer: TapGestureRecognizer()
//                       //                         ..onTap = () {
//                       //                           //Get.to(() => EmailLoginScreen());
//                       //                         }),
//                       //                   TextSpan(
//                       //                     text: " and ",
//                       //                     style: GoogleFonts.inter(
//                       //                         textStyle: KBody10kBlack600),
//                       //                   ),
//                       //                   TextSpan(
//                       //                       text: " Privacy Policy",
//                       //                       style: GoogleFonts.inter(
//                       //                           textStyle: KBody10white600),
//                       //                       recognizer: TapGestureRecognizer()
//                       //                         ..onTap = () {
//                       //                           //   Get.to(() => EmailLoginScreen());
//                       //                         }),
//                       //                 ],
//                       //               ),
//                       //             ),
//                       //           ),
//                       //         ],
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ),
//
//                     ],
//                   ),
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }