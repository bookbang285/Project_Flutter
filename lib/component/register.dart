import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../HexColor.dart';
import 'signin.dart';

class register extends StatefulWidget {
  register({Key key}) : super(key: key);

  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<register> {
  String email;
  String password;
  String password2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          'Register',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'FiraCode',
          ),
        ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  textfield1('email', "email", false),
                  Text(""),
                  textfield1('password', "password", true),
                  Text(""),
                  textfield1('comfirm password', "password2", true),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildButtonCreate(),
              ],
            )
          ],
        ),
      ),
    );
  }

  void changes(String test, String mode) {
    if (mode == "email")
      email = test;
    else if (mode == "password")
      password = test;
    else if (mode == "password2") password2 = test;
  }

  Widget textfield1(String text, String func, bool obscure) {
    return TextField(
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'FiraCode',
        fontSize: 15,
      ),
      onChanged: (word) => changes(word, '$func'),
      obscureText: obscure,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor("000065"), width: 2.5),
            borderRadius: BorderRadius.circular(30)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor("000065"), width: 2.5),
          borderRadius: BorderRadius.circular(30),
        ),
        labelText: '$text',
        labelStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'FiraCode',
        ),
      ),
    );
  }

  Container buildButtonCreate() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text(
            "Create User",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'FiraCode',
            ),
          ),
          onTap: () async {
            if (password != password2) {
              EasyLoading.showInfo("password is not matched");
            } else
              await createUser();
          },
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black54, width: 2.5),
        ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Future createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "$email", password: "$password");
      EasyLoading.showSuccess("Register Complete");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Signin()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //print('The Password is to weak');
        EasyLoading.showInfo("The Password is to weak");
      } else if (e.code == 'email-already-in-use') {
        //print('The account already exists for that email.');
        EasyLoading.showInfo("The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }
}
