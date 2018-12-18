class Movie {
  String title, posterPath, id, overview;
  bool favored;

  Movie({this.title, this.posterPath, this.id, this.overview, this.favored});

  Movie.fromJson(Map json) {
    title = json["title"];
    posterPath = json["poster_path"];
    id = json["id"].toString();
    overview = json["overview"];
    favored = false;
  }
}
