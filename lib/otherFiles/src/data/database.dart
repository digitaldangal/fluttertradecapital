//part of tradecapital;
//
//
//class PostDatabase {
//  static final PostDatabase _postDatabase = new PostDatabase._internal();
//
//  final String tableName = "Blog_Posts";
//
//  Database db;
//
//  bool didInit = false;
//
//  static PostDatabase get() {
//    return _postDatabase;
//  }
//
//  PostDatabase._internal();
//
//
//  /// Use this method to access the database, because initialization of the database (it has to go through the method channel)
//  Future<Database> _getDb() async{
//    if(!didInit) await _init();
//    return db;
//  }
//
//
//  Future _init() async {
//    // Get a location using path_provider
//    Directory documentsDirectory = await getApplicationDocumentsDirectory();
//    String path = join(documentsDirectory.path, "demo.db");
//    db = await openDatabase(path, version: 1,
//        onCreate: (Database db, int version) async {
//          // When creating the db, create the table
//          await db.execute(
//              "CREATE TABLE $tableName ("
//                  "${BlogPostItem.db_id} STRING PRIMARY KEY,"
//                  "${BlogPostItem.db_title} TEXT,"
//                  "${BlogPostItem.db_desc} TEXT,"
//                  ")");
//        });
//    didInit = true;
//
//
//  }
//
//  /// Get a book by its id, if there is not entry for that ID, returns null.
//  Future<BlogPostItem> getBlogPostItem(String id) async{
//    var db = await _getDb();
//    var result = await db.rawQuery('SELECT * FROM $tableName WHERE ${BlogPostItem.db_id} = "$id"');
//    if(result.length == 0)return null;
//    return new BlogPostItem.fromMap(result[0]);
//  }
//
//  /// Get all books with ids, will return a list with all the books found
//  Future<List<BlogPostItem>> getBlogPosts(List<String> ids) async{
//    var db = await _getDb();
//    var idsString = ids.map((it) => '"$it"').join(',');
//    var result = await db.rawQuery('SELECT * FROM $tableName WHERE ${BlogPostItem.db_id} IN ($idsString)');
//    var books = [];
//    for(Map<String, dynamic> item in result) {
//      books.add(new BlogPostItem.fromMap(item));
//    }
//    return books;
//  }
//
//
//  /// Get all books
//  Future<List<BlogPostItem>> getAllBlogPosts() async{
//    var db = await _getDb();
//    var result = await db.rawQuery('SELECT * FROM $tableName');
//    var books = [];
//    for(Map<String, dynamic> item in result) {
//      books.add(new BlogPostItem.fromMap(item));
//    }
//    return books;
//  }
//
//
//  /// Inserts or replaces the book.
//  Future updateBlogPostItem(BlogPostItem blogPostItem) async {
//    var db = await _getDb();
//    await db.inTransaction(() async {
//      await db.rawInsert(
//          'INSERT OR REPLACE INTO '
//              '$tableName(${BlogPostItem.db_id}, ${BlogPostItem.db_title}, ${BlogPostItem.db_desc})'
//              ' VALUES("${blogPostItem.id}", "${blogPostItem.title}", "${blogPostItem.desc}")');
//    });
//  }
//
//  Future close() async {
//    var db = await _getDb();
//    return db.close();
//  }
//
//}