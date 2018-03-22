// Copyright (c) 2017, Brian Armstrong. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library tradecapital;

import 'dart:async';
import 'dart:io' show Platform;
import 'dart:math';
import 'dart:io';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_database/ui/firebase_animated_list.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:image_picker/image_picker.dart';

part 'pages/splash_page.dart';
part 'pages/main_page.dart';
//part 'pages/todo_list.dart';
//part 'models/blog_post_item.dart';
part 'util/authentication.dart';
part 'widgets/todo_header.dart';
//part 'widgets/todo_widget.dart';
//part 'data/database.dart';
//part 'data/repository.dart';
//part 'pages/new_post.dart';
//part 'pages/fruendlychatexample.dart';

class TcApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Trade • Capital',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        fontFamily: 'Helvetica Neue',
        primarySwatch: Colors.red,
      ),
      home: new SplashPage(),
      routes: <String, WidgetBuilder>{
//        '/todo': (BuildContext context) => new TodoList(),
        '/main': (BuildContext context) => new Main(),
        '/friend': (BuildContext context) => new Main(),
      },
    );
  }
}
