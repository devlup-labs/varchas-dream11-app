import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(0xffef6c00)),
            accountName: const Text('UserName'),
            accountEmail: const Text('myself@gmail.com'),
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
            leading: Icon(Icons.account_circle),
            title: Text('Edit Profile'),
          ),
          ListTile(
            leading: Icon(Icons.person_search),
            title: Text('Search Friend'),
          ),
          ListTile(
            leading: Icon(Icons.local_mall),
            title: Text('Wallet'),
          ),
        ],
      ),
    );
  }
}
