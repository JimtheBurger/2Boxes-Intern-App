import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/models/movie.dart';
import 'package:testapp/widgets/moviesWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  final List<Movie> _movies = <Movie>[];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _populateAllMovies("Boxes", _page);
  }

  void _populateAllMovies(String name, int page) async {
    setState(() {
      _isLoading = true;
    });

    final movies = await _fetchAllMovies(name, page);
    setState(() {
      if (_page == 1) {
        _movies.clear(); // Clearing the list only on the first page load
      }
      _movies.addAll(movies);
      _isLoading = false;
      _page++;
    });
  }

  Future<List<Movie>> _fetchAllMovies(String name, int page) async {
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
    return Scaffold(
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
          decoration: const BoxDecoration(
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
        actions: [
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
                          _page = 1; // Resetting page number to 1 on search
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
      body: Builder(
        builder: (BuildContext context) {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!_isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                if(_searchController.text != ""){
                  _populateAllMovies(_searchController.text, _page);
                } else{
                  _populateAllMovies("Boxes", _page);
                }
              }
              return true;
            },
            child: _isLoading
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
