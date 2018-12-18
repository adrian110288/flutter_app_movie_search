import 'package:flutter/material.dart';
import 'package:flutter_app_movie_search/database/db.dart';
import 'package:flutter_app_movie_search/model/movie.dart';
import 'package:rxdart/rxdart.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List<Movie> filteredMovies = List();
  List<Movie> movieCache = List();

  final PublishSubject subject = PublishSubject<String>();

  @override
  void initState() {
    super.initState();
    filteredMovies = [];
    movieCache = [];
    subject.stream.listen(searchDataList);
    setupList();
  }

  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  void setupList() async {
    MovieDatabase db = MovieDatabase();
    filteredMovies = await db.getMovies();
    setState(() {
      movieCache = filteredMovies;
    });
  }

  void searchDataList(query) {
    if (query.isEmpty) {
      setState(() {
        filteredMovies = movieCache;
      });
    }
    setState(() {});
    filteredMovies = filteredMovies
        .where((m) => m.title
            .toLowerCase()
            .trim()
            .contains(RegExp(r'' + query.toLowerCase().trim() + '')))
        .toList();
    setState(() {});
  }

  void _onDelete(int index) {
    setState(() {
      filteredMovies.remove(filteredMovies[index]);
    });

    MovieDatabase db = MovieDatabase();
    db.deleteMovie(filteredMovies[index].id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          TextField(
            onChanged: (string) => subject.add(string),
            keyboardType: TextInputType.url,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: filteredMovies.length,
                  itemBuilder: (context, index) => ExpansionTile(
                        initiallyExpanded: false,
                        children: <Widget>[],
                        title: Container(
                          height: 200,
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              filteredMovies[index].posterPath != null
                                  ? Hero(
                                      tag: filteredMovies[index].id,
                                      child: Image.network(
                                          "https://image.tmdb.org/t/p/w92${filteredMovies[index].posterPath}"))
                                  : Container(),
                              Expanded(
                                child: Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          filteredMovies[index].title,
                                          maxLines: 10,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        leading: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _onDelete(index)),
                      )))
        ],
      ),
    );
  }
}
