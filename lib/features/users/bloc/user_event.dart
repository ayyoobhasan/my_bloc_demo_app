import '../data/model/user_model.dart';

abstract class UserEvent {}

class FetchUsers extends UserEvent {}
class UpdateUserInList extends UserEvent {
  final User updatedUser;
  UpdateUserInList(this.updatedUser);
}