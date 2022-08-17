import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unisocial/services/auth.dart';
import 'package:unisocial/services/auth_services.dart';
import 'package:unisocial/services/categories_services.dart';
import 'package:unisocial/models/user.dart';
import 'package:unisocial/screens/home/home.dart';

class Categories extends StatefulWidget {
  final User user;
  Categories({this.user});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final databaseReference = Firestore.instance;
  int counter = 0;
  List<String> categoriesList = [];
  final AuthService _auth = FirebaseAuthService();
  final CategoriesServices _categories = CategoriesServices();

  var boolCounter = [false, false, false, false, false, false, false, false];
  var pressState = [false, false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Expanded(
            flex: 2,
            child: new Container(
              child: new Text(
                'Choose Categories',
                style: new TextStyle(
                  fontSize: 30,
                ),
              ),
              alignment: new Alignment(0, 1),
            ),
          ),
          new Expanded(
            flex: 8,
            child: new Container(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      categoryButton('Art', 0),
                      categoryButton('Movies', 1),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      categoryButton('Sports', 2),
                      categoryButton('Animals', 3),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      categoryButton('Music', 4),
                      categoryButton('Business', 5),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      categoryButton('Technology', 6),
                      categoryButton('Travel', 7),
                    ],
                  ),
                ],
              ),
              alignment: new Alignment(1, 0.5),
            ),
          )
        ],
      ),
    );
  }

  Widget categoryButton(String category, int buttonNumber) {
    return new Container(
      child: new RaisedButton(
        color: pressState[buttonNumber] ? Colors.grey : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(19),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        child: new Text(category),
        onPressed: () {
          setState(() => pressState[buttonNumber] = !pressState[buttonNumber]);
          boolCounter[buttonNumber] = !boolCounter[buttonNumber];
          counterAddSubstract(boolCounter[buttonNumber]);
          addToList(category);
//          addCategoryToFirestore(category);
//          print(counter);
          checkCounter();
        },
      ),
    );
  }

  void addToList(String category) {
    if (categoriesList.contains(category))
      categoriesList.remove(category);
    else
      categoriesList.add(category);

    print(categoriesList);
  }

  void counterAddSubstract(bool boolCounter) {
    if (boolCounter)
      counter++;
    else
      counter--;
  }

  void checkCounter() async{
    if (counter == 5) {
      dynamic result = await _auth.createUserWithEmailAndPassword(widget.user.email, widget.user.password);
      _categories.createUserRecord(widget.user.firstName, widget.user.lastName,
          widget.user.day, widget.user.month, widget.user.year, categoriesList, result);
      /* Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        (Route<dynamic> route) => false,
      ); */
    }
  }
}
