import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'signin.dart';

class register extends StatefulWidget {
  register({Key key}) : super(key: key);

  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<register> {
  //String status;
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
                  TextField(
                    style: TextStyle(color: Colors.white),
                    onChanged: (mail) => email = mail,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor("000065"), width: 2.5),
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: HexColor("000065"), width: 2.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'email',
                        labelStyle: TextStyle(color: Colors.white)),
                  ),
                  Text(""),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    onChanged: (pass) => password = pass,
                    obscureText: true,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor("000065"), width: 2.5),
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: HexColor("000065"), width: 2.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'password',
                        labelStyle: TextStyle(color: Colors.white)),
                  ),
                  Text(""),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    onChanged: (pass) => password2 = pass,
                    obscureText: true,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor("000065"), width: 2.5),
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: HexColor("000065"), width: 2.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'confirm password',
                        labelStyle: TextStyle(color: Colors.white)),
                  )
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

  Container buildButtonCreate() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Create User",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () async {
            if (password.isEmpty || password.isEmpty || email.isEmpty) {
              EasyLoading.showInfo("asdasd");
            } else if (password != password2) {
              EasyLoading.showInfo("asdasd");
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
