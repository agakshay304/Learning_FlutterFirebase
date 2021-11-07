import 'package:brew_crew/services/Auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Sign_In extends StatefulWidget {
  final Function toggleView;
  Sign_In({this.toggleView});
  @override
  _Sign_InState createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  final AuthServices _auth = AuthServices();
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
                backgroundColor: Colors.brown[400],
                title: Text('Sign In to Brew Crew'),
                elevation: 0.0,
                actions: <Widget>[
                  FlatButton.icon(
                      onPressed: () {
                        widget.toggleView();
                      },
                      icon: Icon(Icons.person),
                      label: Text('Register'))
                ]),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: inputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) =>
                          val.isEmpty ? 'Please Enter valid Email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          inputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Please enter 6+ char long password'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Wrong Credentials';
                                loading = false;
                              });
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
