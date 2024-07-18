import 'package:flutter/material.dart';
import 'package:mausam/Activity/Home.dart';
import 'package:mausam/Activity/Loading.dart';
import 'package:mausam/Activity/Location.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    routes: {
      "/" : (context) => Loading(),
      "/home" : (context) => Home(),
      "/loc" : (context) => Loading(),
    },
  ));
}
