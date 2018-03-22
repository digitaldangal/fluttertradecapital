part of todomvc;

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MainAppState();
}

class MainAppState extends State<MainApp> {
  int _index;

  @override
  void initState() {
    super.initState();
    _index = 0;
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

//  CollectionReference get messages => Firestore.instance.collection('messages');

  Future<Null> _addMessage() async {
    Firestore.instance
        .collection('books')
        .document()
        .setData(<String, String>{'message': '333Hello world!'});
  }

  Future<Null> _addBlogPost() async {
    Firestore.instance
        .collection('blogPosts')
        .document()
        .setData(<String, String>{'message': 'Hello world!'});
  }

  Future<Null> _addBlog() async {
    Firestore.instance.collection('blogs').document()
        .setData({ 'title': 'title', 'author': 'author' });
  }

  NewBottomBarPage(this.index);

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

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

//    if ( _googleSignIn.currentUser == null) {
//      Navigator.of(context).pushReplacementNamed('/');
////      Navigator.pop(context);
//    }

    if (this.index == 0) {
      //HOME
      return new MainHomeTab();
    } else if (this.index == 1) {
      //DISCOVERY
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('DISCOVERY'),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.search), onPressed: () {}),
            new IconButton(icon: new Icon(Icons.add), onPressed: _addMessage),
          ],
        ),
        body: new Center(child: new Text('DISCOVERY shows here, index: $index'),),
//        body: new BookList(),
      );
    } else if (this.index == 2) {
      //PROFILE
      if (_googleSignIn.currentUser == null) {
        return new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(),
                new SizedBox(width: 20.0),
                new Text("Loading Profile ..."),
              ],
            ),
            new RaisedButton(
                onPressed: () {},
                child: const Text("Sign Out")
            ),

          ],
        );
      } else {
        return new MainProfileTab();
      }
    }

    return new Center(
      child: new Text('Error! , index: $index'),
    );
  }
}

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('books').snapshots,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        return new ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document['message']),
            );
          }).toList(),
        );
      },
    );
  }
}


class BookList2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('blogPosts').snapshots,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        return new ListView(
          shrinkWrap: true,
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document['title']),
            );
          }).toList(),
        );
      },
    );
  }
}
