import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';


abstract class AuthService {
  Future<FirebaseUser> currentUser();
  Future<FirebaseUser> signInWithEmailAndPassword(String email, String password);
  Future<FirebaseUser> createUserWithEmailAndPassword(String email, String password);
  Future<bool> checkIfEmailExists(String email);
  Future<void> signOut();
  Stream<FirebaseUser> get onAuthStateChanged;
  void dispose();
}