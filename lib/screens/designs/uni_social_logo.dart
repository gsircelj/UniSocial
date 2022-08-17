import 'package:flutter/material.dart';

class UniSocialLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: Alignment.topCenter,
      child: new Container(
        padding: const EdgeInsets.only(top: 50),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(color: Colors.blueAccent),
              constraints: BoxConstraints(minWidth: 80),
              child: Text(
                "Uni",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
            ),
            new Container(
              child: new Text(
                'Social',
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
