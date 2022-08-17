import 'package:flutter/material.dart';
import 'package:unisocial/services/auth.dart';
import 'package:unisocial/screens/designs/login_page_divider.dart';
import 'package:unisocial/screens/designs/uni_social_curve.dart';
import 'package:unisocial/screens/designs/uni_social_logo.dart';
import 'register.dart';
import 'package:unisocial/services/auth_services.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _error = "";

  final AuthService _auth = FirebaseAuthService();

  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: new Stack(
        children: <Widget>[
          new Container(
            constraints: new BoxConstraints.expand(),
            child: CustomPaint(
              painter: CurvePainter(),
            ),
          ),
          new Container(
            padding: EdgeInsets.all(39),
            child: new Column(
              children: <Widget>[
                new UniSocialLogo(),
                new Container(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
                  child: new Text(
                    'WELCOME',
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontSize: 25.0),
                  ),
                ),
                new Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      new TextFormField(
                        decoration: new InputDecoration(labelText: 'Email'),
                        validator: (value) =>
                            value.isEmpty ? 'Email can\'t be empty' : null,
                        onChanged: (value) => _email = value,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(labelText: 'Password'),
                        validator: (value) =>
                            value.length < 6 ? 'Password is too short' : null,
                        onChanged: (value) => _password = value,
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                new Container(
                  child: new Text(
                    _error,
                    style: new TextStyle(color: Colors.red),
                  ),
                ),
                new Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: new RaisedButton(
                    color: Colors.blueAccent,
                    child: new Text(
                      'SIGN IN',
                      style: new TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            _email, _password);
                        if (result == null) {
                          print('No such user');
                          setState(() => _error =
                              "Incorrect user or password"); // error, ki ga vrže Firebase.
                        } // UPORABI GA, ko Firebase ni mogel vpisati uporabnika
                      } else {
                        print('No such user');
                      }
                    },
                  ),
                ),
                new LoginPageDivider(),
                new FlatButton(
                  child: new Text(
                    'Create an account',
                    style: new TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
