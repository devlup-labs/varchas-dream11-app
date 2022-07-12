import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:varchas_dream_11/pages/dashboard.dart';
import 'package:varchas_dream_11/pages/leaderboard.dart';
import 'package:varchas_dream_11/pages/live_matches.dart';
import 'package:varchas_dream_11/pages/schedule.dart';
import '../utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/navbar.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final pages = [
    Dashboard(),
    LiveMatches(),
    Leaderboard(),
    Schedule(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: const NavBar(),
      appBar: AppBar(
        actions: [
          Builder(builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
              icon: Icon(
                Icons.person,
              ),
            );
          })
        ],
        title: Text(
          'Varchas',
          style: TextStyle(fontFamily: "OpenSans Bold"),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),

      //Top App Bar
      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   // Profile Icon
      //   actions: [
      //     Icon(FontAwesomeIcons.solidUser),
      //     SizedBox(
      //       width: 8.0,
      //     ),
      //   ],
      //   centerTitle: true,
      //   title: Text(
      //     "Varchas",
      //     style: TextStyle(fontFamily: "OpenSans Bold"),
      //   ),
      // ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        color: secondaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
          child: GNav(
            backgroundColor: secondaryColor,
            color: Colors.black,
            activeColor: Colors.black,
            tabBackgroundColor: secondaryColorLight,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            gap: 12.0,

            // Functionality when a tab is selected
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            tabs: const [
              GButton(
                icon: FontAwesomeIcons.solidRectangleList,
                text: "Dashboard",
              ),
              GButton(
                icon: FontAwesomeIcons.trophy,
                text: "Live Matches",
              ),
              GButton(
                icon: FontAwesomeIcons.medal,
                text: "Leaderboard",
              ),
              GButton(
                icon: FontAwesomeIcons.calendarDay,
                text: "Schedule",
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
    );
  }
}
