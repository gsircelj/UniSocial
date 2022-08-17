import 'package:flutter/material.dart';

class LoginPageDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new Divider(
            color: Colors.black26,
            indent: 120,
            endIndent: 5,
          ),
        ),
        new Text('or'),
        new Expanded(
          child: new Divider(
            color: Colors.black26,
            endIndent: 120,
            indent: 5,
          ),
        ),
      ],
    );
  }
}
