import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/Auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/Users.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value: AuthServices().user,
      child: MaterialApp(
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
