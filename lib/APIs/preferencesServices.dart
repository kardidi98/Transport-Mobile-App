
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class PreferencesService {


  void addPreference(var preferences) {
    FirebaseFirestore.instance
        .collection('preferences')
        .add(preferences)
    .then((value) => print("Préference ajoutée"))
        .catchError((error) => print("Failed to add user: $error"));

  }

}
