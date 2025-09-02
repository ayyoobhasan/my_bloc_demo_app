


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_app/features/users/pagination_bloc/pagination_event.dart';
import 'package:my_bloc_app/features/users/pagination_bloc/pagination_user_state.dart';

import '../data/model/user_list.dart';
import '../data/repositories/user_repo.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserRepository repository;

  UserListBloc(this.repository) : super(UserListInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserListState> emit) async {
    try {
      // if first load
      if (state is UserListInitial) {
        emit(UserListLoading());
        final response = await repository.getListUsers(event.page);
        emit(UserListLoaded(
          users: response.users,
          hasMore: event.page < response.totalPages,
          page: event.page,
        ));
      }
      // if already loaded, append more
      else if (state is UserListLoaded) {
        final currentState = state as UserListLoaded;

        emit(UserListLoaded(
          users: currentState.users,
          hasMore: currentState.hasMore,
          page: currentState.page,
          isLoadingMore: true,
        ));

        final response = await repository.getListUsers(event.page);

        emit(UserListLoaded(
          users: [...currentState.users, ...response.users],
          hasMore: event.page < response.totalPages,
          page: event.page,
        ));
      }
    } catch (e) {
      emit(UserListError(e.toString()));
    }
  }
}


/*class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserRepository repository;

  UserListBloc(this.repository) : super(UserListData(users: [], hasMore: true, page: 0, isFirstFetch: true)) {
    on<FetchUsers>((event, emit) async {
      try {
        final currentState = state as UserListData;

        // If paginating, mark isLoadingMore
        if (!currentState.isFirstFetch) {
          emit(currentState.copyWith(isLoadingMore: true));
        }

        final response = await repository.getListUsers(event.page);

        emit(UserListData(
          users: [...currentState.users, ...response.users],
          hasMore: event.page < response.totalPages,
          page: event.page,
          isFirstFetch: false,
        ));
      } catch (e) {
        emit(UserListError(e.toString()));
      }
    });
  }
}*/

