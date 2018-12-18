import 'package:flutter/material.dart';
import 'package:flutter_app_movie_search/favourites.dart';
import 'package:flutter_app_movie_search/home_page.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Seacher',
      theme: ThemeData.dark(),
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Movie Searcher"),
              bottom: TabBar(tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.home),
                  text: "Home Page",
                ),
                Tab(
                  icon: Icon(Icons.favorite),
                  text: "Favourites",
                )
              ]),
            ),
            body: TabBarView(children: <Widget>[
              HomePage(),
              Favourites()
            ]),
          )),
    );
  }
}
