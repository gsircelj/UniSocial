import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:unisocial/models/user.dart';
import 'package:unisocial/services/auth_services.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<FirebaseUser> get onAuthStateChanged {
    return _auth.onAuthStateChanged;
  }

  Future<FirebaseUser> currentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    return user != null ? user : null;
  }

  Future<FirebaseUser> signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<FirebaseUser> createUserWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> checkIfEmailExists(String email) async {
    try {
      List<String> result = await _auth.fetchSignInMethodsForEmail(email: email);
      if (result.isNotEmpty) {
        return true;
      }
      else {
        return false;
      }
    }
    catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void dispose() {}
}
