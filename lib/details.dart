import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/models/detail.dart';
import 'package:testapp/widgets/detailsWidget.dart';

class Details extends StatefulWidget {
  final String imid;
  const Details({super.key, required this.imid});

  @override
  _Details createState() => _Details();
}

class _Details extends State<Details> {

  @override
  void initState() {
    super.initState();
    _populateAllDetails();
  }

  @override
  Widget build(BuildContext context) {  //much start, is essentially the home poage, but used for the details page which is a seperate page and api call regarding more details. No fancy searches or title
    return MaterialApp(
      home: Scaffold(
        body: DetailsWidget(details: _details)
        //body: Text(_details.plot)
      )
    );
  }

  void _populateAllDetails() async {
    final details = await _fetchAllDetails();
    setState(() { 
      _details = details;
    });
  }

  Detail _details = Detail(
    title: '', year: '', rated: '', released: '', runtime: '', genre: '', director: '', writer: '', actors: '', plot: '', language: '', country: '', awards: '', poster: '', metascore: '', imdbRating: '', imdbVotes: '', imdbID: '', type: '', dvd: '', boxOffice: '', production: '', website: '', response: ''
  );

  Future<Detail> _fetchAllDetails() async {
    String id = widget.imid;
    final response = await http.get(Uri.parse("https://www.omdbapi.com/?i=$id&apikey=f509691a"));

    if(response.statusCode == 200){
      Map<String, dynamic> data = jsonDecode(response.body);
      Detail detail = Detail.fromJson(data);
      return detail;
    } else {
      throw Exception("[Failed to load details]");
    }
  }
}