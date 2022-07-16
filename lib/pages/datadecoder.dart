class Matches {
  final String team1;
  final String team2;
  final String matchDate;
  final String matchTime;
  final String matchResults;
  final String team1Logo;
  final String team2Logo;
  final String pointsEarned;

  Matches({
    required this.team1,
    required this.team2,
    required this.matchDate,
    required this.matchTime,
    required this.matchResults,
    required this.team1Logo,
    required this.team2Logo,
    required this.pointsEarned
  });

  factory Matches.fromJson(Map<String, dynamic> json) {
    return Matches(
      pointsEarned: json["pointsEarned"],
      team1: json["team1"],
      team2: json["team2"],
      matchDate: json["matchDate"],
      matchTime: json["matchTime"],
      matchResults: json["matchResults"],
      team1Logo: json["team1Logo"],
      team2Logo: json["team2Logo"]
    );
  }
}
