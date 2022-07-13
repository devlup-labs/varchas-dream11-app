import 'package:flutter/material.dart';
import 'package:varchas_dream_11/main_screen.dart';
import '../utilities/constants.dart';
import 'google_sign_in_api.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                color: secondaryColorLighter,
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: const EdgeInsets.only(top: 75.0, left: 25.0, right: 25.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Varchas",
                    style: kTitleTextStyleWhite,
                  ),
                  Text(
                    "Vigour  I  Valour  I  Victory",
                    style: kLabelTextStyleWhite,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Image(
                    image: AssetImage("images/poster_login.png"),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Make a team and win exciting rewards",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontFamily: "Pontiac Regular",
                    fontWeight: FontWeight.w200),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 20.0,
              width: double.infinity,
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.only(
                  left: 35.0, right: 35.0, bottom: 30.0, top: 10.0),
              child: SignInButton(
                Buttons.google,
                text: "Sign up with Google",
                onPressed: signIn,
              ),
            )
          ),
        ],
      ),
    );
  }

  Future signIn() async {
    final user = await GoogleSignInApi.login();

    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Sign in Failed")));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()));
    }
  }
}
