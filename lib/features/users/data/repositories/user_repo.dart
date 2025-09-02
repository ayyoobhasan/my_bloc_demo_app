


import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_bloc_app/features/users/data/model/user_list.dart';

import '../model/login_model.dart';
import '../model/user_model.dart';
import 'api_providers.dart';

class UserRepository {
  final UserApiProvider _apiProvider = UserApiProvider();

  Future<List<User>> getUsers() {
    return _apiProvider.fetchUsers();
  }

  Future<LoginResponse> loginUsers(String userId,String psw,) {
    return _apiProvider.loggedInUser(userId: userId,psw: psw);
  }


  Future<PaginatedResponse>  getListUsers(int page) {
    return _apiProvider.fetchListUsers(page);
  }

}