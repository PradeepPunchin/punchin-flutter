import 'dart:developer'as developer;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'dart:async';
import 'dart:io';
import '../../controller/authentication_controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final loginController = Get.put(LoginController());

 // static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  //Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initPlatformState();
  }


  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  var device = GetStorage();

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};
    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        device.write("deviceinfo", deviceData);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        device.write("deviceinfo", deviceData);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'brand': build.brand,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
    };
  }
  // var deviceData;
  // Future<void> initPlatformState() async {
  //    deviceData = <String, dynamic>{};
  //   developer.log("value of text "+deviceData.toString());
  //   try {
  //
  //       if (Platform.isAndroid) {
  //         deviceData =
  //             _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
  //
  //       }
  //       else if (Platform.isIOS) {
  //         deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
  //       }
  //
  //   } on PlatformException {
  //     deviceData = <String, dynamic>{
  //       'Error:': 'Failed to get platform version.'
  //     };
  //   }
  //
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _deviceData = deviceData;
  //
  //   });
  // }
  //
  // Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  //   return <String, dynamic>{
  //     'version.securityPatch': build.version.securityPatch,
  //     'version.sdkInt': build.version.sdkInt,
  //     'version.release': build.version.release,
  //     'version.previewSdkInt': build.version.previewSdkInt,
  //     'version.incremental': build.version.incremental,
  //     'version.codename': build.version.codename,
  //     'version.baseOS': build.version.baseOS,
  //     'board': build.board,
  //     'bootloader': build.bootloader,
  //     'brand': build.brand,
  //     'device': build.device,
  //     'display': build.display,
  //     'fingerprint': build.fingerprint,
  //     'hardware': build.hardware,
  //     'host': build.host,
  //     'id': build.id,
  //     'manufacturer': build.manufacturer,
  //     'model': build.model,
  //     'product': build.product,
  //     'supported32BitAbis': build.supported32BitAbis,
  //     'supported64BitAbis': build.supported64BitAbis,
  //     'supportedAbis': build.supportedAbis,
  //     'tags': build.tags,
  //     'type': build.type,
  //     'isPhysicalDevice': build.isPhysicalDevice,
  //     'systemFeatures': build.systemFeatures,
  //     'displaySizeInches':
  //     ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
  //     'displayWidthPixels': build.displayMetrics.widthPx,
  //     'displayWidthInches': build.displayMetrics.widthInches,
  //     'displayHeightPixels': build.displayMetrics.heightPx,
  //     'displayHeightInches': build.displayMetrics.heightInches,
  //     'displayXDpi': build.displayMetrics.xDpi,
  //     'displayYDpi': build.displayMetrics.yDpi,
  //   };
  // }
  //
  // Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
  //   return <String, dynamic>{
  //     'name': data.name,
  //     'systemName': data.systemName,
  //     'systemVersion': data.systemVersion,
  //     'model': data.model,
  //     'localizedModel': data.localizedModel,
  //     'identifierForVendor': data.identifierForVendor,
  //     'isPhysicalDevice': data.isPhysicalDevice,
  //     'utsname.sysname:': data.utsname.sysname,
  //     'utsname.nodename:': data.utsname.nodename,
  //     'utsname.release:': data.utsname.release,
  //     'utsname.version:': data.utsname.version,
  //     'utsname.machine:': data.utsname.machine,
  //   };
  // }


  // static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  // Map<String, dynamic> _deviceData = <String, dynamic>{};
  // var device = GetStorage();
  //
  // Future<void> initPlatformState() async {
  //   var deviceData = <String, dynamic>{};
  //   try {
  //     if (Platform.isAndroid) {
  //       deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
  //       device.write("deviceinfo", deviceData);
  //     } else if (Platform.isIOS) {
  //       deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
  //       device.write("deviceinfo", deviceData);
  //     }
  //   } on PlatformException {
  //     deviceData = <String, dynamic>{
  //       'Error:': 'Failed to get platform version.'
  //     };
  //   }
  //
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _deviceData = deviceData;
  //   });
  // }
  //
  // Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  //   return <String, dynamic>{
  //     'brand': build.brand,
  //     'id': build.id,
  //     'manufacturer': build.manufacturer,
  //     'model': build.model,
  //     //'androidId': build.androidId,
  //   };
  // }
  //
  // Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
  //   return <String, dynamic>{
  //     'name': data.name,
  //     'systemName': data.systemName,
  //     'systemVersion': data.systemVersion,
  //     'model': data.model,
  //     'localizedModel': data.localizedModel,
  //     'utsname.sysname:': data.utsname.sysname,
  //     'utsname.nodename:': data.utsname.nodename,
  //   };
  // }

  // static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  // Map<String, dynamic> _deviceData = <String, dynamic>{};
  // var device = GetStorage();
  //
  // Future<void> initPlatformState() async {
  //   var deviceData = <String, dynamic>{};
  //   try {
  //     if (Platform.isAndroid) {
  //       deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
  //       device.write("deviceinfo", deviceData);
  //     } else if (Platform.isIOS) {
  //       deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
  //       device.write("deviceinfo", deviceData);
  //     }
  //   } on PlatformException {
  //     deviceData = <String, dynamic>{
  //       'Error:': 'Failed to get platform version.'
  //     };
  //   }
  //
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _deviceData = deviceData;
  //   });
  // }
  //
  // Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  //   return <String, dynamic>{
  //     'brand': build.brand,
  //     'id': build.id,
  //     'manufacturer': build.manufacturer,
  //     'model': build.model,
  //     'androidId': build.androidId,
  //   };
  // }
  //
  // Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
  //   return <String, dynamic>{
  //     'name': data.name,
  //     'systemName': data.systemName,
  //     'systemVersion': data.systemVersion,
  //     'model': data.model,
  //     'localizedModel': data.localizedModel,
  //     'utsname.sysname:': data.utsname.sysname,
  //     'utsname.nodename:': data.utsname.nodename,
  //   };
  // }



  @override
  Widget build(BuildContext context) {
    developer.log( device.read("deviceinfo").toString());
    return Scaffold(

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: loginController.formKey,
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.12,
              ),
              // Load a Lottie file from your assets
              SizedBox(
                  height: 177,
                  width: 177,
                  child: Lottie.asset('assets/animation/login.json')),
              SizedBox(
                height: 15.0.h,
              ),
              Center(child: Image.asset("assets/img.png")),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Text(
                "Please login to continue",
                style:
                CustomFonts.getMultipleStyle(15.0, kBlack, FontWeight.w400),
              ),
              SizedBox(
                height: 10.0.h,
              ),
              emailContainer(),
              SizedBox(
                height: 15.0.h,
              ),
              phoneContainer(),
              SizedBox(
                height: 15.0.h,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: MaterialButton(
                  height: 53,
                  minWidth: Get.width,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: kdarkBlue,
                  onPressed: () {
                    if (loginController.formKey.currentState!.validate()) {
                      // Get.off(()=>OtpV());
                      loginController.postlogin();//loginController.email.value, loginController.password.value);
                      FocusManager.instance.primaryFocus?.unfocus();


                      //
                    }
                  },
                  child: Text(
                    "Login",
                    style: CustomFonts.getMultipleStyle(
                        15.0, Colors.white, FontWeight.w400),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
  Widget emailContainer() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: kGrey)),
    child: Row(
      children: [
        const Icon(
          Icons.email,
          color: kdarkBlue,
        ),
        SizedBox(
          width: Get.width * 0.05,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "User Id",
                style: CustomFonts.getMultipleStyle(
                    15.0, kBlack, FontWeight.w400),
              ),
              TextFormField(
                controller: loginController.email,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "userid cannot be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Enter your user id",
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    hintStyle: CustomFonts.getMultipleStyle(
                        14.0, kTextFieldGrey, FontWeight.w400),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none),
              )
            ],
          ),
        )
      ],
    ),
  );

  Widget phoneContainer() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: kGrey)),
    child: Row(
      children: [
        const Icon(
          Icons.lock,
          color: kdarkBlue,
        ),
        SizedBox(
          width: Get.width * 0.05,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Password",
                style: CustomFonts.getMultipleStyle(
                    15.0, kBlack, FontWeight.w400),
              ),
              Obx(() => TextFormField(
                controller: loginController.password,
                obscureText: loginController.showPassword.value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        loginController.showPassword.value =
                        !loginController.showPassword.value;
                      },
                      child: loginController.showPassword.value
                          ? const Icon(
                        Icons.visibility_off,
                        size: 20.0,
                        color: kdarkBlue,
                      )
                          : const Icon(
                        Icons.visibility,
                        size: 20.0,
                        color: kdarkBlue,
                      ),
                    ),
                    hintText: "Enter your Password",
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 5),
                    hintStyle: CustomFonts.getMultipleStyle(
                        14.0, kTextFieldGrey, FontWeight.w400),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none),
              ))
            ],
          ),
        )
      ],
    ),
  );
}



// class LoginScreen extends StatelessWidget {
//   LoginScreen({Key? key}) : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//   }
//
//
// }
