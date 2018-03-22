import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class SignIn extends StatelessWidget {

  final BuildContext context;

  SignIn(this.context);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Trade Capital'),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Center(
            child: new Text('SignIn Page'),
          ),
          new MaterialButton(
              child: const Text('Test signInWithGoogle'), onPressed: _testSignInWithGoogle),
        ],
      ),
//      body: new Center(
//        child: new Text('Home Page'),
//      ),
    );
  }


  Future<String> _testSignInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    print("====================================================");
    print("This user is signed in: $user");
    print("====================================================");


    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    if (user != null)
//      Navigator.of(context)
      Navigator.removeRoute(context,
        new MaterialPageRoute(
          builder: (context) {
          this;
          },
        ),
      );


    return 'signInWithGoogle succeeded: $user';
  }
}
