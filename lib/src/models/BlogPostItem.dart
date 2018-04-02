part of todomvc;

//class BlogPost {
//  DateTime dateTime = new DateTime.now();
//  String title;
//  String description;
//  String authorName;
//
//  BlogPost(this.title, this.description, this.authorName);
//
//  setDateTime(DateTime newDateTime){
//    this.dateTime = newDateTime;
//  }
//
//  toJson() {
//    return {
//      "date": dateTime.millisecondsSinceEpoch,
//      "title": title,
//      "description": description,
//      "authorName": authorName
//    };
//  }
//
////  BlogPost.fromSnapshot(DocumentSnapshot snapshot)
////      : key = snapshot.key,
////        dateTime =
////        new DateTime.fromMillisecondsSinceEpoch(snapshot.value["date"]),
////        note = snapshot.value["note"];
//
//}



class BlogPost {
  final String id;
  String title;
  String description;
  String authorName;
  DateTime dateTime = new DateTime.now();

  BlogPost({
    this.id,
    @required this.title,
    @required this.authorName,
    @required this.description,
  })
      : assert(title != null && title.isNotEmpty),
        assert(description != null && description.isNotEmpty);

  toJson() {
    return {
      "date": dateTime.millisecondsSinceEpoch,
      "title": title,
      "description": description,
      "authorName": authorName
    };
  }
}