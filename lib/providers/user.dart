import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class User with ChangeNotifier {
  FirebaseAuth _auth;
  auth.User _user;
  String _userId;
  Status _status = Status.Uninitialized;

  String get id => _userId;

  User.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future _onAuthStateChanged(auth.User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

    Future signUp({email: String, password: String}) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    _status = Status.Unauthenticated;
    _user = _auth.currentUser;
    _userId = _user.uid;
    notifyListeners();
    return;
  }

    Future signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _status = Status.Authenticated;
      _user = _auth.currentUser;
      _userId = _user.uid;
      notifyListeners();
      return;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      throw e;
    }
  }
}
