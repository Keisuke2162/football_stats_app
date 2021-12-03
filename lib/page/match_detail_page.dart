import 'package:flutter/material.dart';
import 'package:football_stats_app/manager/api_manager.dart';
import 'package:football_stats_app/match_tile.dart';
import 'package:football_stats_app/model/fixture_model.dart';
import 'package:football_stats_app/model/match_statistics_model.dart';

class MatchDetailBuilderWidget extends StatelessWidget {

  MatchDetailBuilderWidget(this.match);
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
        // future: FootballApi().getMatchDetail(fixtureId, homeTeamId, awayTeamId),
        future: FootballApi().getMatchEvent(fixtureId),

        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return MatchDetailPage(snapshot.data, match);

            return Text("Success GET Fixture Event");
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

Widget MatchDetailPage(MatchDetailData matchDetailData, FootballMatch matchData) {
  return Column(
    children: [
      SizedBox(height: 16.0),
      MatchTile(matchData),
      Expanded(
          child: ListView.builder(
              itemCount: matchDetailData.homeTeamData.statistics.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Text(matchDetailData.homeTeamData.statistics[index].value.toString(), textAlign: TextAlign.end,)),
                        Expanded(child: Text(matchDetailData.homeTeamData.statistics[index].type, textAlign: TextAlign.center,)),
                        Expanded(child: Text(matchDetailData.awayTeamData.statistics[index].value.toString(), textAlign: TextAlign.start,))
                      ],
                    )
                  ],
                );//Text(matchData.homeTeamData.statistics[index].type);
              }
          )
      )
    ],
  );
}

/*
child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: allmatches.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: matchTile(allmatches[index]),
                        onTap: () {
                          print("試合カードタップ：id ${allmatches[index].fixture.id}, hometeam ${allmatches[index].homeTeam.name}");
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MatchDetailBuilderWidget(allmatches[index])),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
 */