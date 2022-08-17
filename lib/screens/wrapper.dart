import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unisocial/screens/authenticate/sign_in.dart';
import 'package:unisocial/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unisocial/services/auth_services.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth =
        Provider.of<AuthService>(context); //, listen: false
    return StreamBuilder<FirebaseUser>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final FirebaseUser user = snapshot.data;
          return user == null ? SignIn() : Home();
        } else {
          return Scaffold(
            body: Center(
              child: new CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

/* class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of<AuthService>(context);
    return StreamBuilder<FirebaseUser>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final FirebaseUser user = snapshot.data;
          return user == null ? SignIn() : Home();
        } else {
          return Scaffold(body: Center(child: new CircularProgressIndicator()));
        }
      },
    );
  }
} */
