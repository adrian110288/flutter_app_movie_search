import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_movie_search/model/movie.dart';
import 'package:flutter_app_movie_search/movie_row.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

const key = '45494729ffc2b564c28e7276f8ab72aa';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> _movies = List();
  bool _hasLoaded = true;

  final PublishSubject subject = PublishSubject<String>();

  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    subject.stream.debounce(Duration(milliseconds: 400)).listen(searchMovies);
  }

  void searchMovies(query) {
    print(query);

    resetMovies();

    if (query.isEmpty) {
      setState(() => _hasLoaded = true);
      return;
    }

    setState(() => _hasLoaded = false);

    http
        .get(
            'https://api.themoviedb.org/3/search/movie?api_key=$key&query=$query')
        .then((res) => res.body)
        .then(json.decode)
        .then((map) => map['results'])
        .then((movies) => movies.forEach(addMovie))
        .then((e) {
      setState(() {
        _hasLoaded = true;
      });
    });
  }

  void addMovie(item) {
    setState(() => _movies.add(Movie.fromJson(item)));
  }

  void resetMovies() {
    setState(() => _movies.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Searcher"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (text) => subject.add(text),
            ),
            _hasLoaded ? Container() : CircularProgressIndicator(),
            Expanded(
                child: ListView.builder(
                    itemCount: _movies.length,
                    itemBuilder: (context, index) {
                      return MovieRow(_movies[index]);
                    }))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
