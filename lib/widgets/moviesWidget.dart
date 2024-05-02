import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/details.dart';
import 'package:testapp/models/movie.dart';

class MoviesWidget extends StatelessWidget{
  
  final List<Movie> movies;
  
  MoviesWidget({required this.movies});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(  //This is the logic for displaying each movie in the list. It does this based on the information found in Movie.dart
      itemCount: movies.length, 
      itemBuilder: (context, index) {

        final movie = movies[index];

        return ListTile(
          title: Row(children: [
            SizedBox(
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(movie.poster))
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(movie.title),
                  Text(movie.year)
                ],),
              ),
            )
          ],),
          onTap: () {
            String todos = movie.imdbId;
            Navigator.push(context, MaterialPageRoute(builder: (context) => new Details(imid: todos)));
          }
        );
      }
    );

  }


}