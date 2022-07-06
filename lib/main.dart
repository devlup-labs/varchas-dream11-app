import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(const MainScreen());
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
  }
}

/*
Constants
@primaryColor for AppBar, bottomNavBor colors
 */
const primaryColor = Colors.black;

class _MainScreenState extends State<MainScreen> {
  //Dummy text to test TabChanged
  String bodyText = 'Dashboard';

  void updateScreen(String text) {
    setState(() {
      bodyText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // For removing debug banner
      debugShowCheckedModeBanner: false,

      home: Scaffold(
          //Top App Bar
          appBar: AppBar(
            backgroundColor: primaryColor,
            // Profile Icon
            leading: Icon(FontAwesomeIcons.solidUser),
            centerTitle: true,
            title: Text("Varchas"),
          ),

          // Bottom Navigation Bar
          bottomNavigationBar: Container(
            color: primaryColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              child: GNav(
                backgroundColor: primaryColor,
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.grey.shade800,
                padding: EdgeInsets.all(16.0),
                gap: 12.0,

                // Functionality when a tab is selected
                onTabChange: (index) {
                  if (index == 0) {
                    updateScreen("Dashboard");
                  } else if (index == 1) {
                    updateScreen("Live Matches");
                  } else if (index == 2) {
                    updateScreen("Leaderboard");
                  } else if (index == 3) {
                    updateScreen("Schedule");
                  }
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
          body: Center(
            child: Text(bodyText),
          )),
    );
  }
}
