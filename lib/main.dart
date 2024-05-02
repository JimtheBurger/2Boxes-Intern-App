import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/models/movie.dart';
import 'package:testapp/widgets/moviesWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget { //This was created when I was trying to implement Lazy Loading. It may be a remenant of me trying a different method, but too afraid to Refactor it just in case.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Movie> _movies = <Movie>[];  //This is the list that will hold all the movies 
  final TextEditingController _searchController = TextEditingController();  //This is the controller for Search that was made so we can save the field to then do further searches
  bool _isLoading = false;  //Used since Lazy Loading started to have more loading, experimented with loading
  int _page = 1;  //page is incremented and reset based on the amount of Lazy Loads and Searches respectively

  @override
  void initState() {
    super.initState();
    _populateAllMovies("Boxes", _page);
  }

  void _populateAllMovies(String name, int page) async {  //Whenever you populate movies, you need to provide the name of what you are searching and then futher the page it should be
    setState(() {
      _isLoading = true;
    });

    final movies = await _fetchAllMovies(name, page);
    setState(() {
      if (_page == 1) {
        _movies.clear(); // Clearing the list on the first page load
      }
      _movies.addAll(movies);
      _isLoading = false;
      _page++;  //increment pages
    });
  }

  Future<List<Movie>> _fetchAllMovies(String name, int page) async {  //fetch all movies is the function used by populate to actually get the physical movies. Relative API stuff follows
    final response = await http.get(
        Uri.parse("https://www.omdbapi.com/?s=$name&page=$page&apikey=f509691a"));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["Search"];
      return list.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("[Failed to load movies]");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  //A frankensteins monster of a Scaffold. The first thing that was made and was slowly touched throughout development thus far
      appBar: AppBar(
        title: const Text(
          "Movies to Watch",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 1),
            fontWeight: FontWeight.w500,
            fontFamily: "Roboto",
            fontStyle: FontStyle.normal,
            fontSize: 19.0,
          ),
        ),
        toolbarHeight: 75,
        flexibleSpace: Container(
          decoration: const BoxDecoration(  //wanted to do a gradient instead of a solid color, this is the implementation
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(254, 137, 53, 1),
                Color.fromRGBO(254, 137, 53, 0),
              ],
              begin: FractionalOffset(0.0, 0.75),
              end: FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        actions: [  //This is how I got Searching to work, I couldn't figure out how to gracefully fit it in the body so I decided to do it within actions.
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Search Movies"),
                    content: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: "Enter movie name",
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text("Search"),
                        onPressed: () {
                          _page = 1; // Resetting page number to 1 when you search. If you don't do this, movies from the previous search will remain in the list
                          _populateAllMovies(_searchController.text, 1);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Builder(  //After implementing search and needing to use the MoviesWidget without going into it I actually did find a way to still edit WITHIN the body while outside the Widget.
        builder: (BuildContext context) {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) { //This is how you listen for getting to the end of the screen and then loading in more movies
              if (!_isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                if(_searchController.text != ""){ //For the original load there won't be anything in the search.
                  _populateAllMovies(_searchController.text, _page);
                } else{
                  _populateAllMovies("Boxes", _page);
                }
              }
              return true;
            },
            child: _isLoading //how loading was implemented
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : MoviesWidget(movies: _movies),
          );
        },
      ),
    );
  }
}
