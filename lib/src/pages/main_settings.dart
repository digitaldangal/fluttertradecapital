part of todomvc;

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Null> _askedToSignOut() async {
      switch (await showDialog<String>(
        context: context,
        child: new SimpleDialog(
          title: const Text('Confirm Signout'),
          children: <Widget>[
            new SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Confirm");
              },
              child: const Text('Confirm'),
            ),
            new SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Cancel");
              },
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

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Settings'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.exit_to_app), onPressed: _askedToSignOut),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new SizedBox(height: 20.0),
          new Center(
            child: new Text("Settings Page")
          ),
          new SizedBox(height: 20.0),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(Icons.vpn_lock),
              new SizedBox(width: 20.0),
              new Icon(Icons.public),
            ],
          ),
          new SizedBox(height: 20.0),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("User ID: "),
              new SizedBox(width: 20.0),
              new Text(_googleSignIn.currentUser.id),
            ],
          ),
          new SizedBox(height: 20.0),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("User Name: "),
              new SizedBox(width: 20.0),
              new Text(_googleSignIn.currentUser.displayName),
            ],
          ),
          new SizedBox(height: 20.0),
          new Text(_googleSignIn.currentUser.toString()),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new CircularProgressIndicator(),
              new SizedBox(width: 20.0),
              new Text("Nothing is Loading (Just a test) ..."),
            ],
          ),
          new SizedBox(height: 20.0),
          new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('Title Of The Post'),
                  subtitle: const Text('by Account Name'),
                  trailing: const Icon(Icons.local_activity),
                ),
                new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new Card(
                      color: Colors.grey,
                      child: new Center(
                          child: new Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod incididunt ut labore et dolore magna aliqua.")
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
                          const Icon(Icons.visibility),
                        ],
                      ),
//                      new SizedBox(width: 2.0, height: 30.0, child: new Container(color: Colors.black)),
                      const Text('17 hours ago'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          new SizedBox(height: 20.0),
          new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('Title Of The Post'),
                  subtitle: const Text('by Account Name'),
                  trailing: const Icon(Icons.vpn_key),
                ),
                new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new Card(
                      color: Colors.grey,
                      child: new Center(
                          child: new Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod incididunt ut labore et dolore magna aliqua.")
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
                      const Text('17 hours ago'),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
