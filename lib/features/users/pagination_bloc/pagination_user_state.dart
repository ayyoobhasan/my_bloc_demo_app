


import 'package:my_bloc_app/features/users/data/model/user_list.dart';

abstract class UserListState {}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final List<UserList> users;
  final bool hasMore;
  final int page;
  final bool isLoadingMore;

  UserListLoaded({
    required this.users,
    required this.hasMore,
    required this.page,
    this.isLoadingMore = false,
  });
}



class UserListData extends UserListState {
  final List<UserList> users;
  final bool hasMore;
  final int page;
  final bool isLoadingMore;
  final bool isFirstFetch;

  UserListData({
    required this.users,
    required this.hasMore,
    required this.page,
    this.isLoadingMore = false,
    this.isFirstFetch = false,
  });

  UserListData copyWith({
    List<UserList>? users,
    bool? hasMore,
    int? page,
    bool? isLoadingMore,
    bool? isFirstFetch,
  }) {
    return UserListData(
      users: users ?? this.users,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isFirstFetch: isFirstFetch ?? this.isFirstFetch,
    );
  }
}

class UserListError extends UserListState {
  final String message;
  UserListError(this.message);
}

