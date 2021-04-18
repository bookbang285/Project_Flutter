import 'dart:convert';
import 'package:authentication_login/component/signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuth auth = FirebaseAuth.instance;
  auth.authStateChanges().listen((User user) {
    if (user == null) {
      print("User is currently signed out!");
    } else {
      print("User is signed In !");
    }
  });
//await createUser();

  await auth.signOut();

  runApp(MaterialApp(
    home: Scaffold(
      body: Signin(),
    ),
    builder: EasyLoading.init(),
  ));
}
