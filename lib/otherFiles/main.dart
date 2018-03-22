import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'getStarted.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

Future<Null> _ensureLoggedIn() async {
  GoogleSignInAccount user = _googleSignIn.currentUser;
  print("about to _ensureLoggedIn");
  if (user == null) user = await _googleSignIn.signInSilently();
  if (user == null) {
    await _googleSignIn.signIn();
//    analytics.logLogin();
  }
}

Future<String> _signInWithGoogle() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final FirebaseUser user = await _auth.signInWithGoogle(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  print("====================================================================");
  print("This user is signed in: $user");
  print("====================================================================");

  assert(user.email != null);
  assert(user.displayName != null);
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

//  return 'signInWithGoogle succeeded: $user';
  return '$user';
}

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter • TradeCapital',
      theme: new ThemeData(
        fontFamily: 'Helvetica Neue',
        primarySwatch: Colors.blue,
      ),
      home: new MyTCPage(),
//      home: _googleSignIn.currentUser==null
//          ? new SignIn()
//          : new MyTCPage(),
    );
  }
}

class MyTCPage extends StatefulWidget {
  @override
  State createState() => new MyTCPageState();
}

class MyTCPageState extends State<MyTCPage>
    with SingleTickerProviderStateMixin {
//  TabController _controller;
  int _index;

  @override
  void initState() {
    super.initState();
//    _controller = new TabController(length: 4, vsync: this);
    _index = 0;
  }

//  _googleSignIn.currentUser == null

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      _googleSignIn.current
      body: new NewBottomBarPage(_index),
      bottomNavigationBar: new BottomNavigationBar(
          currentIndex: _index,
          onTap: (int _index) {
            setState(() {
              this._index = _index;
            });
            new NewBottomBarPage(_index);
          },
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home"),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.lightbulb_outline),
              title: new Text("Discovery"),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.dashboard),
              title: new Text("Dashboard"),
            ),
          ]),
    );
  }
}

class NewBottomBarPage extends StatelessWidget {
  final int index;

  NewBottomBarPage(this.index);

  @override
  Widget build(BuildContext context) {

    void _signInPage() {
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context) {
            return new SignIn(context);
          },
        ),
      );
    }

    void _profilePage() {
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context) {
            return new Scaffold(
              appBar: new AppBar(
                title: new Text('Profile'),
              ),
              body: new Text(_googleSignIn.currentUser.toString()),
//              body: new Text(_googleSignIn.currentUser.displayName),
            );
          },
        ),
      );
    }

    void _addPost() {
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context) {
            return new Scaffold(
              appBar: new AppBar(
                title: new Text('New Post'),
              ),
              body: new Text("Add New Post"),
            );
          },
        ),
      );
    }

    _ensureLoggedIn();

    if (this.index == 0) {
      //HOME
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Trade Capital'),
          actions: <Widget>[
            new IconButton(
                icon: _googleSignIn.currentUser == null
                    ? null
                    : new Icon(Icons.account_circle),
                onPressed: _profilePage),
          ],
        ),
//        body: _googleSignIn.currentUser == null
//            ? new MaterialButton(
//                color: Colors.blue,
//                textColor: Colors.white,
//                child: new Text("SignIn"),
//                onPressed: _signInPage,
//              )
//            : new Center(child: new Text('Home Page, index: $index')),
        body: new Center(child: new Text('Home Page, index: $index')),
      );
    } else if (this.index == 1) {
      //DISCOVERY
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('DISCOVERY'),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.search), onPressed: () {}),
          ],
        ),
        body: new Center(
          child: new Text('DISCOVERY shows here, index: $index'),
        ),
      );
    } else if (this.index == 2) {
      //DASHBOARD
      return new Scaffold(
          appBar: new AppBar(
            title: new Text('Dashboard'),
            actions: <Widget>[
              new IconButton(
                  icon: new Icon(Icons.library_add), onPressed: _addPost),
            ],
          ),
          body: new Center(
            child: new Text('Markets will show here, index: $index'),
          ),
          floatingActionButton: new FloatingActionButton(
              child: new Icon(Icons.library_add),
              tooltip: "Add New Post",
              onPressed: _addPost));
    }
    return new Center(
      child: new Text('Error! , index: $index'),
    );
  }
}

class NewPage extends StatelessWidget {
  final int index;

  NewPage(this.index);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text('NewPage, index: $index'),
    );
  }
}

class DiscoveryPage extends StatelessWidget {
  final int index;

  DiscoveryPage(this.index);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text('DiscoveryPage, index: $index'),
    );
  }
}

class FoodPage extends StatelessWidget {
  final int index;

  FoodPage(this.index);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text('FoodPage, index: $index'),
    );
  }
}

class FunPage extends StatelessWidget {
  final int index;

  FunPage(this.index);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text('FunPage, index: $index'),
    );
  }
}
