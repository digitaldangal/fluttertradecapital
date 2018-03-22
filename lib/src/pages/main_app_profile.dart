part of todomvc;

class MainProfileTab extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
   build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(_googleSignIn.currentUser.displayName),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (context) {
                        return new Settings();
                      },
                    ),
                  );
                }),
          ],
        ),
        body: new Container(
          margin: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal:
              20.0), //24 is minimum vertical amount to clear the status bar
//            child: new Text(_googleSignIn.currentUser.toString()),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
//                      new Padding(),
                    new CircleAvatar(
//                          foregroundColor: Colors.white,
                        backgroundColor: Colors.white,
                        backgroundImage: new NetworkImage(
                            _googleSignIn.currentUser.photoUrl),
                        radius: 48.0),
                  ]),
              new Text(_googleSignIn.currentUser.toString())
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.library_add),
            tooltip: "Add New Post",
            onPressed: () {
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (context) {
                    return new CreatePost();
                  },
                ),
              );
            })
    );
  }
}

