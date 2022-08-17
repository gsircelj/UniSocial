import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unisocial/screens/home/user_page.dart';
import 'package:unisocial/services/auth.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unisocial/services/auth_services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future getUsers() async {
    FirebaseUser user = await _auth.currentUser();

    QuerySnapshot qSnapshotFill =
        await Firestore.instance.collection('users').getDocuments();
    List<DocumentSnapshot> qSnapshot = [];

    for (int i = 0; i < qSnapshotFill.documents.length; i++) { // najde in zbriše dokument trenutnega uporabnika
      if (qSnapshotFill.documents[i].documentID != user.uid) {
        qSnapshot.add(qSnapshotFill.documents[i]);
      }
    }
    return qSnapshot;
  }

  void matchAlgorithm() async {
    List<String> categoriesList = [];
    FirebaseUser user = await _auth.currentUser();
    DocumentSnapshot currentUser =
        await Firestore.instance.collection('users').document(user.uid).get();

    for (int i = 0; i < 5; i++) {
      print(currentUser['categories'][i]);
    }
  }

  final AuthService _auth = FirebaseAuthService();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _appBar(context),
      body: _slidingPanelAndMap(),
    );
  }

  Widget _appBar(BuildContext context) {
    return new AppBar(
      leading: new Container(
        margin: EdgeInsets.all(6),
        child: Material(
          elevation: 6.0,
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: Ink.image(
            image: AssetImage('assets/images/default_profile.png'),
            fit: BoxFit.cover,
            width: 10,
            height: 10,
            child: InkWell(
              onTap: () {
                //matchAlgorithm();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => UserPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ),
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
          icon: new Icon(Icons.settings, size: 30),
          onPressed: () async {
            final user = await _auth.currentUser();
            _auth.signOut();
            //_auth.createUserWithEmailAndPassword('22', '22');
          },
        )
      ],
    );
  }

  Widget _slidingPanelAndMap() {
    return new SlidingUpPanel(
      minHeight: 80,
      renderPanelSheet: false,
      parallaxEnabled: true,
      parallaxOffset: 0.3,
      panel: _floatingPanel(),
      collapsed: _floatingCollapsed(),
      body: new FittedBox(
          child: new Image.asset('assets/images/mapOfLjubljana.png'),
          fit: BoxFit.fill),
    );
  }

  Widget _floatingPanel() {
    return Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24)),
          boxShadow: [
            BoxShadow(blurRadius: 20.0, color: Colors.grey),
          ],
        ),
        margin: const EdgeInsets.all(24),
        child: new Center(
          child: new Container(
            margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: new Column(
              children: <Widget>[
                new Expanded(
                  child: new Container(
                    child: new Icon(
                      Icons.more_horiz,
                    ),
                  ),
                  flex: 1,
                ),
                new Expanded(
                    child: FutureBuilder(
                        future: getUsers(),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: new CircularProgressIndicator(),
                            );
                          } else {
                            return ListView.separated(
                                itemCount: snapshot.data.length - 1,
                                separatorBuilder: (context, index) => Divider(color: Colors.black26,),
                                itemBuilder: (BuildContext context, index) {
                                  return ListTile(
                                    leading: new CircleAvatar(
                                      radius: 22,
                                      backgroundImage: AssetImage(
                                          'assets/images/default_profile.png'),
                                    ),
                                    title: new Row(
                                      children: <Widget>[
                                        new Text(snapshot
                                                .data[index].data['firstName'] +
                                            ' ' +
                                            snapshot
                                                .data[index].data['lastName']),
                                        new Text(' '),
                                        new Text('age')
                                      ],
                                    ),
                                    subtitle: new Text('... km away'),
                                    trailing: new Text('3/5')
                                  );
                                });
                          }
                        }),
                    flex: 7),
              ],
            ),
          ),
        ));
  }

  Widget _floatingCollapsed() {
    return Container(
        decoration: new BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(24)),
        ),
        margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: new Column(
          children: <Widget>[
            new Icon(Icons.arrow_drop_up),
            new Container(
              padding: EdgeInsets.only(bottom: 0),
              child: new Text(
                'Matches',
                style: new TextStyle(color: Colors.white, fontSize: 19),
              ),
            ),
          ],
        ));
  }
}
