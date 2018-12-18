import 'package:flutter/material.dart';
import 'package:flutter_app_movie_search/home_page.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Seacher',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
