class Users {
  final int points;
  final String name;
  final String imageUrl;

  Users({required this.name, required this.points, required this.imageUrl});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json["name"],
      points: json["points"],
      imageUrl: json["imageUrl"],
    );
  }
}
