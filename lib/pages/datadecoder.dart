class Matches {
  final String team1;
  final String team2;
  final String date;
  final String time;
  final String matchWinner;
  final String team1Logo;
  final String team2Logo;
  final String pointsEarned;
  final String event;
  final String scoreDifference;

  Matches({
    required this.team1,
    required this.team2,
    required this.date,
    required this.time,
    required this.matchWinner,
    required this.team1Logo,
    required this.team2Logo,
    required this.pointsEarned,
    required this.scoreDifference,
    required this.event,
  });

  factory Matches.fromJson(Map<String, dynamic> json) {
    return Matches(
      scoreDifference: json["scoreDifference"],
      pointsEarned: json["pointsEarned"],
      team1: json["team1"],
      team2: json["team2"],
      date: json["matchDate"],
      time: json["matchTime"],
      matchWinner: json["matchWinner"],
      team1Logo: json["team1Logo"],
      team2Logo: json["team2Logo"],
      event: json["sport"]
    );
  }
}
