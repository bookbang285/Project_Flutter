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
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (mail) => email = mail,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: HexColor("000065"), width: 2.5),
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
                          borderSide:
                              BorderSide(color: HexColor("000065"), width: 2.5),
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: HexColor("000065"), width: 2.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'password',
                      labelStyle: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      "Forgot Password",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButtonSignIn(),
              //buildButtonSignOut(),
              buildRegister(),

              //buildButtonCreateData(),
              //buildButtonUpdateData(),
            ],
          )
        ],
      ),
    );
  }

  void onClickSignOut() async {
    await FirebaseAuth.instance.signOut();
    EasyLoading.showSuccess("Sign-Out Complete");
  }

  Container buildRegister() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Register",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
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
          child: Text("Sign in",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
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

  Container buildButtonCreate() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Register",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () async {
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

  Container buildButtonCreateData() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Create Data",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () {
            createData();
          },
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.blue),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Container buildButtonUpdateData() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Update",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () {
            UpdateData();
          },
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.blue),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
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
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        EasyLoading.showInfo("Please Enter Email and Password");
      }
    } catch (error) {
      print(e);
    }
  }

  Future createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "$email", password: "$password");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The Password is to weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void createData() {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    users
        .add({'name': 'Dawn Breaker', 'type': 'strength', 'hp': 1500})
        .then((value) => print('success'))
        .catchError((e) => print(e));
  }

  void UpdateData() {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    users
        .doc("RLAw9CXWbpQlEkzOo0Uh")
        .update({'hp': 1200, 'name': 'Darius', 'type': 'Mage'})
        .then((value) => print('updated!'))
        .catchError((e) => print('update error'));
  }
}
