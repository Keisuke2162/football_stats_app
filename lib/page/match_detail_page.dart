import 'package:flutter/material.dart';
import 'package:football_stats_app/manager/api_manager.dart';
import 'package:football_stats_app/match_tile.dart';
import 'package:football_stats_app/model/fixture_model.dart';
import 'package:football_stats_app/model/match_event_model.dart';
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

      body: Column(
        children: [
          SizedBox(height: 16.0),
          MatchTile(match),
          MatchInformationView(match: match,),
          /*
          Expanded(
            child:
            FutureBuilder(
              // future: FootballApi().getMatchDetail(fixtureId, homeTeamId, awayTeamId),
                future: FootballApi().getMatchEvent(fixtureId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // return MatchDetailPage(snapshot.data, match);
                    return MatchEventPage(
                        snapshot.data, match, homeTeamId, awayTeamId);
                    // return Text("Success GET Fixture Event");
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
            ),
          ),
          */
        ],
      )
      );
  }
}

class MatchInformationView extends StatefulWidget {

  FootballMatch match;
  MatchInformationView({this.match});

  @override
  _MatchInformationView createState() => _MatchInformationView();
}

class _MatchInformationView extends State<MatchInformationView> {

  // 選択中の試合情報番号
  int selectedInfoType = 0;

  @override
  Widget build(BuildContext context) {

    FootballMatch match = widget.match;
    int fixtureId = widget.match.fixture.id;
    int homeTeamId = widget.match.homeTeam.id;
    int awayTeamId = widget.match.awayTeam.id;

    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedInfoType = 0;
                        });
                   }, child: Text("試合経過")),
              ),
              Expanded(
                  child: TextButton(onPressed: () {
                    setState(() {
                      selectedInfoType = 1;
                    });
                  }, child:Text("スタッツ"))
              ),
            ],
          ),

          selectedInfoType == 0
            ? Expanded(
              child: FutureBuilder(
                  future: FootballApi().getMatchEvent(fixtureId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return MatchEventPage(snapshot.data, match, homeTeamId, awayTeamId);
                    } else {
                      return Center(child: CircularProgressIndicator(),);
                    }
                  }
                  ),
            )
          
          : selectedInfoType == 1
              ? Expanded(
                  child: FutureBuilder(
                      future: FootballApi().getMatchDetail(fixtureId, homeTeamId, awayTeamId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return MatchDetailPage(snapshot.data, match);
                    } else {
                      return Center(child: CircularProgressIndicator(),);
                    }
                  }
              ),
          )
              : Text("エラー")
        ],
      ),
    );
  }
}

Widget MatchEventPage(List<MatchEvent> matchEvents, FootballMatch matchData, int homeId, int awayId) {
  return Column(
    children: [
      // SizedBox(height: 16.0),
      // MatchTile(matchData),
      Expanded(
        child: ListView.builder(
          itemCount: matchEvents.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    matchEvents[index].team.id == homeId
                      ? Expanded(child: Text(matchEvents[index].type, textAlign: TextAlign.end,))
                      : Expanded(child: Text("", textAlign: TextAlign.end,)),

                    Expanded(child: Text(matchEvents[index].time.elapsed.toString(), textAlign: TextAlign.center,)),

                    matchEvents[index].team.id == awayId
                      ? Expanded(child: Text(matchEvents[index].type, textAlign: TextAlign.start,))
                      : Expanded(child: Text("", textAlign: TextAlign.start,)),

                  ],
                ),
              ],
            );
          }
        ),
      )
    ],
  );
}

Widget MatchDetailPage(MatchDetailData matchDetailData, FootballMatch matchData) {
  return Column(
    children: [
      // SizedBox(height: 16.0),
      // MatchTile(matchData),
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
