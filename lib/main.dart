import 'package:flutter/material.dart';
import 'package:football_stats_app/manager/api_manager.dart';
import 'package:football_stats_app/page/score_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FootballApp(),
    );
  }
}

class FootballApp extends StatefulWidget {
  @override
  _FootballAppState createState() => _FootballAppState();
}

class _FootballAppState extends State<FootballApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Score",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: FutureBuilder(
        future: FootballApi()
          .getMatchesThisMonth(),

        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ScorePage(snapshot.data);
            // return Text("Success");
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}