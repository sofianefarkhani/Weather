import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/model/user.dart';
import 'package:weather/utils/utils.dart';

@lazySingleton
class AuthenticationService with ReactiveServiceMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  WeatherUser? _user;

  // GETTERS

  WeatherUser? get weatherUser => _user;

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  String getCurrentUID() {
    String uid = '';
    if (_auth.currentUser != null) {
      uid = _auth.currentUser!.uid;
    }
    return uid;
  }

  User? get currentUser => _auth.currentUser;

  Future<WeatherUser> getWeatherUserFromFirestore() async {
    final userData =
        await _firestore.collection('users').doc(getCurrentUID()).get();
    final weatherUser = WeatherUser.fromFirestore(userData.data()!);
    _user = weatherUser;
    return weatherUser;
  }

  // METHODS

  Future signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (exception) {
      switch (exception.code) {
        case 'user-not-found':
          Utils.displayMessage(context, "Utilisateur non trouvé");
          break;
        case 'wrong-password':
          Utils.displayMessage(context, "Mot de passe incorrect");
          break;
        default:
          Utils.displayMessage(context, exception.toString());
          break;
      }
      return null;
    }
  }

  Future logout() async {
    await _auth.signOut();
  }

  Future registerWithEmailAndPassword(
      String email, String password, String name, BuildContext context) async {
    try {
      final userCreds = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (userCreds.user != null) {
        await _firestore
            .collection('users')
            .doc(userCreds.user!.uid)
            .set({'name': name, 'ville': []});
      }
    } on FirebaseAuthException catch (exception) {
      switch (exception.code) {
        case 'email-already-in-use':
          Utils.displayMessage(context, "Email déjà utilisé");
          break;
        case 'weak-password':
          Utils.displayMessage(context, "Mot de passe trop faible");
          break;
        default:
          Utils.displayMessage(context, exception.toString());
          break;
      }
      return null;
    }
  }

  Future updatePassword(String newPassword, BuildContext context) async {
    try {
      await _auth.currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (exception) {
      switch (exception.code) {
        case 'requires-recent-login':
          Utils.displayMessage(context,
              "L'utilisateur doit se reconnecter afin de pouvoir réaliser cette opération.");
          break;
        case 'weak-password':
          Utils.displayMessage(context, "Mot de passe trop faible");
          break;
        default:
      }
    }
  }

  Future deleteUser(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (exception) {
      if (exception.code == 'requires-recent-login') {
        Utils.displayMessage(context,
            "L'utilisateur doit se reconnecter afin de pouvoir réaliser cette opération.");
      }
    }
  }
}
