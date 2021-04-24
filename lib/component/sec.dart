import 'dart:async';
import 'dart:math';
import 'package:authentication_login/component/signin.dart';
import 'package:authentication_login/realtimecollect/RealTimeCollection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

String name1;

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
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Signin()),
            );
            onClickSignOut();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: textt,
        flexibleSpace: Image(
          image: AssetImage('assets/images/backc.png'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        child: bg(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        focusColor: Colors.white,
        onPressed: () {
          createDataLog(name1);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget textt = Container(
    child: StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snap) {
        final user = snap.data;
        name1 = '${user.email}';
        return Text(
          '${user.email}',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'FiraCode',
          ),
        );
      },
    ),
  );

  Container bg() {
    return Container(
      decoration: new BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/backc.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        ),
      ),
      child: RealtimeCollection(),
    );
  }

  void createDataLog(String name) {
    String datenow = DateTime.now().toString().substring(0, 19);

    final CollectionReference users =
        FirebaseFirestore.instance.collection('Log');
    users
        .doc(datenow)
        .set({'name': '$name', 'date': '$datenow'})
        .then((value) => print('success'))
        .catchError((e) => print(e));
  }

  void onClickSignOut() async {
    await FirebaseAuth.instance.signOut();
    EasyLoading.showSuccess("Sign-Out Complete");
  }
}
