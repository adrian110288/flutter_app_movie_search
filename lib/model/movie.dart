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

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["title"] = title;
    map["poster_path"] = posterPath;
    map["overview"] = overview;
    map["favored"] = favored;
    return map;
  }
}
