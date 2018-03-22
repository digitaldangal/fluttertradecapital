//part of tradecapital;
//
//class CreateNewPost extends StatefulWidget {
//  @override
//  _CreateNewPostState createState() => new _CreateNewPostState();
//}
//
//class _CreateNewPostState extends State<CreateNewPost> {
//  int _counter;
//  DatabaseReference _counterRef;
//  DatabaseReference _messagesRef;
//  StreamSubscription<Event> _counterSubscription;
//  StreamSubscription<Event> _messagesSubscription;
//  bool _anchorToBottom = false;
//
//  String _kTestKey = 'Hello';
//  String _kTestValue = 'world!';
//  DatabaseError _error;
//
//  @override
//  void initState() {
//    super.initState();
//    FirebaseApp.configure(name: app.name, options: app.options);
//    // Demonstrates configuring to the database using a file
//    _counterRef = FirebaseDatabase.instance.reference().child('counter');
//    // Demonstrates configuring the database directly
//    final FirebaseDatabase database = new FirebaseDatabase(app: app);
//    _messagesRef = database.reference().child('messages');
//    database.reference().child('counter').once().then((DataSnapshot snapshot) {
//      print('Connected to second database and read ${snapshot.value}');
//    });
//    database.setPersistenceEnabled(true);
//    database.setPersistenceCacheSizeBytes(10000000);
//    _counterRef.keepSynced(true);
//    _counterSubscription = _counterRef.onValue.listen((Event event) {
//      setState(() {
//        _error = null;
//        _counter = event.snapshot.value ?? 0;
//      });
//    }, onError: (Object o) {
//      final DatabaseError error = o;
//      setState(() {
//        _error = error;
//      });
//    });
//    _messagesSubscription =
//        _messagesRef.limitToLast(10).onChildAdded.listen((Event event) {
//          print('Child added: ${event.snapshot.value}');
//        }, onError: (Object o) {
//          final DatabaseError error = o;
//          print('Error: ${error.code} ${error.message}');
//        });
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    _messagesSubscription.cancel();
//    _counterSubscription.cancel();
//  }
//
//  Future<Null> _increment() async {
////    await FirebaseAuth.instance.signInAnonymously();
//    final GoogleSignInAuthentication auth = await _googleSignIn.currentUser.authentication;
//
//    // Authenticate with firebase
//    await _auth.signInWithGoogle(
//      idToken: auth.idToken,
//      accessToken: auth.accessToken,
//    );
//    // Increment counter in transaction.
//    final TransactionResult transactionResult =
//    await _counterRef.runTransaction((MutableData mutableData) async {
//      mutableData.value = (mutableData.value ?? 0) + 1;
//      return mutableData;
//    });
//
//    if (transactionResult.committed) {
//      _messagesRef.push().set(<String, String>{
//        _kTestKey: '$_kTestValue ${transactionResult.dataSnapshot.value}'
//      });
//    } else {
//      print('Transaction not committed.');
//      if (transactionResult.error != null) {
//        print(transactionResult.error.message);
//      }
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: const Text('Flutter Database Example'),
//      ),
//      body: new Column(
//        children: <Widget>[
//          new Flexible(
//            child: new Center(
//              child: _error == null
//                  ? new Text(
//                'Button tapped $_counter time${ _counter == 1 ? '' : 's' }.\n\n'
//                    'This includes all devices, ever.',
//              )
//                  : new Text(
//                'Error retrieving button tap count:\n${_error.message}',
//              ),
//            ),
//          ),
//          new ListTile(
//            leading: new Checkbox(
//              onChanged: (bool value) {
//                setState(() {
//                  _anchorToBottom = value;
//                });
//              },
//              value: _anchorToBottom,
//            ),
//            title: const Text('Anchor to bottom'),
//          ),
//          new Flexible(
//            child: new FirebaseAnimatedList(
//              key: new ValueKey<bool>(_anchorToBottom),
//              query: _messagesRef,
//              reverse: _anchorToBottom,
//              sort: _anchorToBottom
//                  ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
//                  : null,
//              itemBuilder: (BuildContext context, DataSnapshot snapshot,
//                  Animation<double> animation, int index) {
//                return new SizeTransition(
//                  sizeFactor: animation,
//                  child: new Text("$index: ${snapshot.value.toString()}"),
//                );
//              },
//            ),
//          ),
//        ],
//      ),
//      floatingActionButton: new FloatingActionButton(
//        onPressed: _increment,
//        tooltip: 'Increment',
//        child: new Icon(Icons.add),
//      ),
//    );
//  }
//}