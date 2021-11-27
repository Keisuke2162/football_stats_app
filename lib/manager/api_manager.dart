import 'dart:convert';

import 'package:football_stats_app/manager/date_manager.dart';
import 'package:football_stats_app/model/match_statistics_model.dart';
import 'package:http/http.dart';
import 'package:football_stats_app/model/fixture_model.dart';

class FootballApi {
  final String url = "https://v3.football.api-sports.io/fixtures?season=2021&league=39";
  final String statisticsUrl = "https://v3.football.api-sports.io/fixtures/statistics/";

  static const headers = {
    'x-rapidapi-host': "v3.football.api-sports.io",
    'x-rapidapi-key': "53110f892335ebb2b23428672aca5826"
  };

  Future<List<FootballMatch>> getMatchesThisMonth() async {
    DateManager dateManager = DateManager();
    DateTime firstDate = dateManager.firstDate();
    String firstDateStr = dateManager.dateString(firstDate);

    DateTime lastDate = dateManager.lastDate();
    String lastDateStr = dateManager.dateString(lastDate);

    final String  newUrl = url + "&from=" + firstDateStr + "&to=" + lastDateStr;

    Response res = await get(newUrl, headers: headers);
    var body;

    if(res.statusCode == 200) {
      body = jsonDecode(res.body);
      List<dynamic> matchList = body['response'];

      // print("API Response: ${body}");

      List<FootballMatch> matches = matchList
          .map((dynamic item) => FootballMatch.fromJson(item))
          .toList();

      return matches;
    }
  }

  // ホーム、アウェイクラブの試合詳細データを取得
  Future<MatchDetailData> getMatchDetail(int fixtureId, int homeTeamId, int awayTeamId) async {

    List<Future<MatchStatics>> futureList = [];
    futureList = [];

    var homeStatics = await getMatchStatics(fixtureId, homeTeamId);
    var awayStatics = await getMatchStatics(fixtureId, awayTeamId);

    MatchDetailData matchData = MatchDetailData(homeStatics, awayStatics);
    return matchData;
  }

  // 1チームの特定の試合のスタッツを取得
  Future<MatchStatics> getMatchStatics(int fixtureId, int teamId) async {
    final String  newUrl = statisticsUrl + "?fixture=" + "${fixtureId}" + "&team=" + "${teamId}";

    Response res = await get(newUrl, headers: headers);
    var body;

    if(res.statusCode == 200) {

      body = jsonDecode(res.body);

      dynamic matchData = body['response'][0];

      print("API Response: ${matchData}");

      MatchStatics matchStaticsData = MatchStatics.fromJson(matchData);

      return matchStaticsData;
    }
  }


  Future<List<FootballMatch>> getAllMatches() async {
    Response res = await get(url, headers: headers);
    var body;

    if(res.statusCode == 200) {
      body = jsonDecode(res.body);
      List<dynamic> matchList = body['response'];

      // print("API Response: ${body}");

      List<FootballMatch> matches = matchList
          .map((dynamic item) => FootballMatch.fromJson(item))
          .toList();

      return matches;
    }
  }
}

