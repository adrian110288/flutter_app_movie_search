import 'package:flutter/material.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
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
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: movieState.favored
                          ? Icon(Icons.star)
                          : Icon(Icons.star_border),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.arrow_downward),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
