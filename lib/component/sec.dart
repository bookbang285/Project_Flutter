import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class sec extends StatefulWidget {
  sec({Key key}) : super(key: key);

  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<sec> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: textt,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: new BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/backc.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hello, Second Page',
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
          ),
        ));
  }

  Widget textt = Container(
    child: StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snap) {
        final user = snap.data;
        return Text(
          '${user.email}',
          style: TextStyle(color: Colors.white),
        );
      },
    ),
  );

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
