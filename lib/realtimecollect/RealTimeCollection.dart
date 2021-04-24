import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RealtimeCollection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Log").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Column(
              children: <Widget>[
                CircularProgressIndicator(),
                Text("Loading . . . "),
              ],
            ),
          );
        } else {
          return new Container(
            child: Expanded(
              child: new ListView(
                padding: EdgeInsets.all(10.0),
                children: makeListWiget(snapshot),
              ),
            ),
          );
        }
      },
    );
  }

  List<Widget> makeListWiget(AsyncSnapshot snapshot) {
    return snapshot.data.docs.map<Widget>((document) {
      return ListTile(
        title: Text(
          document["name"],
          style: TextStyle(
            fontFamily: 'FiraCode',
            fontSize: 17,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          document["date"],
          style: TextStyle(
            fontFamily: 'FiraCode',
            fontSize: 15,
            color: Colors.white54,
          ),
        ),
      );
    }).toList();
  }
}
