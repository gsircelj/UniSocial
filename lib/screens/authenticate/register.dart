import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unisocial/screens/designs/login_page_divider.dart';
import 'package:unisocial/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unisocial/services/auth_services.dart';
import 'package:unisocial/models/user.dart';

import 'categories.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPage();
}

enum FormType { register, login }

class _RegisterPage extends State<RegisterPage> {
  final _formKey = new GlobalKey<FormState>();
  final databaseReference = Firestore.instance;
  final AuthService _auth = FirebaseAuthService();

  User user = User();
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: new Container(
              margin: const EdgeInsets.only(top: 30, bottom: 30),
              child: new Text(
                'CREATE NEW ACCOUNT',
                style: new TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
              ),
            ),
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: new Form(
              key: _formKey,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Flexible(
                        child: new TextFormField(
                          key: Key('firstName'),
                          decoration: new InputDecoration(
                            hintText: 'First Name',
                          ),
                          onChanged: (String value) => user.firstName = value,
                          validator: (value) =>
                              value.isEmpty ? "${user.firstName}" : null,
                        ),
                      ),
                      new Flexible(
                        child: new TextFormField(
                          key: Key('lastName'),
                          decoration: new InputDecoration(
                            hintText: 'Last Name',
                          ),
                          onChanged: (String value) => user.lastName = value,
                          validator: (value) =>
                              value.isEmpty ? "Field can't be empty" : null,
                        ),
                      )
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Flexible(
                        child: new TextFormField(
                            key: Key('day'),
                            decoration: new InputDecoration(
                              hintText: 'Day',
                            ),
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (value) => user.day = int.parse(value),
                        
                            validator: (value) =>
                                value.isEmpty ? "Field can't be empty" : null),
                      ),
                      new Flexible(
                        child: new TextFormField(
                            key: Key('month'),
                            decoration: new InputDecoration(
                              hintText: 'Month',
                            ),
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (value) => user.month = int.tryParse(value),
                            validator: (value) =>
                                value.isEmpty ? "Field can't be empty" : null),
                      ),
                      new Flexible(
                        child: new TextFormField(
                            key: Key('year'),
                            decoration: new InputDecoration(
                              hintText: 'Year',
                            ),
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (value) => user.year = int.tryParse(value),
                            validator: (value) =>
                                value.isEmpty ? "Field can't be empty" : null),
                      ),
                    ],
                  ),
                  new TextFormField(
                      key: Key('email'),
                      decoration: new InputDecoration(
                        hintText: 'Email',
                      ),
                      onChanged: (String value) => user.email = value,
                      validator: (value) =>
                          value.isEmpty ? "Field can't be empty" : null),
                  new TextFormField(
                      key: Key('password'),
                      decoration: new InputDecoration(
                        hintText: 'Password',
                      ),
                      onChanged: (String value) => user.password = value,
                      validator: (value) =>
                          value.length < 6 ? 'Password is too short' : null,
                      obscureText: true),
                  new Container(
                    padding: const EdgeInsets.only(top: 15, bottom: 10),
                    child: new RaisedButton(
                      color: Colors.blueAccent,
                      child: new Text(
                        'REGISTER',
                        style:
                            new TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          bool result = await _auth.checkIfEmailExists(_email);
                          if (result == true) {
                            // TODO: dodaj error message, da email že obstaja
                            print(
                                'error: email already exists');
                            /* setState(() => _error =
                                "Please supply a valid email"); // error, ki ga vrže Firebase. */
                          } else {
                            // TODO: shrani vse informacije in jih posreduj na stran Categories
                            // email ne obstaja ali pa je malformed
                            // TODO: dodaj validacijo za pravilen vnos emaila
                            print(
                                'email ne obstaja, ustvari dokument s kategorijami');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Categories(
                                  user: user
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: new LoginPageDivider(),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: new Text(
                      'Register with',
                      style: new TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget ageFormField(int day, int month, int year) {
    return new Row(
      children: <Widget>[
        new TextFormField(
            key: Key('day'),
            decoration: new InputDecoration(
              hintText: 'Day',
            ),
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            keyboardType: TextInputType.number,
            onChanged: (value) => day = int.tryParse(value),
            validator: (value) =>
                value.isEmpty ? "Field can't be empty" : null),
        new TextFormField(
            key: Key('month'),
            decoration: new InputDecoration(
              hintText: 'Month',
            ),
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            keyboardType: TextInputType.number,
            onChanged: (value) => month = int.tryParse(value),
            validator: (value) =>
                value.isEmpty ? "Field can't be empty" : null),
        new TextFormField(
            key: Key('year'),
            decoration: new InputDecoration(
              hintText: 'Year',
            ),
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            keyboardType: TextInputType.number,
            onChanged: (value) => year = int.tryParse(value),
            validator: (value) =>
                value.isEmpty ? "Field can't be empty" : null),
      ],
    );
  }
}
