import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/Models/brew.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/Models/Users.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference brewcollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserDate(String name, String sugars, int strength) async {
    return await brewcollection.doc(uid).set({
      'name': name,
      'sugars': sugars,
      'strength': strength,
    });
  }

  List<Brew> _brewlistfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      return Brew(
        name: document.get('name') ?? '',
        sugars: document.get('sugars') ?? '0',
        strength: document.get('strength') ?? 0,
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name'),
      sugars: snapshot.get('sugars'),
      strength: snapshot.get('strength'),
    );
  }

  Stream<List<Brew>> get brews {
    return brewcollection.snapshots().map(_brewlistfromsnapshot);
  }

  Stream<UserData> get userData {
    return brewcollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
