class Matches {
  final String matchteams;
  final String matchDate;
  final String matchTime;

  Matches({required this.matchteams, required this.matchDate,required this.matchTime});

  factory Matches.fromJson(Map<String, dynamic> json) {
    return Matches(
        matchteams: json["matchteams"],
        matchDate: json["matchDate"],
        matchTime: json["matchTime"]);
  }
}
