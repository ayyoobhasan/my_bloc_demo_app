

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/login_model.dart';
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



  Future<LoginResponse> loggedInUser({
    required String userId,
    required String psw,
  }) async {
    final url = Uri.parse("https://dummyjson.com/auth/login");
    print("Calling login API: $url");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "username": userId,
        "password": psw,
      }),
    );
    // "username": "michaelw",
    // "password": "michaelwpass",

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Login success: $data");

      // ✅ Parse into model
      return LoginResponse.fromJson(data);
    } else {
      print("Login failed: ${response.body}");
      throw Exception("Login failed: ${response.body}");
    }
  }

}
