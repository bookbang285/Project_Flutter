import 'dart:math';
import 'dart:ui';
import 'package:authentication_login/component/register.dart';
import 'package:authentication_login/component/sec.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Signin extends StatefulWidget {
  final String status;
  const Signin({Key key, this.status}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

//// Class Hex Color
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
/////

class _SigninState extends State<Signin> {
  String status;
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    EasyLoading.init();
  }

  void changes(String test, String mode) {
    if (mode == 'email')
      email = test;
    else if (mode == 'password') password = test;
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

  @override //+
  Widget build(BuildContext context) {
    return Container(
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
          Center(
            child: Text(
              'Welcome to AppKakkak',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'FiraCode',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                textfield1('email', "email", false),
                Text(""),
                textfield1('password', "password", true),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButtonSignIn(),
              buildRegister(),
            ],
          )
        ],
      ),
    );
  }

  Container buildRegister() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text(
            "Register",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'FiraCode',
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => register()),
            );
          },
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black54, width: 2.5),
        ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Container buildButtonSignIn() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text(
            "Sign in",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'FiraCode',
            ),
          ),
          onTap: () {
            onClickSignIn();
          },
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black54, width: 2.5),
        ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  void onClickSignOut() async {
    await FirebaseAuth.instance.signOut();
    EasyLoading.showSuccess("Sign-Out Complete");
  }

  Future onClickSignIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: "$email", password: "$password");
      EasyLoading.showSuccess("Sign-in Complete");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => sec()),
      );
      print("Email : $email");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        EasyLoading.showInfo("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        EasyLoading.showInfo("Wrong password provided for that user.");
      } else {
        EasyLoading.showInfo("Please Enter Email and Password");
      }
    } catch (error) {
      print(e);
    }
  }
}
