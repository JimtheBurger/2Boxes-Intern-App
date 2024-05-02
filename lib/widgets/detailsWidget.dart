import 'package:flutter/material.dart';
import 'package:testapp/models/detail.dart';

class DetailsWidget extends StatelessWidget{
  
  final Detail details;
  
  DetailsWidget({required this.details});

  @override
  Widget build(BuildContext context) {  //This handles the logic for how the details display

    return ListView(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter:
                  ColorFilter.mode(Colors.grey.shade300, BlendMode.screen),
              fit: BoxFit.cover,
              image: NetworkImage(details.poster),  //used a background poster to have something more intersting than white but something that is different with each poster
            ),
          ),
          child: Stack(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.8,
              ),
              Positioned.fill(
                bottom: 40,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(details.poster),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    height: MediaQuery.of(context).size.height / 2.7,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ),
              Positioned.fill(
                top: 10,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      details.title,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontWeight: FontWeight.w600, fontSize: 48),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 2.0,
            ),
            child: Text(
              details.imdbRating,
              style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Padding(  //Lots of Copy/Pasting was done here. Feels like there could be a better implementation
          padding: EdgeInsets.only(left: 20.0, top: 15),
          child: Text(
            'Plot',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
          child: Text(details.plot),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20.0, top: 15),
          child: Text(
            'Details',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Year : '),
              Text(details.year),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Language : '),
              Text(details.language)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Runtime : '),
              Text(details.runtime)
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20.0, top: 15),
          child: Text(
            'Genre',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
          child: Text(details.genre),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
          child: Text(
            'Ratings',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('IMDB : '),
              Text(details.imdbRating == 'N/A'
                  ? 'No Information'
                  : details.imdbRating),
              Text(' ( ${details.imdbVotes} votes )'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('MetaScore : '),
              Text(details.metascore == 'N/A' ? 'Not rated' : details.metascore)
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20.0, top: 15),
          child: Text(
            'Cast',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
          child: Text(details.actors),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20.0, top: 15),
          child: Text(
            'Director',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
          child: Text(details.director),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20.0, top: 15),
          child: Text(
            'Writer',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
          child: Text(details.writer),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20.0, top: 15),
          child: Text(
            'Additional Information',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, top: 15, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[Text('Released : '), Text(details.released)],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[Text('Language : '), Text(details.language)],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Rated : '),
              Text(details.rated == 'N/A' ? 'No Information' : details.rated)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[Text('Country : '), Text(details.country)],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Awards : '),
              Expanded(
                  child: Text(
                      details.awards == 'N/A' ? 'No Information' : details.awards))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('DVD : '),
              Text(details.dvd == 'N/A' ? 'No Information' : details.dvd)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Box Office : '),
              Text(
                  details.boxOffice == 'N/A' ? 'No Information' : details.boxOffice)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Production : '),
              Text(details.production == 'N/A'
                  ? 'No Information'
                  : details.production)
            ],
          ),
        ),
        SizedBox(
          height: 8,
        )
      ],
    );

  }


}