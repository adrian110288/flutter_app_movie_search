import 'package:flutter/material.dart';
import 'package:flutter_app_movie_search/database/db.dart';
import 'package:flutter_app_movie_search/model/movie.dart';

class MovieRow extends StatefulWidget {
  final Movie movie;

  MovieRow(this.movie);

  @override
  _MovieRowState createState() => _MovieRowState();
}

class _MovieRowState extends State<MovieRow> {
  Movie movieState;

  @override
  void initState() {
    super.initState();
    movieState = widget.movie;
    MovieDatabase db = MovieDatabase();
    db
        .getMovie(movieState.id)
        .then((movie) => setState(() => movieState.favored = movie.favored));
  }

  void _onPressed() {
    MovieDatabase db = MovieDatabase();
    setState(() {
      movieState.favored = !movieState.favored;
      movieState.favored == true
          ? db.addMovie(movieState)
          : db.deleteMovie(movieState.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        initiallyExpanded: false,
        leading: IconButton(
            icon:
            movieState.favored ? Icon(Icons.star) : Icon(Icons.star_border),
            color: Colors.white,
            onPressed: _onPressed),
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
