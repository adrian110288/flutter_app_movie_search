import 'package:flutter/material.dart';
import 'package:flutter_app_movie_search/database/db.dart';
import 'package:flutter_app_movie_search/model/movie.dart';

class MovieRow extends StatefulWidget {
  final Movie movie;
  final MovieDatabase db;

  MovieRow(this.movie, this.db);

  @override
  _MovieRowState createState() => _MovieRowState();
}

class _MovieRowState extends State<MovieRow> {
  Movie movieState;
  MovieDatabase db;

  @override
  void initState() {
    super.initState();
    movieState = widget.movie;
    db = widget.db;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        initiallyExpanded: false,
        leading: IconButton(
          icon: movieState.favored ? Icon(Icons.star) : Icon(Icons.star_border),
          color: Colors.white,
          onPressed: () =>
              setState(() {
                movieState.favored = !movieState.favored;
                movieState.favored == true
                    ? db.addMovie(movieState)
                    : db.deleteMovie(movieState.id);
              }),
        ),
        title: Container(
          height: 200,
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              movieState.posterPath != null
                  ? Hero(
                  tag: movieState.id,
                  child: Image.network(
                      "https://image.tmdb.org/t/p/w92${movieState.posterPath}"))
                  : Container(),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          movieState.title,
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
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                text: TextSpan(
                  text: movieState.overview,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                    height: 1.2,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
