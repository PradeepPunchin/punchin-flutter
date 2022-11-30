import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:punchin/constant/const_color.dart';
import 'package:punchin/views/details.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../views/profile_view.dart';

// class BottomNavigation extends StatefulWidget {
//   const BottomNavigation({super.key});
//   @override
//   _BottomNavigationState createState() => _BottomNavigationState();
// }
//
// class _BottomNavigationState extends State<BottomNavigation> {
//   int currentIndex = 0;
//
//   /// list of screens
//   final List<Widget> screens = [
//     const Details(),
//     const Details(),
//     const Details(),
//
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (currentIndex == 0) {
//           return true;
//         } else {
//           setState(() {
//             currentIndex = 0;
//           });
//           return false;
//         }
//       },
//       child: Scaffold(
//         body: screens[currentIndex],
//         bottomNavigationBar: SingleChildScrollView(
//           child: DecoratedBox(
//             decoration: const BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   offset: Offset(5, 6),
//                   blurRadius: 9,
//                   color: Colors.blueAccent,
//                 ),
//               ],
//               color: Colors.white,
//             ),
//             child: BottomNavigationBar(
//               unselectedFontSize: 10,
//               selectedFontSize: 10,
//               unselectedLabelStyle: TextStyle(color: Colors.grey),
//               unselectedItemColor: Colors.grey,
//               showSelectedLabels: true,
//               showUnselectedLabels: false,
//               iconSize: 20,
//               type: BottomNavigationBarType.shifting,
//               selectedItemColor: kMediumBlack,
//               currentIndex: currentIndex,
//               elevation: 4,
//                 landscapeLayout:BottomNavigationBarLandscapeLayout.linear,
//               onTap: (index) {
//                 setState(() {
//                   currentIndex = index;
//                 });
//               },
//               items: [
//                 BottomNavigationBarItem(
//                   activeIcon: SvgPicture.asset(
//                     "assets/bottom_bar/home.svg",
//                     height: 20,
//                     width: 20,
//                     color: kMediumBlack,
//                   ),
//                   icon: SvgPicture.asset(
//                     "assets/bottom_bar/home.svg",
//                     height: 20,
//                     width: 20,
//                   ),
//                   label: "Home",
//                 ),
//                 BottomNavigationBarItem(
//                   activeIcon: SvgPicture.asset(
//                     "assets/bottom_bar/home.svg",
//                     color: kMediumBlack,
//                     height: 20,
//                     width: 20,
//                   ),
//                   icon: SvgPicture.asset(
//                     "assets/bottom_bar/home.svg",
//                     height: 20,
//                     width: 20,
//                   ),
//                   label: "Modules",
//                 ),
//                 BottomNavigationBarItem(
//                   activeIcon: SvgPicture.asset(
//                     "assets/bottom_bar/home.svg",
//                     height: 20,
//                     width: 20,
//                     color: kMediumBlack,
//                   ),
//                   icon: SvgPicture.asset(
//                     "assets/bottom_bar/home.svg",
//                     height: 20,
//                     width: 20,
//                   ),
//                   label: "Goals",
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
    const Details(),
    const Details(),
    ProfileView(),
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
          itemShape: const StadiumBorder(),
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
                "assets/bottom_bar/home.svg",
                height: 20,
                width: 20,
                color: kMediumBlack,
              ),
              title: Text("Home"),
              selectedColor: Colors.purple,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: Icon(Icons.mark_unread_chat_alt_rounded),
              title: Text("Tracking"),
              selectedColor: Colors.pink,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
