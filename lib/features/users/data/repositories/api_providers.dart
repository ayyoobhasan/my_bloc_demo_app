

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/user_model.dart';


class UserApiProvider {

  Future<List<User>> fetchUsers() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
      headers: {
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      print("data is>>>>>>>>>>>>>>>>>>> $data");
      List<User> users = data.map((json) => User.fromJson(json)).toList();
      return users;
    } else {
      throw Exception("Failed to load users: ${response.statusCode}");
    }
  }
}
