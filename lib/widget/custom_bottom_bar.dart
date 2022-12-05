import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/constant/const_text.dart';
import 'package:punchin/views/home/home_view.dart';
import 'package:punchin/views/profile/profile_view.dart';
import 'package:punchin/views/tracking/tracking_home.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';



class CustomNavigation extends StatefulWidget {
  static final title = 'salomon_bottom_bar';

  @override
  _CustomNavigationState createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {
  var _currentIndex = 0;

  int currentIndex = 0;

  /// list of screens
  final List<Widget> screens = [
    const HomeView(),
    const TrackingHome(),
    const ProfileView(),

  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: screens[_currentIndex],
        bottomNavigationBar: SalomonBottomBar(

          itemShape: RoundedRectangleBorder(
             borderRadius : BorderRadius.circular(12)
          ),// const StadiumBorder(),

          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(

                activeIcon: SvgPicture.asset(
                    "assets/bottom_bar/home.svg",
                    height: 20,
                    width: 20,
                  ),
                  icon: SvgPicture.asset(
                    "assets/bottom_bar/home-2.svg",
                    height: 20,
                    width: 20,
                    color: unselectBottombarColor,
                  ),
              title: Text("Home",style: kBody14kdarkBlue700),
              selectedColor: bottombarColor,


            ),

            /// Likes
            SalomonBottomBarItem(
              activeIcon: SvgPicture.asset(
                "assets/bottom_bar/bottomactiveseach.svg",
                height: 20,
                width: 20,
                color: kdarkBlue,
              ),
              icon: SvgPicture.asset(
                "assets/icons/bottomsearch.svg",
                height: 20,
                width: 20,
                color: unselectBottombarColor,
              ),
              title: Text("Tracking" ,style: kBody14kdarkBlue700),
              selectedColor: bottombarColor,
            ),

            /// Profile
            SalomonBottomBarItem(
              activeIcon: SvgPicture.asset(
                "assets/icons/profile.svg",
                height: 20,
                width: 20,
                color: kdarkBlue,
              ),
              icon: SvgPicture.asset(
                "assets/icons/profile.svg",
                height: 20,
                width: 20,
                color: unselectBottombarColor,
              ),
              title: Text("Agent Profile",style: kBody14kdarkBlue700),
              selectedColor: bottombarColor,
            ),
          ],
        ),
      ),
    );
  }
}
