// Copyright (c) 2017, Brian Armstrong. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// App launcher icon maker
// https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html#foreground.type=clipart&foreground.space.trim=1&foreground.space.pad=0.1&foreColor=rgba(96%2C%20125%2C%20139%2C%200)&backColor=rgb(255%2C%20255%2C%20255)&crop=0&backgroundShape=none&effects=score&name=ic_tc_launcher

library todomvc;

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'pages/splash_page.dart';
part 'pages/todo_list.dart';
part 'pages/main_app.dart';
part 'pages/main_app_home.dart';
part 'pages/main_app_profile.dart';
part 'pages/main_settings.dart';
part 'pages/main_create_post.dart';
part 'models/todo_item.dart';
part 'models/BlogPostItem.dart';
part 'util/authentication.dart';
part 'util/database.dart';
part 'widgets/todo_header.dart';
part 'widgets/todo_widget.dart';

class App extends StatelessWidget {
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
        '/todos': (BuildContext context) => new TodoList(),
        '/main': (BuildContext context) => new MainApp(),
      },
    );
  }
}
