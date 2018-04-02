part of todomvc;

//class CreatePost extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    Future<Null> _askedToSignOut() async {
//      switch (await showDialog<String>(
//        context: context,
//        child: new SimpleDialog(
//          title: const Text('Confirm Signout'),
//          children: <Widget>[
//            new SimpleDialogOption(
//              onPressed: () {
//                Navigator.pop(context, "Confirm");
//              },
//              child: const Text('Confirm'),
//            ),
//            new SimpleDialogOption(
//              onPressed: () {
//                Navigator.pop(context, "Cancel");
//              },
//              child: const Text('Cancel'),
//            ),
//          ],
//        ),
//      )) {
//        case "Confirm":
//          await signOutWithGoogle();
//          Navigator.of(context).pushReplacementNamed('/');
//          break;
//        case "Cancel":
//          // ...
//          break;
//      }
//    }
//
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text('Create Post'),
//        actions: <Widget>[
//          new IconButton(
//              icon: new Icon(Icons.exit_to_app), onPressed: _askedToSignOut),
//        ],
//      ),
//      body: new Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          new Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              new CircularProgressIndicator(),
//              new SizedBox(width: 20.0),
//              new Text("Loading Profile ..."),
//            ],
//          ),
//          new RaisedButton(
//              onPressed: (){},
//            child: const Text("Sign Out")
//              ),
//
//        ],
//      ),
//    );
//  }
//}


class CreatePost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return new MaterialApp(
//      home: new MyHomePage(),
//    );
    return new MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Create Post"),
        bottom: new TabBar(controller: _controller, tabs: <Tab>[
          new Tab(text: "BLOG"),
          new Tab(text: "MEDIA"),
          new Tab(text: "TTF"),
        ])
      ),
      body: new TabBarView(
        controller: _controller,
        children: <Widget>[
          new BlogPage(),
          new MediaPage(),
          new TTFPage(),
        ],
      ),
    );
  }

}

class BlogPage extends StatefulWidget {
  @override
  State createState() => new BlogPageState();
}

class BlogPageState extends State<BlogPage> {

  BlogPageState();

  String title = "";
  String description = "";
  String authorName = _googleSignIn.currentUser.displayName;

  final TextEditingController titleTextController = new TextEditingController();
  final TextEditingController descTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    Future<Null> _addNewBlogPost() async {

      if (title != "" && description != "") {
//        BlogPost newBlog = new BlogPost(title, description, _googleSignIn.currentUser.displayName);
        DateTime now = new DateTime.now().toUtc();
        Firestore.instance
            .collection('blogPosts')
            .document()
//            .setData(<String, String>{'title': title});
            .setData(
            {
              'title': title,
              'description': description,
              'authorName': _googleSignIn.currentUser.displayName,
              'authorId': _googleSignIn.currentUser.id,
              'createdAt': now
            });

//        Navigator.of(context).pushReplacementNamed('/');
        Navigator.pop(context);
      }

      if (title == "" && description != "") {
        titleTextController.text = titleTextController.text + "#";
      }

      if (title != "" && description == "") {
        descTextController.text = descTextController.text + "#";
      }

//      Navigator.canPop(context);
//        Navigator.of(context).removeRoute(this);
    }

    return new Container(
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextField(
              decoration: new InputDecoration(
                hintText: "Title!"
              ),
              onChanged: (String str) {
                //disable other tabs when str!=""
                setState((){
                  title = str;
                });
              },
              onSubmitted: (String str) {
                //disable other tabs when str!=""
                setState((){
                  title = str;
                });
//                textController.text = "";
                _addNewBlogPost();
              },
              controller: titleTextController,
            ),
            new SizedBox(height: 20.0),
            new TextField(
              decoration: new InputDecoration(
                  hintText: "Description!"
              ),
              onChanged: (String str) {
                //disable other tabs when str!=""
                setState((){
                  description = str;
                });
              },
              onSubmitted: (String str) {
                //disable other tabs when str!=""
                setState((){
                  description = str;
                });
//                textController.text = "";
                _addNewBlogPost();
              },
              controller: descTextController,
            ),
            new SizedBox(height: 20.0),
            new RaisedButton(onPressed: _addNewBlogPost, child: new Text("Submit"))
          ],
        )
      )
    );
//    return new Center(
//      child: new Text('BlogPage'),
//    );
  }
}

class MediaPage extends StatelessWidget {

  MediaPage();

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text('MediaPage'),
    );
  }
}

class TTFPage extends StatelessWidget {

  TTFPage();

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text('TTFPage'),
    );
  }
}

