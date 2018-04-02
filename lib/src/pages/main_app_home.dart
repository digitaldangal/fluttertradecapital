part of todomvc;

class MainHomeTab extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  List<BlogPost> todos;

  @override
   build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text('Trade Capital'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.trending_up),
              onPressed: () {
                scaffoldKey.currentState.showSnackBar(new SnackBar(
                    content: new Text("Opening Up The Markets...")));
              }),
          new IconButton(
              icon: new Icon(Icons.library_add),
              onPressed: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (context) {
                      return new CreatePost();
                    },
                  ),
                );
              }),
        ],
      ),
//      body: new Center(child: new Text('Home Page... ON ITS OWN!')),
//        body: new BookList2(),
        body: new BlogList(),
    );
  }
}

class BlogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('blogPosts').snapshots,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading Blogs...');
        return new ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            //create a new object here
            return new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: new Text(document['title'].toString()),
                    subtitle: new Text(document['authorName'].toString()),
//                    subtitle: new Text(document['authorName']),
                    trailing: const Icon(Icons.flag),
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: new Card(
                        color: Colors.redAccent,
                        child: new Center(
                            child: new Text(document['description'].toString())
                        )
                    ),
                  ),
                  new ButtonTheme.bar( // make buttons use the appropriate styles for cards
                    child: new ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new FlatButton(
                              child: new Row(
                                children: <Widget>[
                                  const Icon(Icons.star),
                                  const Icon(Icons.star),
                                  const Icon(Icons.star),
                                ],
                              ),
                              onPressed: () { /* ... */ },
                            ),
                          ],
                        ),
//                      new SizedBox(width: 2.0, height: 30.0, child: new Container(color: Colors.black)),
                        new Row(
                          children: <Widget>[
                            const Text("430K"),
                            const Icon(Icons.remove_red_eye),
                          ],
                        ),
//                      new SizedBox(width: 2.0, height: 30.0, child: new Container(color: Colors.black)),
//                        new Text(document['createdAt'].toString()),
                        new Text(DateTime.parse("1969-07-20 20:18:04Z").toLocal().toString()),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}