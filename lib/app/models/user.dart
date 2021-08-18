class User {
  String gender;
  String name;
  String city;
  String country;
  String picture;

  User({
    required this.gender,
    required this.name,
    required this.city,
    required this.country,
    required this.picture,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      gender: parsedJson["gender"],
      name:
          '${parsedJson["name"]["title"]} ${parsedJson["name"]["first"]} ${parsedJson["name"]["last"]}',
      city: parsedJson["location"]["city"],
      country: parsedJson["location"]["country"],
      picture: parsedJson["picture"]["large"],
    );
  }
}
