import 'package:flutter/material.dart';
import 'package:football_stats_app/manager/date_manager.dart';
import 'package:football_stats_app/model/fixture_model.dart';

Widget matchTile(FootballMatch match) {
  var homeGoal = match.goal.home ?? 0;
  var awayGoal = match.goal.away ?? 0;
  final dateManager = DateManager();
  final kickoffTime = dateManager.sentTimeFormat(match.fixture.date);
  final kickoffDate = dateManager.sentDateFormat(match.fixture.date);
  var isFinished = (match.fixture.status.long == "Match Finished");

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        kickoffDate,

      ),
      Container(
        height: 104,
        color: Colors.indigo,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                match.homeTeam.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),

            Image.network(
              match.homeTeam.logoUrl,
              width: 48.0,
            ),

            Expanded(
              child: isFinished?
              Text(
                "${homeGoal} - ${awayGoal}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ) :
              Text(
                "${kickoffTime}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              )
            ),

            Image.network(
              match.awayTeam.logoUrl,
              width: 48.0,
            ),

            Expanded(
              child: Text(
                match.awayTeam.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 16.0),
    ],
  );
}