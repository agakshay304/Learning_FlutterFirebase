import 'package:brew_crew/Models/Users.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users _userfromfirebaseuser(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  Stream<Users> get user {
    return _auth.authStateChanges().map(_userfromfirebaseuser);
  }

  Future signinAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userfromfirebaseuser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String Email, String Password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: Email, password: Password);
      User user = result.user;
      return _userfromfirebaseuser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String Email, String Password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: Email, password: Password);
      User user = result.user;
      DatabaseService(uid: user.uid).updateUserDate('Akshay Gupta', '0', 800);
      return _userfromfirebaseuser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signout() async {
    try {
      return (_auth.signOut());
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
