import 'dart:convert';

import 'package:flutter_swipable_example/app/models/user.dart';
import 'package:http/http.dart' as http;

class UsersApiProvider {
  final _client = http.Client();

  Future<List<User>> getUsers({int num = 5}) async {
    final response =
        await http.get(Uri.parse('https://randomuser.me/api/?results=$num'));
    if (response.statusCode == 200) {
      final users = <User>[];
      final parsedResults = jsonDecode(response.body);
      (parsedResults["results"] as List).forEach((parsedJson) {
        users.add(User.fromJson(parsedJson));
      });

      return users;
    } else {
      print("Nah");
      return [];
    }
  }
}
