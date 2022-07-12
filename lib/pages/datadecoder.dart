class Matches {
  final String matchteams;
  final String matchresults;

  Matches({required this.matchteams, required this.matchresults});

  factory Matches.fromJson(Map<String, dynamic> json) {
    return Matches(
        matchteams: json["matchteams"], matchresults: json["matchresults"]);
  }
}
