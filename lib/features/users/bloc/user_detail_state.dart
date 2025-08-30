

import 'package:equatable/equatable.dart';
import 'package:my_bloc_app/features/users/data/model/user_model.dart';

abstract class UserDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserDetailInitial extends UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailLoaded extends UserDetailState {
  final User user;
  final bool isChanged;

  UserDetailLoaded(this.user, {this.isChanged = false});

  UserDetailLoaded copyWith({
    User? user,
    bool? isChanged,
  }) {
    return UserDetailLoaded(
      user ?? this.user,
      isChanged: isChanged ?? this.isChanged,
    );
  }

  @override
  List<Object?> get props => [user, isChanged];
}

class UserDetailUpdated extends UserDetailState {
  final User updatedUser;
  UserDetailUpdated(this.updatedUser);

  @override
  List<Object?> get props => [updatedUser];
}

class UserDetailError extends UserDetailState {
  final String message;
  UserDetailError(this.message);

  @override
  List<Object?> get props => [message];
}


