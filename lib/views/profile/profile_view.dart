
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/controller/authentication_controller/login_controller.dart';

class ProfileView extends StatelessWidget {
   ProfileView({Key? key}) : super(key: key);

   final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        title: Text(
          "Agent Profile",
          style: kBlack15Black,
        ),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
             onTap: () {
               loginController.postLogout();
                 },//=> Get.to(() => NotificationView()

             //),
            behavior: HitTestBehavior.opaque,
            child: CircleAvatar(
              backgroundColor: Colors.white10,
              radius: 48.0,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red,
                    border: Border.all(width: 2, color: Colors.black12),
                  ),
                  child: const Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  )),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                    child: Container(
                  color: kLightGrey,
                  height: 70.0.h,
                  width: Get.width,
                )),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Image.network("https://images.freeimages.com/images/large-previews/e56/run-away-1555225.jpg"),
                    // CachedNetworkImage(
                    //   imageUrl:
                    //       "https://cvbay.com/wp-content/uploads/2017/03/dummy-image.jpg",
                    //   imageBuilder: (context, imageProvider) {
                    //     return Container(
                    //       height: 90.0.h,
                    //       width: 90.0.w,
                    //       decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           image: DecorationImage(image: imageProvider)),
                    //     );
                    //   },
                    // ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "${GetStorage().read("firstName")} ${GetStorage().read("lastName")}",
              style: kBlack15Black,
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${GetStorage().read("userId")} (${GetStorage().read("role")})",
                  style: kBlack15Black.copyWith(
                    fontSize: 12.0.sp,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  "4.1",
                  style: kBlack15Black.copyWith(
                    fontSize: 12.0.sp,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                ),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  "Rating",
                  style: kBlack15Black.copyWith(
                    fontSize: 12.0.sp,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            tab()
          ],
        ),
      ),
    );
  }

  Widget one() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10.0.h),
            smallText(text: "Email"),
            field(text: "Enter your email address"),
            SizedBox(
              height: 3.0.h,
            ),
            smallText(text: "Mobile Number"),
            field(text: "Enter your mobile number"),
            SizedBox(
              height: 3.0.h,
            ),
            smallText(text: "Street Address"),
            field(text: "Enter your Street Address"),
            SizedBox(
              height: 3.0.h,
            ),
            smallText(text: "City"),
            field(text: "Enter your City "),
            SizedBox(
              height: 3.0.h,
            ),
            smallText(text: "Country"),
            field(text: "Enter your Country "),
            SizedBox(
              height: 3.0.h,
            ),
            smallText(text: "Zip / Postal code"),
            field(text: "Enter your postal code / Zip "),
          ],
        ),
      );

  Widget two() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10.0.h),
            smallText(text: "Supervisor Name"),
            field(text: "Enter your email address"),
            SizedBox(
              height: 3.0.h,
            ),
            smallText(text: "Email"),
            field(text: "Enter your email address"),
            SizedBox(
              height: 3.0.h,
            ),
            smallText(text: "Mobile Number"),
            field(text: "Enter your mobile number"),
            SizedBox(
              height: 3.0.h,
            ),
            smallText(text: "Company Name"),
            field(text: "Punchin"),
            SizedBox(
              height: 3.0.h,
            ),
            smallText(text: "Street Address"),
            field(text: "Enter your Street Address"),
            SizedBox(
              height: 3.0.h,
            ),
            smallText(text: "City"),
            field(text: "Enter your City "),
            SizedBox(
              height: 3.0.h,
            ),
            smallText(text: "Country"),
            field(text: "Enter your Country "),
            SizedBox(
              height: 3.0.h,
            ),
            smallText(text: "Zip / Postal code"),
            field(text: "Enter your postal code / Zip "),
          ],
        ),
      );

  Widget smallText({text}) => Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 5.0.h),
        child: Text(
          text,
          style: kBlack15Black.copyWith(
              fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      );

  Widget field({text}) => Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 0.0.h),
        child: TextFormField(
          decoration: InputDecoration(
              hintText: text,
              hintStyle: kBlack15Black,
              filled: true,
              fillColor: kFilledTextColor,
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

  Widget tab() => DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              child: TabBar(
                labelColor: Colors.black,
                indicatorWeight: 2.0,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: kdarkBlue,
                unselectedLabelStyle:kBlack15Black.copyWith(
                  fontWeight: FontWeight.w500),
                // getMultipleStyle(
                //     15.0, Colors.black, FontWeight.w500),
                isScrollable: false,
                tabs: const [
                  Tab(
                    child: Text("Personal Info"),
                  ),
                  Tab(
                    child: Text("Supervisor Info"),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: Get.height,
            child: TabBarView(
              children: [one(), two()],
            ),
          )
        ],
      ));
}
