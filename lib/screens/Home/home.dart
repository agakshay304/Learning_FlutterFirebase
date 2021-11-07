import 'package:brew_crew/Models/brew.dart';
import 'package:brew_crew/services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'settings_form.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    void _showsettingspane() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SettingsForm();
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[450],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () {
                _auth.signout();
              },
              icon: Icon(Icons.person),
              label: Text('Logout'),
            ),
            FlatButton.icon(
              onPressed: () => _showsettingspane(),
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BrewList()),
      ),
    );
  }
}
