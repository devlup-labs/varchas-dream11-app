class Match {
  final String sport;
  final String team1;
  final String team2;
  final String date;
  final String startTime;

  Match({
    required this.sport,
    required this.team1,
    required this.team2,
    required this.date,
    required this.startTime,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      sport: json["sport"],
      team1: json["college1"],
      team2: json["college2"],
      date: json["date"],
      startTime: json["startTime"],
    );
  }
}
