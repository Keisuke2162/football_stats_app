// 試合のスタッツモデル
class MatchDetailData {
  MatchStatics homeTeamData;
  MatchStatics awayTeamData;

  MatchDetailData(this.homeTeamData, this.awayTeamData);
}

class MatchStatics {
  List<Statistic> statistics;
  
  MatchStatics(this.statistics);

  factory MatchStatics.fromJson(Map<String, dynamic> json) {

    List<dynamic> statisticsData = json['statistics'];

    List<Statistic> statisticList = statisticsData.map((i) => new Statistic.fromJson(i)).toList();

    return MatchStatics(
      statisticList
    );
  }
}

class Statistic {
  String type;
  dynamic value;
  
  Statistic(this.type, this.value);

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(json['type'], json['value']);
  }
}
