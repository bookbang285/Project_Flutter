import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class sec extends StatefulWidget {
  sec({Key key}) : super(key: key);

  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<sec> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  StreamSubscription<QueryDocumentSnapshot> subscription;
  List<DocumentSnapshot> snapshots;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textt,
      ),
      extendBodyBehindAppBar: true,
      body: bg(),
    );
  }

  //List log;
  Container bg() {
    /*
    FirebaseFirestore.instance
        .collection("Log")
        .where("name")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        log = result.data().values.toList();
        print("date $log");
      });
    });
    */
    return Container(
      decoration: new BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/backc.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        ),
      ),
      child: Expanded(
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: 4,
          itemBuilder: (context, index) => Container(
            padding: EdgeInsets.all(5.0),
            child: Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white.withOpacity(0.7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'asdasd',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontFamily: 'FiraCode'),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'asdasd',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                        fontFamily: 'FiraCode'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

/*
  Container buildListview() {
    return new Container(
      color: const Color(0xFF00FF00),
      child: Expanded(
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'asda',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'asdasd',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
*/

  Widget textt = Container(
    child: StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snap) {
        final user = snap.data;

        return Text(
          '${user.email}',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'FiraCode',
          ),
        );
      },
    ),
  );

  int countLog = 1;

  void createDataLog(String name) {
    var now = DateTime.now();
    final CollectionReference users =
        FirebaseFirestore.instance.collection('Log');
    users
        .doc(countLog.toString())
        .set({'name': '$name', 'date': '$now'})
        .then((value) => print('success'))
        .catchError((e) => print(e));
    countLog++;
  }

  void onClickSignOut() async {
    await FirebaseAuth.instance.signOut();
    EasyLoading.showSuccess("Sign-Out Complete");
  }

  Container buildButtonSignOut() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Sign Out",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () {
            onClickSignOut();
          },
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.blue),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }
}
