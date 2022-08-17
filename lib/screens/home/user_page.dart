import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unisocial/screens/home/home.dart';
import 'package:unisocial/services/auth.dart';
import 'package:unisocial/services/auth_services.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final AuthService _auth = FirebaseAuthService();
  final databaseReference = Firestore.instance;
  String _firstName;
  String _lastName;
  DateTime _birthday;
  int _age;

  @override
  Widget build(BuildContext context) {
    firstName();
    age();
    birthdayCalculator(_birthday);
    return Scaffold(
        appBar: _appBar(context),
        body: new Stack(
          children: <Widget>[
            new Container(
              child: new Align(
                alignment: Alignment(0, -0.9),
                child: new Material(
                  elevation: 6.0,
                  shape: CircleBorder(),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: new Container(
                    width: 150,
                    height: 150,
                    child: Image(
                        image: AssetImage('assets/images/default_profile.png')),
                  ),
                ),
              ),
            ),
            new Align(
              alignment: Alignment(0, -0.3),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Text(
                    _firstName + ', ',
                    style: new TextStyle(
                        fontSize: 26, color: Color.fromRGBO(104, 104, 104, 1)),
                  ),
                  new Text(
                    '$_age',
                    style: new TextStyle(
                        fontSize: 21,
                        color: Color.fromRGBO(104, 104, 104, 0.7)),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  void firstName() async {
    FirebaseUser user = await _auth.currentUser();
    DocumentSnapshot _nameRef =
        await databaseReference.collection('users').document(user.uid).get();
    setState(() {
      _firstName = _nameRef['firstName'];
    });
  }

  void age() async {
    FirebaseUser user = await _auth.currentUser();
    DocumentSnapshot _ageRef =
        await databaseReference.collection('users').document(user.uid).get();
    setState(() {
      _birthday = DateTime(_ageRef['age']['year'], _ageRef['age']['month'],
          _ageRef['age']['day']);
    });
  }

  void birthdayCalculator(DateTime birthday) {
    var _date = new DateTime.now();
    DateTime _birthday = (birthday);

    int age = _date.year - _birthday.year;
    if (_date.month < _birthday.month)
      age--;
    else if (_date.month == _birthday.month) {
      if (_date.day <= _birthday.day) {
        age--;
      }
    }
    setState(() {
      _age = age;
    });
  }

  Widget _appBar(BuildContext context) => new AppBar(
        leading: new Container(
          margin: EdgeInsets.all(6),
          child: InkWell(
            child: new Icon(
              Icons.home,
              size: 35,
            ),
            onTap: () async {
              /* final user = await _auth.getCurrentUser();
              DocumentSnapshot _nameRef = await databaseReference
                  .collection('users')
                  .document(user.uid)
                  .get(); */

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ),
        centerTitle: true,
        title: new Text(
          'UniSocial',
          style: new TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          new IconButton(
            splashColor: Colors.transparent,
            icon: new Icon(
              Icons.settings,
              size: 30,
            ),
            onPressed: () async {
              final user = await _auth.currentUser();
              print(user.uid);
              _auth.signOut();
            },
          )
        ],
      );
}
