
class PaginatedResponse {
  final List<UserList> users;
  final int totalPages;

  PaginatedResponse({required this.users, required this.totalPages});
}
class UserList {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  UserList({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory UserList.fromJson(Map<String, dynamic> json) {
    return UserList(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}