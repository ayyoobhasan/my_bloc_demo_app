


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
}