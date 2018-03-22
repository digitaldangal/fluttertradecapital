import 'package:flutter/material.dart';

import 'src/app.dart';

void main() => runApp(new App());


////////////////////////////////////


//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//
//final FirebaseAuth _auth = FirebaseAuth.instance;
//final GoogleSignIn _googleSignIn = new GoogleSignIn();
//
//void main() {
//  runApp(new MaterialApp(title: 'Firestore Example', home: new MyHomePage()));
//}
//
//class BookList extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new StreamBuilder<QuerySnapshot>(
//      stream: Firestore.instance.collection('books').snapshots,
//      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//        if (!snapshot.hasData) return const Text('Loading...');
//        return new ListView(
//          children: snapshot.data.documents.map((DocumentSnapshot document) {
//            return new ListTile(
//              title: new Text(document['message']),
//            );
//          }).toList(),
//        );
//      },
//    );
//  }
//}
//
//class MyHomePage extends StatelessWidget {
//  CollectionReference get messages => Firestore.instance.collection('messages');
//
//  Future<Null> _addMessage() async {
//    Firestore.instance
//        .collection('books')
//        .document()
//        .setData(<String, String>{'message': 'Hello world!'});
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: const Text('Firestore Example'),
//      ),
//      body: new BookList(),
//      floatingActionButton: new FloatingActionButton(
//        onPressed: _addMessage,
//        tooltip: 'Increment',
//        child: new Icon(Icons.add),
//      ),
//    );
//  }
//}
//
//Future<FirebaseUser> signInWithGoogle() async {
//  // Attempt to get the currently authenticated user
//  GoogleSignInAccount currentUser = _googleSignIn.currentUser;
//  if (currentUser == null) {
//    // Attempt to sign in without user interaction
//    currentUser = await _googleSignIn.signInSilently();
//  }
//  if (currentUser == null) {
//    // Force the user to interactively sign in
//    currentUser = await _googleSignIn.signIn();
//  }
//
//  final GoogleSignInAuthentication auth = await currentUser.authentication;
//
//  // Authenticate with firebase
//  final FirebaseUser user = await _auth.signInWithGoogle(
//    idToken: auth.idToken,
//    accessToken: auth.accessToken,
//  );
//
//  assert(user != null);
//  assert(!user.isAnonymous);
//
//  return user;
//}
//
//Future<Null> signOutWithGoogle() async {
//  // Sign out with firebase
//  await _auth.signOut();
//  // Sign out with google
//  await _googleSignIn.signOut();
//}


////////////////////////////////////


