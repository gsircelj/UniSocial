import 'package:flutter/material.dart';
import 'package:unisocial/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:unisocial/services/auth.dart';
import 'services/auth_services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (_) => FirebaseAuthService(),
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

/* void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<FirebaseAuthService>( 
      builder: (_) => FirebaseAuthService,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
} */

/* class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureProvider<FirebaseUser>.value( //STREAMPROVIDER
      value: FirebaseAuthService().currentUser() ,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
} */