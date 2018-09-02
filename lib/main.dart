import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:you_suck_at_cooking_yt/videocell.dart';

void main() => runApp(new CookingWorldApp());

class CookingWorldApp extends StatefulWidget {
  @override
  _CookingWorldAppState createState() => _CookingWorldAppState();
}

class _CookingWorldAppState extends State<CookingWorldApp> {
  bool _isLoading = true;

  var videos;

  void _fetchData() async {
    print("Attempting to fetch data from the Internet");
    final String url = "https://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final videoJson = map["videos"];
      setState(() {
        _isLoading = false;
        this.videos = videoJson;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: Scaffold(
            appBar: AppBar(
              title: Text("You Suck At Cooking"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    _fetchData();
                  },
                )
              ],
            ),
            body: Center(
              child: _isLoading
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      itemCount: this.videos != null ? this.videos.length : 0,
                      itemBuilder: (context, i) {
                        final video = this.videos[i];
                        return FlatButton(
                          child: VideoCell(video),
                          onPressed: (){
                            Navigator.push(context, 
                            MaterialPageRoute(
                              builder: (context) => Text("Undo Not on Hundo")
                            )
                          );
                          },
                        );
                      },
                    ),
            )));
  }
}
