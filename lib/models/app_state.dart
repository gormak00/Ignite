import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ignite/views/faq.dart';
import 'package:ignite/views/fireman_screen.dart';
import 'package:ignite/views/loading_screen.dart';

class AppState extends ChangeNotifier {
  AuthResult result;
  FirebaseUser currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Future<void> authMailPassword(String mail, String pass) async {
    try {
      result =
          await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      this.currentUser = result.user;
    } catch (e) {
      throw e;
    }
  }

  Future<void> newMailPassword(String mail, String pass) async {
    try {
      result = await _auth.createUserWithEmailAndPassword(
          email: mail, password: pass);
    } catch (e) {
      throw e;
    }
    _db.collection('users').add({
      'email': mail,
      'isFireman': false,
    });
  }

  Future<void> recoverPassword(String currentEmail) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: currentEmail,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<bool> isCurrentUserFireman() async {
    if (currentUser != null) {
      QuerySnapshot querySnap = await _db
          .collection('users')
          .where('email', isEqualTo: "${currentUser.email}")
          .getDocuments();
      return querySnap.documents[0]["isFireman"];
    } else {
      return false;
    }
  }

  ThemeData mainTheme() {
    return ThemeData(
      primaryColor: Colors.red[600],
      accentColor: Colors.grey[500],
      bottomAppBarColor: Colors.red[600],
      buttonColor: Colors.white,
      fontFamily: 'Nunito',
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      primaryColor: Colors.grey[900],
      accentColor: Colors.grey[700],
      bottomAppBarColor: Colors.grey[900],
      buttonColor: Colors.white,
      fontFamily: 'Nunito',
    );
  }
}
