class MatchDetailData {
  MatchStatics homeTeamData;
  MatchStatics awayTeamData;

  MatchDetailData(this.homeTeamData, this.awayTeamData);
}

class MatchStatics {
  List<Statistic> statistics;
  
  MatchStatics(this.statistics);

  factory MatchStatics.fromJson(Map<String, dynamic> json) {
    return MatchStatics(json['statistics']);
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
