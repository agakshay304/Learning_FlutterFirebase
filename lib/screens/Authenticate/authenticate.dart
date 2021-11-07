import 'package:brew_crew/screens/Authenticate/register.dart';
import 'package:brew_crew/screens/Authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  Widget build(BuildContext context) {
    if (showSignIn) {
      return Sign_In(toggleView: toggleView);
    } else
      return Register(toggleView: toggleView);
  }
}
