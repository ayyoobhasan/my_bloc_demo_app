

abstract class UserListEvent {}

class FetchUsers extends UserListEvent {
  final int page;
  FetchUsers(this.page);
}