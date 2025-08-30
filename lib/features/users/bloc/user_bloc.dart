

import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/user_model.dart';
import '../data/repositories/user_repo.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final List<User> users = await userRepository.getUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<UpdateUserInList>((event, emit) {
      if (state is UserLoaded) {
        final currentState = state as UserLoaded;
        final updatedUsers = currentState.users.map((u) {return u.id == event.updatedUser.id ? event.updatedUser : u;}).toList();

        emit(UserLoaded(updatedUsers));
      }
    });
  }


}
