class Movie{
  final String imdbId;
  final String poster;
  final String title;
  final String year;

  Movie({this.imdbId = "[NO ID FOUND]", this.title = "[NO TITLE FOUND]", this.poster = "[NO POSTER FOUND]", this.year = "[NO YEAR FOUND]"});

  factory Movie.fromJson(Map<String, dynamic> json) { //This holds all of the Movie Object
    return Movie(
      imdbId: json["imdbID"],
      poster: json["Poster"],
      title: json["Title"],
      year: json["Year"],
    );
  }

}