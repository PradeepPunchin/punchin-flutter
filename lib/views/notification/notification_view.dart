import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';

class NotificationView extends StatelessWidget {
  NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 5.0,
        centerTitle: false,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CachedNetworkImage(
            imageUrl:
                "https://cvbay.com/wp-content/uploads/2017/03/dummy-image.jpg",
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 15.0.h,
                width: 15.0.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: imageProvider)),
              );
            },
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Anil kumar",
              style: CustomFonts.kBlack15Black.copyWith(fontSize: 14.0),
            ),
            Text(
              "ID:983821",
              style: CustomFonts.kBlack15Black
                  .copyWith(fontSize: 12.0, color: kTextFieldGrey),
            ),
          ],
        ),
        actions: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white10,
            radius: 48.0,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: klightBlue,
                  border: Border.all(width: 2, color: Colors.black12),
                ),
                child: const Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                  ),
                )),
          ),
        ],
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: ListView.builder(
            itemCount: 16,
            itemBuilder: (context, int index) {
              return Container(
                color: index < 5 ? kBack : Colors.white,
                margin: EdgeInsets.only(top: 1.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                "https://cvbay.com/wp-content/uploads/2017/03/dummy-image.jpg",
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                height: 22.0.h,
                                width: 22.0.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image:
                                        DecorationImage(image: imageProvider)),
                              );
                            },
                          ),
                          index < 5
                              ? Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    height: 8.0,
                                    width: 8.0,
                                    decoration: const BoxDecoration(
                                        color: klightBlue,
                                        shape: BoxShape.circle),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                      SizedBox(
                        width: 5.0.h,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${index + 3} Claims submitted to Insurer. You can track claims settlement process.",
                            style: CustomFonts.kBlack15Black.copyWith(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5.0.h,
                          ),
                          Text("04/07/2022 at 9:42 AM",
                              style: CustomFonts.kBlack15Black.copyWith(
                                  color: kTextFieldGrey, fontSize: 13.0)),
                        ],
                      ))
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
