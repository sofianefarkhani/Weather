import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/model/user.dart';

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
          displaySnackbarError(context, "Utilisateur non trouvé");
          break;
        case 'wrong-password':
          displaySnackbarError(context, "Mot de passe incorrect");
          break;
        default:
          displaySnackbarError(context, exception.toString());
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
        await _firestore.collection('users').doc(userCreds.user!.uid).set({
          'name': name,
        });
      }
    } on FirebaseAuthException catch (exception) {
      switch (exception.code) {
        case 'email-already-in-use':
          displaySnackbarError(context, "Email déjà utilisé");
          break;
        case 'weak-password':
          displaySnackbarError(context, "Mot de passe trop faible");
          break;
        default:
          displaySnackbarError(context, exception.toString());
      }
      return null;
    }
  }

  displaySnackbarError(BuildContext context, String displayedError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text(displayedError, style: const TextStyle(color: Colors.red))),
    );
  }
}
