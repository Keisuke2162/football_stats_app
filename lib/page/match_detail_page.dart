import 'package:flutter/material.dart';
import 'package:football_stats_app/manager/api_manager.dart';
import 'package:football_stats_app/model/fixture_model.dart';
import 'package:football_stats_app/model/match_statistics_model.dart';

class MatchDetailPage extends StatelessWidget {

  MatchDetailPage(this.match);
  FootballMatch match;

  @override
  Widget build(BuildContext context) {
    int fixtureId = match.fixture.id;
    int homeTeamId = match.homeTeam.id;
    int awayTeamId = match.awayTeam.id;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Match",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: FutureBuilder(
        future: FootballApi().getMatchDetail(fixtureId, homeTeamId, awayTeamId),

        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return ScorePage(snapshot.data);
            return Text("Success");
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