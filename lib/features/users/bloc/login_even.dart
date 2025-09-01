
import 'package:equatable/equatable.dart';
abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginButtonClicked extends LoginEvent {
  final String userId;
  final String password;

  LoginButtonClicked({required this.userId, required this.password});

  @override
  List<Object?> get props => [userId, password];
}

