import 'package:flutter/material.dart';
import 'package:varchas_dream_11/utilities/constants.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: secondaryColor,
            ),
            margin: EdgeInsets.all(0),
            accountName: const Text(
              'UserName',
              style: kLabelTextStyleBlack,
            ),
            accountEmail: const Text(
              'myself@gmail.com',
              style: kLabelTextStyleBlack,
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image(
                  image: AssetImage('images/profile.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: secondaryColorLight,
            ),
            title: Text(
              'Edit Profile',
              style: kLabelTextStyleWhite,
            ),
            tileColor: primaryColorLight,
          ),
          ListTile(
            leading: Icon(
              Icons.person_search,
              color: secondaryColorLight,
            ),
            title: Text(
              'Search Friend',
              style: kLabelTextStyleWhite,
            ),
            tileColor: primaryColorLight,
          ),
          ListTile(
            leading: Icon(
              Icons.local_mall,
              color: secondaryColorLight,
            ),
            title: Text(
              'Wallet',
              style: kLabelTextStyleWhite,
            ),
            tileColor: primaryColorLight,
          ),
        ],
      ),
    );
  }
}
