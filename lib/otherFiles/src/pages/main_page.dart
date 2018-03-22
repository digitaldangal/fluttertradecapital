
part of tradecapital;

final FirebaseApp app = new FirebaseApp(
  name: 'tc2',
  options: Platform.isIOS
      ? const FirebaseOptions(
    googleAppID: '1:203825443053:ios:2427c236e3209c14',
//    gcmSenderID: '297855924061', //#
    databaseURL: 'https://flutter-project-fd216.firebaseio.com/',
  )
      : const FirebaseOptions(
    googleAppID: '1:203825443053:android:2427c236e3209c14',
    apiKey: 'AIzaSyD-QwNS15i5caKT7c8CoR62ICcV5vxDOYI',
    databaseURL: 'https://flutter-project-fd216.firebaseio.com/',
  ),
);


class Main extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MainState();
}

class MainState extends State<Main> with SingleTickerProviderStateMixin {
  int _index;
//
//  List<BlogPostItem> _items = new List();
//  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _index = 0;

//    Repository.get().getAllBlogPosts()
//        .then((books) {
//      setState(() {
//        _items = books;
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
              icon: new Icon(Icons.account_circle),
              title: new Text("Profile"),
            ),
          ]),
    );
  }
}

class NewBottomBarPage extends StatelessWidget {
  final int index;

  NewBottomBarPage(this.index);

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {

    void _newPost() {
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context) {
            void _submitPost(post) {
              print(post);
            }
            return new Scaffold(
              appBar: new AppBar(
                title: new Text('_newPost'),
              ),
              body: new TextField(
                autofocus: true,
                onSubmitted: _submitPost,
              ),
            );
          },
        ),
      );
    }

    Future<Null> _askedToSignOut() async {
      switch (await showDialog<String>(
        context: context,
        child: new SimpleDialog(
          title: const Text('Confirm Signout'),
          children: <Widget>[
            new SimpleDialogOption(
              onPressed: () { Navigator.pop(context, "Confirm"); },
              child: const Text('Confirm'),
            ),
            new SimpleDialogOption(
              onPressed: () { Navigator.pop(context, "Cancel"); },
              child: const Text('Cancel'),
            ),
          ],
        ),
      )) {
        case "Confirm":
          await signOutWithGoogle();
          Navigator.of(context).pushReplacementNamed('/');
          break;
        case "Cancel":
        // ...
          break;
      }
    }

    if (this.index == 0) {
      //HOME
      return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: new Text('Trade Capital'),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.trending_up),
                onPressed: () {scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Opening Up The Markets...")));}),
          ],
        ),
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
//      if ( _googleSignIn.currentUser == null) {
//          Navigator.of(context).pushReplacementNamed('/');
//      }
      //DASHBOARD
      return new Scaffold(
          appBar: new AppBar(
            title: new Text(_googleSignIn.currentUser.displayName),
            actions: <Widget>[
              new IconButton(
                  icon: new Icon(Icons.exit_to_app),
                  onPressed: _askedToSignOut),
              new IconButton(
                  icon: new Icon(Icons.settings),
                  onPressed: (){}),
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
                new Text (_googleSignIn.currentUser.toString())
              ],
            ),
          ),
          floatingActionButton: new FloatingActionButton(
              child: new Icon(Icons.library_add),
              tooltip: "Add New Post",
              onPressed: _newPost));
    }
    return new Center(
      child: new Text('Error! , index: $index'),
    );
  }
}
