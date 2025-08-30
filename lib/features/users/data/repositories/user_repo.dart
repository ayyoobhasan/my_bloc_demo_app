


import '../model/user_model.dart';
import 'api_providers.dart';

class UserRepository {
  final UserApiProvider _apiProvider = UserApiProvider();

  Future<List<User>> getUsers() {
    return _apiProvider.fetchUsers();
  }
}