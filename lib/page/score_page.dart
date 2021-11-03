import 'package:flutter/material.dart';
import 'package:football_stats_app/match_tile.dart';
import 'package:football_stats_app/model/fixture_model.dart';
import 'package:football_stats_app/page/match_detail_page.dart';

Widget ScorePage(List<FootballMatch> allmatches) {
  return Column(
    children: [
      Expanded(
        flex: 5,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
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
                              MaterialPageRoute(builder: (context) => MatchDetailPage(allmatches[index])),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      )
    ],
  );
}