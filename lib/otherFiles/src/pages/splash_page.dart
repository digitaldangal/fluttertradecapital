part of tradecapital;

class SplashPage extends StatefulWidget {
  @override
  State createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    _auth.onAuthStateChanged
        .firstWhere((user) => user != null)
        .then((user) {
      // ignore: argument_type_not_assignable, argument_type_not_assignable
      Navigator.of(context).pushReplacementNamed('/main'); //should be main
    });

    // Give the navigation animations, etc, some time to finish
    new Future.delayed(new Duration(seconds: 1))
        .then((_) => signInWithGoogle());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                  onPressed: signInWithGoogle,
                child: new Text("Sign In With Google")
                  )
            ]
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new CircularProgressIndicator(),
              new SizedBox(width: 20.0),
              new Text("Please wait..."),
            ],
          ),
        ],
      ),
    );
  }
}