





import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/login_model.dart';
import '../data/repositories/user_repo.dart';
import 'login_even.dart';
import 'login_state.dart';

class LoginUserBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  LoginUserBloc(this.userRepository) : super(LoginUserInitial()) {
    on<LoginButtonClicked>((event, emit) async {
      emit(LoginUserLoading());
      try {
        final LoginResponse loginData = await userRepository.loginUsers(event.userId,event.password);
        print("object log data ${loginData.firstName}");
        emit(LoginUserLoaded(loginData));

      } catch (e) {
        print("object log data $e");
        emit(LoginUserError(e.toString()));
      }
    });
  }

  // LoginUserBloc() : super(LoginUserInitial()) {
  //   on<LoginButtonClicked>(_onLoginUser);
  // }

  // Future<void> _onLoginUser(
  //     LoginButtonClicked event, Emitter<LoginState> emit) async {
  //   emit(LoginUserLoading());
  //
  //   try {
  //     // simulate API call
  //
  //     final loginData = {"userId": event.userId}; // dummy data
  //
  //     emit(LoginUserLoaded(loginData));
  //   } catch (e) {
  //     emit(LoginUserError(e.toString()));
  //   }
  // }


}