// 試合の経過情報モデル
class FixtureEvent {
  List<MatchEvent> matchEventList;

  FixtureEvent(this.matchEventList);

  factory FixtureEvent.fromJson(Map<String, dynamic> json) {
    List<dynamic> eventData = json[''];
    print("テスト：${eventData}");
    List<MatchEvent> eventList = eventData.map((i) => new MatchEvent.fromJson(i)).toList();

    return FixtureEvent(eventList);
  }

}
class MatchEvent {
  EventTime time;
  EventTeam team;
  EventPlayer player;
  EventPlayer assistPlayer;
  String type;
  String detail;
  String comments;

  MatchEvent(this.time, this.team, this.player, this.assistPlayer, this.type, this.detail, this.comments);

  factory MatchEvent.fromJson(Map<String, dynamic> json) {
    return MatchEvent(
        EventTime.fromJson(json['time']),
        EventTeam.fromJson(json['team']),
        EventPlayer.fromJson(json['player']),
        EventPlayer.fromJson(json['assist']),
        json['type'],
        json['detail'],
        json['comments']
    );
  }
}

class EventTime {
  int elapsed;
  int extra;
  EventTime(this.elapsed, this.extra);

  factory EventTime.fromJson(Map<String, dynamic> json) {
    return EventTime(json['elapsed'], json['extra']);
  }
}

class EventTeam {
  int id;
  String name;
  String logo;
  EventTeam(this.id, this.name, this.logo);

  factory EventTeam.fromJson(Map<String, dynamic> json) {
    return EventTeam(json['id'], json['name'], json['logo']);
  }
}

class EventPlayer {
  int id;
  String name;
  EventPlayer(this.id, this.name);

  factory EventPlayer.fromJson(Map<String, dynamic> json) {
    return EventPlayer(json['id'], json['name']);
  }
}