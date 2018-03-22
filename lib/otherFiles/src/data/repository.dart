//
//
//part of tradecapital;
//
///// A class similar to http.Response but instead of a String describing the body
///// it already contains the parsed Dart-Object
//class ParsedResponse<T> {
//  ParsedResponse(this.statusCode, this.body);
//  final int statusCode;
//  final T body;
//
//  bool isOk() {
//    return statusCode >= 200 && statusCode < 300;
//  }
//}
//
//
//final int NO_INTERNET = 404;
//
//class Repository {
//
//  static final Repository _repo = new Repository._internal();
//
//  PostDatabase database;
//
//  static Repository get() {
//    return _repo;
//  }
//
//  Repository._internal() {
//    database = PostDatabase.get();
//  }
//
//
//  /// Fetches the books from the Google Books Api with the query parameter being input.
//  /// If a book also exists in the local storage (eg. a book with notes/ stars) that version of the book will be used instead
//  Future<ParsedResponse<List<BlogPostItem>>> getBlogPosts(String input) async{
//    //http request, catching error like no internet connection.
//    //If no internet is available for example response is
//     http.Response response = await http.get("https://www.googleapis.com/books/v1/volumes?q=$input")
//         .catchError((resp) {});
//
//     if(response == null) {
//       return new ParsedResponse(NO_INTERNET, []);
//     }
//
//     //If there was an error return an empty list
//     if(response.statusCode < 200 || response.statusCode >= 300) {
//       return new ParsedResponse(response.statusCode, []);
//     }
//     // Decode and go to the items part where the necessary book information is
//     List<dynamic> list = JSON.decode(response.body)['items'];
//
//     Map<String, BlogPostItem> networkBlogPosts = {};
//
//    for(dynamic jsonBlogPostItem in list) {
//      BlogPostItem _postDatabase = new BlogPostItem(
//          title: jsonBlogPostItem["volumeInfo"]["title"],
//          desc: jsonBlogPostItem["volumeInfo"]["desc"],
//          id: jsonBlogPostItem["id"]
//      );
//
//      networkBlogPosts[_postDatabase.id] = _postDatabase;
//    }
//
//    List<BlogPostItem> databaseBook = await database.getBlogPosts([]..addAll(networkBlogPosts.keys));
//    for(BlogPostItem blogPostItem in databaseBook) {
//      networkBlogPosts[blogPostItem.id] = blogPostItem;
//    }
//
//    return new ParsedResponse(response.statusCode, []..addAll(networkBlogPosts.values));
//  }
//
//  Future updateBlogPostItem(BlogPostItem blogPostItem) async {
//    database.updateBlogPostItem(blogPostItem);
//  }
//
//  Future close() async {
//    return database.close();
//  }
//
//
//
//
//
//  Future<List<BlogPostItem>> getAllBlogPosts() {
//    return database.getAllBlogPosts();
//  }
//
//
//
//
//}