

// user_detail_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/user_model.dart';
import 'user_detail_event.dart';
import 'user_detail_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  UserDetailBloc() : super(UserDetailInitial()) {
    on<FetchUserDetail>(_onFetchUserDetail);
    on<UpdateUserDetail>(_onUpdateUserDetail);
    on<NameChanged>(_onNameChanged);
    on<AddressChanged>(_onAddressChanged);
  }

  Future<void> _onFetchUserDetail(
      FetchUserDetail event, Emitter<UserDetailState> emit) async {
    emit(UserDetailLoading());
    try {
      final url = "https://jsonplaceholder.typicode.com/users/${event.id}";
      final response = await http.get(Uri.parse(url),headers: {
        'Accept': 'application/json',
        'User-Agent': 'FlutterApp/1.0'
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        User user = User.fromJson(data);
        emit(UserDetailLoaded(user));
      } else {
        emit(UserDetailError("Failed to load user detail"));
      }
    } catch (e) {
      emit(UserDetailError(e.toString()));
    }
  }

  Future<void> _onUpdateUserDetail(
      UpdateUserDetail event, Emitter<UserDetailState> emit) async {
    emit(UserDetailLoading());
    try {
      final response = await http.put(
        Uri.parse("https://jsonplaceholder.typicode.com/users/${event.id}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": event.name,
          "email": event.email,
          "address": {"street": event.address}
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final updatedUser = User.fromJson(data);
        emit(UserDetailUpdated(updatedUser));
      } else {
        emit(UserDetailError("Failed to update user"));
      }
    } catch (e) {
      emit(UserDetailError(e.toString()));
    }
  }

  void _onNameChanged(NameChanged event, Emitter<UserDetailState> emit) {
    if (state is UserDetailLoaded) {
      final current = state as UserDetailLoaded;
      final updatedUser = current.user.copyWith(name: event.name);
      emit(
        current.copyWith(
          user: updatedUser,
          isChanged: event.name != current.user.name || updatedUser.address?.street != current.user.address?.street,
        ),
      );
    }
  }

  void _onAddressChanged(AddressChanged event, Emitter<UserDetailState> emit) {
    if (state is UserDetailLoaded) {
      final current = state as UserDetailLoaded;
      final updatedUser = current.user.copyWith(
        address: current.user.address?.copyWith(street: event.address),
      );
      emit(
        current.copyWith(
          user: updatedUser,
          isChanged: event.address != current.user.address?.street || updatedUser.name != current.user.name,
        ),
      );
    }
  }
}

